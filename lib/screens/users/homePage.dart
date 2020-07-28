import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj_nine/admin/editfood.dart';
import 'package:proj_nine/func.dart';
import 'package:proj_nine/models/item.dart';
import 'package:proj_nine/mywidgets/itemTab.dart';
import 'package:proj_nine/screens/users/Itemdata.dart';
import 'package:proj_nine/screens/users/mytable.dart';
import 'package:proj_nine/sevices/auth';
import 'package:proj_nine/sevices/storage.dart';

import '../../constants.dart';

 class HomePage extends StatefulWidget {
   static String id = 'HomePage';

   @override
   _HomeState createState() => _HomeState();
 }
   class _HomeState extends State<HomePage>{
   final _auth = Auth();
   final _storage= Storage();
   FirebaseUser _loggedUser;
   int _tabindex = 0;
   int _navbartab = 0;
   List<Item> _items;
   @override

   Widget build(BuildContext context) {
     return Stack(
       children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type:BottomNavigationBarType.fixed,
              backgroundColor: kMainColor,
              currentIndex: _navbartab,
              onTap: (value)
              {
                setState(() {
                  _navbartab = value;

                });

              },
              items:[
                BottomNavigationBarItem(

                    title: Text('Menu', ),
                    icon: Icon(Icons.menu, color: Colors.yellow)
             ),
                BottomNavigationBarItem(
                    title: Text('Table Scan', ),
                    icon: Icon(Icons.camera_alt, color: Colors.yellow)
                ),
                BottomNavigationBarItem(
                    title: Text('Review'),
                    icon: Icon(Icons.star_half, color: Colors.yellow)

                ),

             ],
            ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              bottom:TabBar(
                indicatorColor: kMainColor,
                onTap: (value)
                {
                  setState(() {
                    _tabindex =value;
                  });

                },
                tabs:<  Widget>[
                  Text('Starters',
                  style:TextStyle (
                  color: _tabindex== 0 ? Colors.black:Colors.brown,
                    fontSize: _tabindex== 0 ? 16:null,
                  ),
                  ),
                  Text('Main Course',
                    style:TextStyle (
                    color: _tabindex== 1 ? Colors.black:Colors.brown,
                    fontSize: _tabindex== 1 ? 16:null,
                  ),),
                  Text('Deserts',
                    style:TextStyle (
                      color: _tabindex== 2 ? Colors.black:Colors.brown,
                      fontSize: _tabindex== 2 ? 16:null,
                    ),),
                  Text('Drinks',
                    style:TextStyle (
                      color: _tabindex== 3 ? Colors.black:Colors.brown,
                      fontSize: _tabindex== 3 ? 16:null,
                    ),
                  ),
              ]
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                starterTab(),
                itemTab(cFoodStarter, _items),
                itemTab(cFoodMain, _items),
                itemTab(cFoodDesert, _items),
                itemTab(cFoodDrinks, _items),
              ],
            ),
          ),
        ),
         Material(
           child: Padding(
             padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
             child: Container(
               height: MediaQuery.of(context).size.height * .07,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget>[
                   Text(
                     'Lalinia Resto'.toUpperCase(),
                     style: TextStyle(fontSize: 20,fontWeight :FontWeight.bold),
                   ),
                   Icon(Icons.restaurant_menu),
                   GestureDetector(
                     onTap: ()
                       {
                         Navigator.pushNamed(context, Mytable.id);
                       },
                       child: Icon(Icons.shopping_basket))
                 ],
               ),
             ),
           ),
         )
       ],
     );
   }
   @override
     void initState(){
     getCurrentUser();
   }
   getCurrentUser() async{
     _loggedUser= await _auth.getUser();
   }

  Widget starterTab()
  {
    return StreamBuilder<QuerySnapshot>(
      stream: _storage.loadItems(),
      builder: (context, snapshot)
      {

        if(snapshot.hasData) {
          List <Item> items = [];
          for (var doc in snapshot.data.documents) {
            var data = doc.data;


              items.add(Item(
                  fPrice: data[cFoodPrice],
                  fName: data[cFoodName],
                  fInfo: data[cFoodInfo],
                  fType: data[cFoodType],
                  fImg: data[cFoodImg],
                  fId: doc.documentID
              ));

          }
        _items = [...items];
          items.clear();
          items = getFoodbytype(cFoodStarter, _items);
          return GridView.builder
            (
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio:.8,
            ),
            itemBuilder: (context, index) =>Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: GestureDetector(
                onTap: ()
                {
                  Navigator.pushNamed(context, ItemData.id, arguments: items[index]);
                },

                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(items[index].fImg),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .5,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(items[index].fName),Text('\£ ${items[index].fPrice}')
                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),

            itemCount: items.length,
          );
        }else
        {
          return Center(child: Text('Please Wait'));
        }
      },
    );
  }



 }

