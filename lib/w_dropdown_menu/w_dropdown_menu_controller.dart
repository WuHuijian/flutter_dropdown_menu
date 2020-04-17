import 'package:flutter/foundation.dart';

class HJDropDownMenuController extends ChangeNotifier {
  double dropDownHearderHeight;

  int menuIndex=0;

  bool isShow=false;

  void show(int index,bool canDrop) {
    if(canDrop){
      isShow=true;
    }
    menuIndex = index;
    notifyListeners();
  }

  void hide(bool notify){
    isShow=false;
    notifyListeners();

  }
}
