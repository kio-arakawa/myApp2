import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_first_app/constants.dart';
import 'package:my_first_app/my_enum/page_name.dart';
import 'package:my_first_app/view_model/change_notifier_model.dart';

class BaseViewModel extends ChangeNotifierModel {

  // BuildContext
  BuildContext _context;
  BuildContext get context => _context;
  void setContext(BuildContext context) {
    _context = context;
  }

  // Appが初回起動かどうか（main関数を通るかどうか）
  static bool _isFirstApp = true;
  bool get isFirstApp => _isFirstApp;
  void setIsFirstAppFlag(bool flag) {
    _isFirstApp = flag;
  }

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

  // OSのダークモードかどうかのフラグ
  static bool _isOSDarkMode = false;
  bool get isOSDarkMode => _isOSDarkMode;
  void setIsOsDarkModeFlag(bool flag) {
    _isOSDarkMode = flag;
  }

  // DarkModeかどうか
  static bool _isCurrentDarkMode = false;
  void setIsCurrentDarkMode(bool isDark) {
    _isCurrentDarkMode = isDark;
  }
  bool getIsCurrentDarkMode() {
    return _isCurrentDarkMode;
  }

  //今どのページにいるかのフラグ（初期値HOME）
  static PageName _pageName;

  ///BottomNavigationBarでタップされたindexを元にAppBarのタイトル変更するAPI
  void onItemTapped(int index) {
    selectedIndex = index;
    _setAppBarTitle(index);
    switch(index) {
      case 0:
        _setPageName(PageName.HOME);
        break;
      case 1:
        _setPageName(PageName.CHAT);
        break;
      case 2:
        _setPageName(PageName.HISTORY);
        break;
      case 3:
        _setPageName(PageName.SETTING);
        break;
      default:
        _setPageName(PageName.HOME);
    }
    notifyListeners();
  }

  ///AppBarのタイトルを変更するAPI
  void _setAppBarTitle(int index) {
    switch(index) {
      case 0:
        this.appBarTitle = Constants.homeViewTitle;
        break;
      case 1:
        this.appBarTitle = Constants.diaryViewTitle;
        break;
      case 2:
        this.appBarTitle = Constants.historyViewTitle;
        break;
      case 3:
        this.appBarTitle = Constants.settingViewTitle;
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
  void _setPageName(PageName name) {
    _pageName = name;
  }

  ///get PageName
  PageName getPageName() {
    return _pageName;
  }

  // OSのダークモード設定判定
  void setOSDarkTheme({bool notNotify = true}) {
    final Brightness newPlatformBrightness = MediaQuery.platformBrightnessOf(context);
    // 新規取得テーマカラー判定用フラグ
    bool newIsDarkMode;
    if (newPlatformBrightness == Brightness.dark) {
      newIsDarkMode = true;
    } else {
      newIsDarkMode = false;
    }
    // 新旧で変更があった時のみ更新
    if (isFirstApp || _isOSDarkMode != newIsDarkMode) {
      _isOSDarkMode = newIsDarkMode;
      if (!notNotify) {
        notifyListeners();
      }
    }
//    _isOSDarkMode = newIsDarkMode;
//    if (!notNotify) {
//      notifyListeners();
//    }
  }

  /// Notify用
  void notify() {
    notifyListeners();
  }

}