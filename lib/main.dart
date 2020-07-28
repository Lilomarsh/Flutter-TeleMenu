import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_nine/admin/adminMain.dart';
import 'package:proj_nine/admin/editfood.dart';
import 'package:proj_nine/provider/adminType.dart';
import 'package:proj_nine/provider/modelHud.dart';
import 'package:proj_nine/provider/tableorder.dart';
import 'package:proj_nine/screens/signup_scr.dart';
import 'package:proj_nine/screens/login_scr.dart';
import 'package:proj_nine/screens/users/Itemdata.dart';
import 'package:proj_nine/screens/users/homePage.dart';
import 'package:proj_nine/screens/users/mytable.dart';
import 'package:provider/provider.dart';
import 'package:proj_nine/provider/average.dart';
import 'admin/addfood.dart';
import 'admin/editItem.dart';


main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
       ChangeNotifierProvider<ModelHud>(
        create:(context)=>ModelHud(),
       ),
        ChangeNotifierProvider<TableOrder>(
          create:(context)=>TableOrder(),
        ),
        ChangeNotifierProvider<AdminType>(
          create:(context)=>AdminType(),
        ),
        ChangeNotifierProvider<AverageProvider>(
          create:(context)=>AverageProvider(),
        ),
      ],
      child: MaterialApp(
          initialRoute:  LoginScreen.id,
          routes:
          {
            LoginScreen.id : (context)=>LoginScreen(),
            SignupPage.id : (context)=>SignupPage(),
            HomePage.id: (context)=> HomePage(),
            AdminPage.id:(context)=>AdminPage(),
            AddFood.id:(context)=>AddFood(),
            EditFood.id:(context)=>EditFood(),
            EditItem.id:(context)=>EditItem(),
            ItemData.id:(context)=>ItemData(),
            Mytable.id:(context)=>Mytable(),

          },


        ),
    );


  }
}