import 'package:flutter/material.dart';
import 'package:my_first_app/model/db/my_shared_pref.dart';
import 'package:my_first_app/model/sync_data_base_model.dart';
import 'package:my_first_app/view_model/base_view_model.dart';

class SettingViewModel extends BaseViewModel {

  MySharedPref _mySharedPref;
  SyncDataBaseModel _syncDataBaseModel;

  ///Constructor
  //private constructor
  SettingViewModel._() {
    _mySharedPref ??= MySharedPref();
    _syncDataBaseModel ??= SyncDataBaseModel();
    _initViewModel();
  }

  void _initViewModel() {
    // 設定テーマの初期設定
    _isDarkMode = _syncDataBaseModel.getDarkModeFlagFromSync();
    // 基底クラスにもセット
    setIsCurrentDarkMode(_isDarkMode);
  }

  static SettingViewModel _instance() => SettingViewModel._();

  //factory constructor
  factory SettingViewModel() => _instance();

  ///Variable
  //DarkModeフラグ
  static bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  //SplashView用初回のみ起動フラグ
  bool _isInitSplash = true;
  bool get isInitSplash => _isInitSplash;

  //DebugModeフラグ
  bool _isDebugMode = false;
  bool get isDebugMode => _isDebugMode;

  bool _isOSDarkTheme(BuildContext context) {
    // OSのダークモード設定判定
    final Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);
    if (platformBrightness == Brightness.dark) {
      return true;
    } else {
      return false;
    }
  }

  ///DarkMode切替時テーマビルドAPI
  ThemeData buildTheme() {
    if (_isDarkMode) {
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
  // Info: ダークモードならtrue, ライトモードならfalseを代入
  void changeDarkMode(bool value) async {
    // Info: OSがダークモードなら変更させない
    if (!isOSDarkMode) {
      await _mySharedPref.setDarkModeFlag(value).then((bool) {
        if (bool) {
          _isDarkMode = value;
          _syncDataBaseModel.setDarkModeFlagIntoSync(value);
          setIsCurrentDarkMode(value);
          _isInitSplash = false;
          notifyListeners();
        }
      });
    }
  }

  void changeOsDarkMode(bool value) async {
    if (isOSDarkMode != value) {
      await _mySharedPref.setDarkModeFlag(value).then((bool) {
        if (bool) {
          setIsOsDarkModeFlag(value);
          _syncDataBaseModel.setDarkModeFlagIntoSync(value);
          setIsCurrentDarkMode(value);
          notifyListeners();
        }
      });
    }
  }

  ///DebugModeフラグ変更API
  void changeDebugMode(bool value) {
    _isDebugMode = value;
    _isInitSplash = false;
    notifyListeners();
  }

}