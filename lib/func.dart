import 'package:proj_nine/models/item.dart';

List<Item> getFoodbytype(String kFoodStarter, List<Item> allitems)
{
  List<Item> items =[];
  try{

  for(var item in  allitems) {
    if(item.fType ==kFoodStarter) {
      items.add(item);
    }
  }} on Error catch(ex)
  {
    print(ex);
  }

  return items;
}