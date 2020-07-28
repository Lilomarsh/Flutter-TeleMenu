import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:proj_nine/constants.dart';

class AverageProvider with ChangeNotifier{
  Map<String,List<int>> ages = {
    '-18':[],
    '+18 & -30':[],
    '+30 & -40':[],
    '+40':[]
  };

  Map<String,List<int>> gender = {
    'male':[],
    'female':[]
  };


  final Firestore _myfirestore = Firestore.instance;
  Stream<QuerySnapshot> _loadItems(){
    return _myfirestore.collection(cUserInfo).snapshots();
  }

  Future<void> getUsersAge()async{
   await _loadItems().forEach((element) {
     for(int i=0; i < element.documents.length;i++) {
       if (int.parse(element.documents[i].data['userAge']) < 18) {
         ages['-18'].add(0);
       } else if (int.parse(element.documents[i].data['userAge']) >= 18 &&
           int.parse(element.documents[i].data['userAge']) < 30) {
         ages['+18 & -30'].add(0);
       } else if (int.parse(element.documents[i].data['userAge']) >= 30 &&
           int.parse(element.documents[i].data['userAge']) < 40) {
         ages['+30 & -40'].add(0);
       }
       else if (int.parse(element.documents[i].data['userAge']) > 40) {
         ages['+40'].add(0);
       }
     }
   });
//   under18 = ages['-18'].length.toDouble();
//   above18under30 = ages['+18 & -30'].length.toDouble();
//   above30under40 = ages['+30 & -40'].length.toDouble();
//   above40 = ages['+40'].length.toDouble();
    notifyListeners();
  }

  Future<void> getUsersGender()async{
    await _loadItems().forEach((element) {
      for(int i=0; i < element.documents.length;i++){
        if(element.documents[i].data['male']){
          // if male
          gender['male'].add(0);
        }else{
          // if female
          gender['female'].add(1);
        }
      }
    });
  }
}