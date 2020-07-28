import 'package:proj_nine/models/item.dart';
import 'package:flutter/cupertino.dart';

class TableOrder extends ChangeNotifier
{
  List<Item> items=[];
      addItem(Item item)
      {
        items.add(item);
        notifyListeners();
      }
      deleteItem(Item item)
      {
        items.remove(item);
        notifyListeners();
      }
}