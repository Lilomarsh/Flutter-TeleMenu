import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_nine/models/item.dart';
import 'package:proj_nine/mywidgets/customtextarea.dart';
import 'package:proj_nine/sevices/storage.dart';


class AddFood extends StatelessWidget {
  static String id='AddFood';
  String _name, _type, _price, _info, _imgplace;
  final GlobalKey<FormState> _firstKey = GlobalKey<FormState>();
  final _storage= Storage();
  @override
  Widget build(BuildContext){
    return Scaffold(
      body: Form(
        key: _firstKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            CustomTextArea(
              hint: 'Food Type',
              onClick: (value)
              {
                _type=value;
              },
            ),

            SizedBox(height: 10,),

            CustomTextArea(
                hint: 'Food Name',
                onClick: (value)
        {
                 _name=value;
        },

            ),
            SizedBox(height: 10,),
            CustomTextArea(
                hint: 'Food Price',
                onClick: (value)
    {
                 _price=value;
    },
            ),
            SizedBox(height: 10,),
            CustomTextArea(
                hint: 'Food Info',
              onClick: (value)
              {
                _info=value;
              },
            ),

            SizedBox(height: 10,),
            CustomTextArea(
              hint: 'Picture Location',
              onClick: (value)
              {
                _imgplace=value;
              },
            ),
            SizedBox(height: 25,),
            RaisedButton(
              onPressed: ()
              {
                if(_firstKey.currentState.validate())
                  {
                    _firstKey.currentState.save();
                    _storage.addMenu(Item(
                      fName: _name,
                      fType: _type,
                      fPrice: _price,
                      fInfo: _info,
                      fImg:_imgplace
                    ));
                  }
              },
                child: Text('Add a new food'),

            )
          ],
        ),
      ),
    );
  }
}