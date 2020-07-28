import 'package:flutter/cupertino.dart';

class AdminType extends ChangeNotifier
{
  bool isAdmin = false;
  changeIsAdmin(bool value)
  {
    isAdmin=value;
    notifyListeners();
  }
}