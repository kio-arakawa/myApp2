import 'package:flutter/material.dart';

/// SharedPrefとMoorから取得した非同期情報を同期的に処理するクラス

class SyncDataBaseModel {
  /// Constructor(Singleton)
  SyncDataBaseModel._();
  static SyncDataBaseModel _instance;
  factory SyncDataBaseModel() {
    if(_instance == null) {
      debugPrint('SyncDataBaseModel Instance!');
    }
    return _instance ??= SyncDataBaseModel._();
  }

  /// Static Variable
  //　Info: staticで共通化
  // 登録ユーザー名
  static String _sUserName = '';
  // 登録パスワード
  static String _sUserPass = '';
  // 自分の名前
  static String _sProfileUserName = '';
  // ダークモードかどうかのフラグ
  static bool _isDarkMode = false;
  // アプリ初回起動かどうかのフラグ
  static bool _isInitAppLaunch = true;
  // アクティビティカウンター[年月]
  static Map<String, int> _activityCounterByYearAndMonth = {};

  /// Method
  // -- [Begin]UserNameとUserPass -- //
  // DBからユーザー名セット
  Future<void> setUserNameIntoSync(Future<String> userName) async {
    _sUserName = await userName;
  }
  // DBからパスワードセット
  Future<void> setUserPassIntoSync(Future<String> userPass) async {
    _sUserPass = await userPass;
  }
  // ユーザー名取得
  String getUserNameFromSync() {
    return _sUserName;
  }
  // パスワード取得
  String getUserPassFromSync() {
    return _sUserPass;
  }
  // ユーザー名登録削除
  void deleteUserNameFromSync() {
    _sUserName = '';
  }
  // パスワード登録削除
  void deleteUserPassFromSync() {
    _sUserPass = '';
  }
  // -- [End]UserNameとUserPass -- //

  // -- [Begin]ProfileUserName -- //
  // DBからプロフィール名をセット
  Future<void> setProfileUserNameIntoSync(Future<String> profileUserName) async {
    _sProfileUserName = await profileUserName;
  }
  // 同期的にプロフィール名をセット
  void syncSetProfileUserNameIntoSync(String profileName) {
    _sProfileUserName = profileName;
  }
  // プロフィール名取得
  String getProfileUserNameFromSync() {
    return _sProfileUserName;
  }
  // プロフィール名削除
  void deleteProfileUserNameFromSync() {
    _sProfileUserName = '';
  }
  // -- [End]ProfileUserName -- //

  // -- [Begin]IsDarkMode -- //
  // DBからフラグをセット
  void setDarkModeFlagIntoSync(bool isDarkMode) {
    _isDarkMode = isDarkMode;
  }
  // フラグ取得
  bool getDarkModeFlagFromSync() {
    return _isDarkMode;
  }
  // -- [End]IsDarkMode -- //

  // -- [Begin] InitAppLaunch -- //
  // DBからフラグをセット
  void setInitAppLaunchFlagIntoSync(bool isInitAppLaunch) {
    _isInitAppLaunch = isInitAppLaunch;
  }
  // フラグ取得
  bool getInitAppLaunchFlagFromSync() {
    return _isInitAppLaunch;
  }

  // -- [Begin]Activity Counter -- //
  // DBからカウントセット
  void setActivityByYearAndMonthIntoSync(String key, int count) {
    _activityCounterByYearAndMonth[key] = count;
  }
  // カウント取得
  Map<String, int> getActivityByYearAndMonthFromSync() {
    return _activityCounterByYearAndMonth;
  }
  // -- [End]Activity Counter -- //

}