import 'package:flutter/material.dart';
import 'package:proj_nine/admin/addfood.dart';
import 'package:proj_nine/admin/data_analysis.dart';
import 'package:proj_nine/admin/editfood.dart';
import 'package:proj_nine/constants.dart';
import 'package:provider/provider.dart';
import 'package:proj_nine/provider/average.dart';

class AdminPage extends StatelessWidget {
  static String id = 'AdminPage';

  @override
  Widget build(BuildContext context) {
    final avProvider = Provider.of<AverageProvider>(context);
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: ()
            {
              Navigator.pushNamed(context, AddFood.id);
            },
            child: Text(
              'Add to the menu',
              style: TextStyle(fontFamily: 'Raleway', fontSize: 25),
            ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red))
          ),
          RaisedButton(
            onPressed: ()
            {
              Navigator.pushNamed(context, EditFood.id);
            },
            child: Text(
              'Edit the menu',
              style: TextStyle(fontFamily: 'Raleway', fontSize: 25),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red))
          ),
          RaisedButton(
            onPressed: () {},
            child: Text(
              'View Orders',
              style: TextStyle(fontFamily: 'Raleway', fontSize: 25),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red))
          ),
          RaisedButton(
            onPressed: ()async{
              avProvider.getUsersAge();
              avProvider.getUsersGender();
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=> DataAnalysis()));
            },
            child: Text(
              'Add to the menu',
              style: TextStyle(fontFamily: 'Raleway', fontSize: 25),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red))
          ),
        ],
      ),
    );
  }
}
