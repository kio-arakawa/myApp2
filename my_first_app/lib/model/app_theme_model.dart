import 'package:flutter/material.dart';
import 'package:my_first_app/model/db/my_shared_pref.dart';
import 'package:my_first_app/view_model/change_notifier_model.dart';

/// アプリのテーマカラーを管理する同期的メソッド ///
///
///

class AppThemeModel extends ChangeNotifierModel {
  /// SingleTon
  AppThemeModel._();
  static AppThemeModel _appThemeModel;
  static AppThemeModel _instance() => AppThemeModel._();
  factory AppThemeModel() {
    return _appThemeModel ??= _instance();
  }

  MySharedPref _mySharedPref = MySharedPref();

  /// Variable
  ThemeData appThemeData = ThemeData.light();
  bool isNeedFirstThemeCheck = true;

  bool isAppThemeDarkNow() {
    return (appThemeData == ThemeData.dark());
  }

  /// Method
  void changeAppThemeColor({ThemeData data, bool isDarkMode}) async {
    // 明示的にテーマ指定しない時
    if ((data == null) && (isDarkMode == null)) {
      if (appThemeData == ThemeData.light()) {
        await _mySharedPref.setDarkModeFlag(true).then((value) {
          if(value)
            appThemeData = ThemeData.dark();
          notifyListeners();
        });
      } else {
        await _mySharedPref.setDarkModeFlag(false).then((value) {
          if(value)
            appThemeData = ThemeData.light();
          notifyListeners();
        });
      }

    // ThemeDataを明示的にテーマ指定する時
    } else if (data != null) {
      bool isDarkMode = false;
      if(data == ThemeData.dark()) {
        isDarkMode = true;
      }
      if (appThemeData != data) {
        await _mySharedPref.setDarkModeFlag(isDarkMode).then((value) {
          appThemeData = data;
          notifyListeners();
        });
      }
    // boolフラグを明示的にテーマ指定する時
    } else {
      bool isOldDarkMode = false;
      if (appThemeData == ThemeData.dark()) {
        isOldDarkMode = true;
      }
      if (isOldDarkMode != isDarkMode) {
        await _mySharedPref.setDarkModeFlag(isDarkMode).then((value) {
          if(isDarkMode) {
            appThemeData = ThemeData.dark();
          } else {
            appThemeData = ThemeData.light();
          }
          notifyListeners();
        });
      }
    }

  }

}