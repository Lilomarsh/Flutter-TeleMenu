import 'package:flutter/material.dart';
import 'package:proj_nine/func.dart';
import 'package:proj_nine/models/item.dart';
import 'package:proj_nine/screens/users/Itemdata.dart';
Widget itemTab( String fType, List<Item> allItems )
{
  List<Item>items;
  items= getFoodbytype(fType, allItems);
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
}