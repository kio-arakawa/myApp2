import 'package:flutter/material.dart';

class SettingModel extends ChangeNotifier {

  bool isDarkMode = false;

  ThemeData buildTheme() => isDarkMode ? ThemeData.dark() : ThemeData.light();
//  ? ThemeData(primaryColorBrightness: Brightness.dark)
//      : ThemeData(primaryColorBrightness: Brightness.light);

  ///Change Dark Mode
  void changeDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }

}