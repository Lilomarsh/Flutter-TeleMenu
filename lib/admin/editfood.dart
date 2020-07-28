import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proj_nine/admin/editItem.dart';
import 'package:proj_nine/models/item.dart';
import 'package:proj_nine/mywidgets/addeditmenu.dart';
import 'package:proj_nine/sevices/storage.dart';
import '../constants.dart';

class EditFood extends StatefulWidget{
  static String id= 'EditFood';

  @override
  _EditFoodState createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  final _storage = Storage();


  @override
  Widget build(BuildContext) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
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

            return GridView.builder
              (
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio:.8,
              ),
              itemBuilder: (context, index) =>Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: GestureDetector(
                  onTapUp: (details)
                  {
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx2 = MediaQuery.of(context).size.width - dx;
                    double dy2 = MediaQuery.of(context).size.width - dy;


                    showMenu(context: context, position: RelativeRect.fromLTRB(dx, dy, 100, 100), items: [
                      menuItem(
                        onClick: ()
                        {
                         Navigator.pushNamed(context, EditItem.id, arguments: items[index]);
                        },
                        child: Text('Edit Menu'),
                      ),
                      menuItem(
                        onClick: ()
                        {
                         _storage.deleteItem(items[index].fId);
                         Navigator.pop(context);

                        },
                        child: Text('Delete Item'),

                      ),
                    ]);
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
                          opacity: .9,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 70,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(items[index].fName),Text('\$ ${items[index].fPrice}', )
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
      ),
    );
  }
}

