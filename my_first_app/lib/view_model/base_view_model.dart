import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier{

  String appBarTitle = 'Home';
  int selectedIndex = 0;

  ///BottomNavigationBarでタップされたindexを元にAppBarのタイトル変更するAPI
  void onItemTapped(int index) {
    selectedIndex = index;
    setAppBarTitle(index);
    notifyListeners();
  }

  ///AppBarのタイトルを変更するAPI
  void setAppBarTitle(int index) {
    switch(index) {
      case 0:
        this.appBarTitle = 'Home';
        break;
      case 1:
        this.appBarTitle = 'Chat';
        break;
      case 2:
        this.appBarTitle = 'History';
        break;
      case 3:
        this.appBarTitle = 'Setting';
        break;
    }
  }

}