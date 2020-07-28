import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj_nine/models/item.dart';
import 'package:proj_nine/models/user.dart';


import '../constants.dart';
class Storage {
  final Firestore _myfirestore = Firestore.instance;
  addUser(User user) {
    _myfirestore.collection(cUserInfo).add(
        {
          cUserName: user.uName,
          cUserAge: user.uAge,


        });
  }


  addMenu(Item item) {
    _myfirestore.collection(cFoodMix).add(
        {
          cFoodName: item.fName,
          cFoodType: item.fType,
          cFoodPrice: item.fPrice,
          cFoodInfo: item.fInfo,
          cFoodImg: item.fImg,

        });
  }

  Stream<QuerySnapshot> loadItems(){


    return _myfirestore.collection(cFoodMix).snapshots();
  }
  deleteItem(documentID)
  {
    _myfirestore.collection(cFoodMix).document(documentID).delete();
  }
  editItem(data,documentID){
    _myfirestore.collection(cFoodMix).document(documentID).updateData(data);
  }
  orderStorage(data, List<Item> items,) {
    var documentRef = _myfirestore.collection(cOrders).document();
    documentRef.setData(data);
    for(var item in items){
    documentRef.collection(cOrderInfo).document().setData
      ({
      cFoodName:item.fName,
      cFoodPrice:item.fPrice,
      cfoodQuan:item.fQuant,
      cFoodImg:item.fImg,


    });
  }

  }
}
