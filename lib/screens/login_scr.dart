import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_nine/admin/adminMain.dart';
import 'package:proj_nine/constants.dart';
import 'package:proj_nine/mywidgets/customtextarea.dart';
import 'package:proj_nine/provider/adminType.dart';
import 'package:proj_nine/provider/modelHud.dart';
import 'package:proj_nine/screens/signup_scr.dart';
import 'package:proj_nine/sevices/auth';
import 'package:proj_nine/screens/users/homePage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  String _email, password;
  final _auth = Auth();
  final GlobalKey<FormState> _firstKey = GlobalKey<FormState>();
  final adminPass='adminadmin';
  bool isAdmin = false;

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
                    onClick: (value) {//function
                      _email = (value);
                    },
                    hint: 'Enter your email',
                    icon: Icons.email,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomTextArea(
                    onClick: (value) {
                      password = value;
                    },
                    hint: 'Enter your password',
                    icon: Icons.lock,
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Builder(
                      builder:(context) => FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onLongPress: () async
                        {
                          _loginlogic(context);
                        },
                        color: Colors.amber,
                        child: Text(
                          'login',
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
                        'Don\'t have an account ?',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignupPage.id);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: GestureDetector(
                              onTap: ()
                              {
                                Provider.of<AdminType>(context,listen:false).changeIsAdmin(true);
                              },
                              child: Text(
                                  'I\'m a Admin',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:Provider.of<AdminType>(context).isAdmin? kMainColor: Colors.white
                                ),
                              ),
                            ),
                          ),

                        Expanded(
                          child: GestureDetector(
                            onTap: ()
                            {
                              Provider.of<AdminType>(context,listen:false).changeIsAdmin(false);
                            }
                            ,
                            child: Text(
                                'I\'m a User',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:Provider.of<AdminType>(context).isAdmin? Colors.white :kMainColor
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }

  void _loginlogic(BuildContext context) async {
    {
      final modelhud = Provider.of<ModelHud>(context, listen: false);
      modelhud.changeisLoading(true);
      if (_firstKey.currentState.validate()) {
        _firstKey.currentState.save();
        if (Provider.of<AdminType>(context, listen: false)
            .isAdmin) {
          if (password == adminPass) {
            try {
              await _auth.signIn(_email, password);
              Navigator.pushNamed(context, AdminPage.id);
            } catch (e) {
              modelhud.changeisLoading(false);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(e.message),
              ));
            }
          } else {
            modelhud.changeisLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('There is an error!'),
            ));
          }
        } else {
          try {
           await  _auth.signIn(_email, password);
            Navigator.pushNamed(context, HomePage.id);
          } catch (e) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        }
      }
      modelhud.changeisLoading(false);
    }
  }
}
