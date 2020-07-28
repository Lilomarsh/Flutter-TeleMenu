import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_nine/constants.dart';
import 'package:proj_nine/models/item.dart';
import 'package:proj_nine/provider/tableorder.dart';
import 'package:proj_nine/screens/users/mytable.dart';
import 'package:provider/provider.dart';
class ItemData extends StatefulWidget {
static String id='ItemData';
  @override
  _ItemDataState createState() => _ItemDataState();
}

class _ItemDataState extends State<ItemData> {
  int _quant = 1;
  @override
  Widget build(BuildContext context) {
    Item item= ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit:BoxFit.fill ,
                image: AssetImage(
                  item.fImg),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back
                    ),
                  ),
                  Text(
                    'Lalinia Resto'.toUpperCase(),
                    style: TextStyle(fontSize: 20,fontWeight :FontWeight.bold),
                  ),

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
          Positioned(
            bottom: 0,
            child: Column(
              children: <Widget>[
                Opacity(
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            item.fName, style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20 ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '\$${item.fPrice}', style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20 ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            item.fInfo, style: TextStyle(fontWeight: FontWeight.w800 ,fontSize: 20 ),
                          ),
                          TextField(
                            decoration: new InputDecoration(
                            border: new OutlineInputBorder(

                            borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(color: kMainColor),
                                hintText: "Add a comment to the order",
                                fillColor: Colors.white70),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: GestureDetector(
                                    onTap: pluss,
                                    child: SizedBox(
                                      child: Icon(Icons.exposure_plus_1),
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                _quant.toString(),
                                style: TextStyle(fontSize:60),
                              ),
                              ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: GestureDetector(
                                    onTap: minuss,

                                    child: SizedBox(
                                      child: Icon(Icons.exposure_neg_1),
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  opacity: 0.4,
                ),
              ButtonTheme(
                minWidth:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height* 0.1 ,
                child: Builder(
                  builder:(context) => RaisedButton(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.white)),

                    color: Colors.black,
                    onPressed: ()
                    {
                    addToTable(context, item);
                    },
                    child: Text('Order Now', style: TextStyle(fontSize: 15) ),textColor: Colors.white,
                  ),
                ),
              ),
                ]
            ),

          )
        ],
      ),
    );
  }

  minuss()
  {
    if(_quant>1)
      {
        setState(() {
          _quant--;
          print(_quant);
        });

      }
  }

  pluss()
  {
    setState(() {
      _quant++;
      print(_quant);
    });



  }

  void addToTable(context, item) {
    TableOrder tableorder=  Provider.of<TableOrder>(context, listen: false);
    item.fQuant= _quant;

    bool isthere= false;
    tableorder.addItem(item);
    var foodInChart =tableorder.items;
    for (var foodInChart in foodInChart)
      {
        if( foodInChart.fName == item.fName )
          {
            isthere=true;

          }
      }
    if(isthere)
      {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Its been ordered already'),
        ));
      }else {

    tableorder.addItem(item);
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(
        'Added to ur cart'

    ),
    ));
  }
  }
  }