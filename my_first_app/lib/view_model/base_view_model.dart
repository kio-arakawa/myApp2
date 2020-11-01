import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_first_app/my_enum/page_name.dart';

class BaseViewModel extends ChangeNotifier{

  ///Constructor
  //private constructor
  BaseViewModel._();

  static BaseViewModel _instance() => BaseViewModel._();

  //factory constructor
  factory BaseViewModel() => _instance();

  ///Variable
  //AppBarTitle
  String appBarTitle = 'Home';

  //BottomNavigationBar Index
  int selectedIndex = 0;

  //SplashView終了フラグ
  bool isFinishSplash = false;

  //SplashViewフェードアウトフラグ
  bool isStartFadeOut = false;

  //BaseViewフェードインフラグ
  bool isStartFadeIn = false;

  //今どのページにいるかのフラグ（初期値HOME）
  PageName _pageName = PageName.HOME;

  ///BottomNavigationBarでタップされたindexを元にAppBarのタイトル変更するAPI
  void onItemTapped(int index) {
    selectedIndex = index;
    setAppBarTitle(index);
    switch(index) {
      case 0:
        setPageName(PageName.HOME);
        break;
      case 1:
        setPageName(PageName.CHAT);
        break;
      case 2:
        setPageName(PageName.HISTORY);
        break;
      case 3:
        setPageName(PageName.SETTING);
        break;
      default:
        setPageName(PageName.HOME);
    }
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

  ///SplashViewタイマー開始
  void initSplash() {
    Timer(
      Duration(milliseconds: 6000),
      _startFadeOut,
    );
    Timer(
      Duration(milliseconds: 6800),
      _finishSplash,
    );
  }

  ///BaseViewタイマー開始
  void _initBase() {
    Timer(
      Duration(milliseconds: 100),
      _startBase,
    );
  }

  ///isStartFadeのCallBack用API
  void _startFadeOut() {
    isStartFadeOut = true;
    notifyListeners();
  }

  ///initSplashのCallBack用API
  void _finishSplash() {
    isFinishSplash = true;
    _initBase();
    notifyListeners();
  }

  ///_initBaseのCallBack用API
  void _startBase() {
    isStartFadeIn = true;
    notifyListeners();
  }

  ///set PageName
  void setPageName(PageName name) {
    _pageName = name;
  }

  ///get PageName
  PageName getPageName() {
    return _pageName;
  }

}