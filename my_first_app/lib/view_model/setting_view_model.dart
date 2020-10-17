import 'package:flutter/material.dart';

class SettingViewModel extends ChangeNotifier {

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

  ///DarkMode切替時テーマビルドAPI
  ThemeData buildTheme() => isDarkMode ? ThemeData.dark() : ThemeData.light();
//  ? ThemeData(primaryColorBrightness: Brightness.dark)
//      : ThemeData(primaryColorBrightness: Brightness.light);

  ///DarkModeフラグ変更API
  void changeDarkMode(bool value) {
    isDarkMode = value;
    isInitSplash = false;
    notifyListeners();
  }

}