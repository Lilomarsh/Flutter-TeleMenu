import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proj_nine/models/user.dart';
import 'package:proj_nine/mywidgets/customtextarea.dart';
import 'package:proj_nine/provider/modelHud.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:proj_nine/sevices/auth';
import 'package:proj_nine/screens/login_scr.dart';
import 'package:proj_nine/screens/users/homePage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:proj_nine/sevices/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';






class SignupPage extends StatelessWidget {
  final GlobalKey<FormState> _firstKey = GlobalKey<FormState>();
  static String id = 'SignupPage';
  String _email, _password, _name, _age;

  FirebaseUser userInfo;
  final _auth = Auth();


  void setUserData({email,name,age})async{
    userInfo =await FirebaseAuth.instance.currentUser();
    var documentRef = Firestore.instance.collection(cUserInfo).document('${userInfo.uid}');
    documentRef.setData({
      cUserEmail:_email,
      cUserName:_name,
      cUserAge:_age,
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
          backgroundColor: kMainColor,
          body: ModalProgressHUD(
            inAsyncCall: Provider.of<ModelHud>(context).isLoading,
            child: Form(
              key: _firstKey, //form key
              child: ListView(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('image/icon/logo.png'),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Text(
                                  'TeleMenu',
                                  style: TextStyle(
                                      fontFamily: 'Raleway', fontSize: 25),
                                ),
                              )
                            ],
                          ))),
                  SizedBox(
                    height: height * .1,
                  ),
                  CustomTextArea(
                    onClick: (value)
                    {
                      _name = value;
                    },
                    icon: Icons.perm_identity,
                    hint: 'Enter your name',
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomTextArea(
                    onClick: (value) {
                      _email = value;
                    },
                    hint: 'Enter your email',
                    icon: Icons.email,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomTextArea(
                    onClick: (value) {
                      _age=value;
                    },
                    hint: 'Enter your age',
                    icon: Icons.date_range,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomTextArea(
                    onClick: (value) {
                      _password = value;
                    },
                    hint: 'Enter your password',
                    icon: Icons.lock,
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Builder(
                      builder:(context) => FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () async {
                          final modelhud =Provider.of<ModelHud>(context, listen: false);
                          modelhud.changeisLoading(true);
                          if (_firstKey.currentState.validate()) {
                            _firstKey.currentState.save();
                            try {

                              final authResult = await _auth.signUp(_email, _password,'','');
                              await setUserData();
                              //here reference the function that takes age and
                              modelhud.changeisLoading(false);
                              Navigator.pushNamed(context, HomePage.id);


                            } on PlatformException catch(e)
                              {
                                modelhud.changeisLoading(false);
                                print(e.toString());
                              Scaffold.of(context).showSnackBar(SnackBar(//incase of an exception show the expeption message
                                content: Text(
                                    e.message// e stands for exception
                                ),
                              ));

                              }
                          }
                          modelhud.changeisLoading(false);
                          },
                        color: Colors.amber,
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'I do have an account',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {

                            Navigator.pushNamed(context, LoginScreen.id);




                              },



                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

    );
  }

}
