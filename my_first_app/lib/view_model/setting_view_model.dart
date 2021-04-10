import 'package:flutter/material.dart';
import 'package:my_first_app/view_model/base_view_model.dart';

import 'package:my_first_app/view_model/change_notifier_model.dart';

class SettingViewModel extends BaseViewModel {

  ///Constructor
  //private constructor
  SettingViewModel._();

  static SettingViewModel _instance() => SettingViewModel._();

  //factory constructor
  factory SettingViewModel() => _instance();

  ///Variable
  //DarkModeフラグ
  bool isDarkMode = false;

  //SplashView用初回のみ起動フラグ
  bool isInitSplash = true;

  //DebugModeフラグ
  bool isDebugMode = false;

  ///DarkMode切替時テーマビルドAPI
//  ThemeData buildTheme() => isDarkMode ? ThemeData.dark() : ThemeData.light();
  ThemeData buildTheme() {
    if (isDarkMode) {
      return ThemeData.dark();
    } else {
      return ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blueGrey,
        accentColor: Colors.blueGrey,
      );
    }
  }

  ///DarkModeフラグ変更API
  void changeDarkMode(bool value) {
    isDarkMode = value;
    setIsCurrentDarkMode(value);
    isInitSplash = false;
    notifyListeners();
  }

  ///DebugModeフラグ変更API
  void changeDebugMode(bool value) {
    isDebugMode = value;
    isInitSplash = false;
    notifyListeners();
  }

}