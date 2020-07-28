
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:proj_nine/constants.dart';
import 'package:proj_nine/models/item.dart';
import 'package:proj_nine/mywidgets/addeditmenu.dart';
import 'package:proj_nine/provider/tableorder.dart';
import 'package:proj_nine/screens/users/Itemdata.dart';
import 'package:proj_nine/sevices/storage.dart';
import 'package:provider/provider.dart';

class Mytable extends StatelessWidget{
  static String id='MyTable';
  @override
  Widget build(BuildContext context){
    List<Item> items = Provider.of<TableOrder>(context).items;
   final double pageHeight = MediaQuery.of (context).size.height;
   final double pageWidth = MediaQuery.of (context).size.height;
   final double appbarheight = AppBar().preferredSize.height;
   final double statusappbar = MediaQuery.of(context).padding.top;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: ()
          {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text('My Orders',
        style: TextStyle(color:Colors.black),

        ),
      ),
      body: Column(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constrains) {
              if (items.isNotEmpty) {
                return Container(
                  height: pageHeight-
                      statusappbar-
                      appbarheight-(pageHeight*.08),
                  child: ListView.builder(itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTapUp: (details)
                        {
                          viewMenu(details, context, items[index]);
                        },
                        child: Container(
                          height: pageHeight * .15,
                          child: Row(
                            children: <Widget>
                            [CircleAvatar(

                                backgroundImage: AssetImage(items[index].fImg),
                                radius: pageHeight * .15 / 2,
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 40),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Text(
                                            items[index].fName, style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),),
                                          Text('£ ${items[index].fPrice}',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Text(
                                            items[index].fPrice.toString()))
                                  ],

                                ),
                              ),
                            ],
                          ),
                          color: kMainColor,
                        ),
                      ),
                    );
                  },
                    itemCount: items.length,
                  ),
                );
              } else {
                return Container(
                  height: pageHeight-(pageHeight*.08)-appbarheight-statusappbar,
                  child: Center
                    (
                    child:Text('Order Screen Empty') ,
                  ),
                );
              }
            }

          ),
          Builder(

            builder: (context)=> ButtonTheme(

              height: pageHeight*.08,
              minWidth: pageWidth,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.white)),
                onPressed: ()
                {
                  orderConfim(items, context);
                },
                color: Colors.black,
                child: Text('Order now'),textColor: Colors.white,
              
    ),
            ),
          )

        ],
      ),
    );
  }

  void viewMenu(details, context, item) async
  {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;


    showMenu(context: context, position: RelativeRect.fromLTRB(dx, dy, 100, 100), items: [
      menuItem(
        onClick: ()
        {
          Navigator.pop(context);
          Provider.of<TableOrder>(context, listen: false).deleteItem(item);
          Navigator.pushNamed(context, ItemData.id, arguments:item );
        },
        child: Text('Edit Menu'),
      ),
      menuItem(
        onClick: ()
        {
          Navigator.pop(context);
          Provider.of<TableOrder>(context, listen: false).deleteItem(item);
          Navigator.pushNamed(context, ItemData.id, arguments:item );
        },
        child: Text('Delete Item'),

      ),
    ]);
  }

  void orderConfim(List<Item>items, context)async
  {
    var price = countPrice(items);
    var table ;
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: ()
          {
            try {
              Storage _storage = Storage();
              _storage.orderStorage({
                cTotalBill: price,
                cTableNum: table,


              }, items);
               Scaffold.of(context).showSnackBar(SnackBar(
                content:Text('order is Successful'),
              ));
               Navigator.pop(context);
            }catch(ex)
            {
              print(ex.message);
            }
            },
          child: Text('Confirm Order') ,
        )
      ],
      content: TextField(
        onChanged: (value)
        {
          table=value;
        },
        decoration: InputDecoration(hintText: 'Enter Table Number'),
      ),
      title: Text('Total Price = \$ $price'),


    );
   await showDialog(context: context, builder:(context)
    {
      return alertDialog;

  });
}

  countPrice(List<Item> items) {
    var price = 0;
    for(var item in items)
      {
        price += item.fQuant* int.parse((item.fPrice));
      }
    return price;
  }
}