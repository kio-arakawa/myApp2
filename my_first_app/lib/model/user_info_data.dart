import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoData {

  //Instance
  SharedPreferences _prefs;
  //Key: UserName
  static const String USER_NAME = 'user_name';
  //Key: UserPass
  static const String USER_PASS = 'user_pass';

  ///Constructor
  UserInfoData._();

  static UserInfoData _userInfoData;

  factory UserInfoData() {
    _userInfoData ??= UserInfoData._();
    return _userInfoData;
  }

  /// Get SharedPrefInstance
  Future<SharedPreferences> _getSharedPrefInstance() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs;
  }

  /// Get UserName
  Future<String> getUserName() async {
    final prefs = await _getSharedPrefInstance();
    return prefs.getString(USER_NAME);
  }

  /// Get UserPass
  Future<String> getUserPass() async {
    final prefs = await _getSharedPrefInstance();
    return prefs.getString(USER_PASS);
  }

  /// Register UserName
  Future<void> setUserName(String inputName) async {
    //Check Existing UserName
    await getUserName().then((name) async {
      if (name == null) {
        final prefs = await _getSharedPrefInstance();
        await prefs.setString(USER_NAME, inputName).then((value) => debugPrint('ユーザー名を新規に登録しました！(登録ユーザー名:$inputName)'));
      } else {
        debugPrint('既にユーザー名を登録済みです。');
      }
    });
  }

  /// Register UserPass
  Future<void> setUserPass(String inputPass) async {
    // Check Existing UserPass
    await getUserPass().then((pass) async {
      if (pass == null) {
        final prefs = await _getSharedPrefInstance();
        await prefs.setString(USER_PASS, inputPass).then((value) => debugPrint('パスワードを新規に登録しました！(登録パスワード:$inputPass)'));
      } else {
        debugPrint('既にパスワードは登録済みです。');
      }
    });
  }
  
  /// Update UserName
  Future<void> updateUserName(String name) async {
    final prefs = await _getSharedPrefInstance();
    await prefs.setString(USER_NAME, name).then((value) => debugPrint('ユーザー名をアップデートしました！'));
  }
  
  /// Update UserPass
  Future<void> updateUserPass(String pass) async {
    final prefs = await _getSharedPrefInstance();
    await prefs.setString(USER_PASS, pass).then((value) => debugPrint('パスワードをアップデートしました！'));
  }
  
  /// Delete Account
  Future<bool> deleteAccount() async {
    final prefs = await _getSharedPrefInstance();
    if ( (prefs.getString(USER_NAME) != null) && (prefs.getString(USER_PASS) != null) ) {
      List<bool> futureList = [];
      bool isError = false;
      futureList.add(await prefs.remove(USER_NAME).catchError((e) => isError = true));
      futureList.add(await prefs.remove(USER_PASS).catchError((e) => isError = true));
      while (true) {
        if (isError == true) {
          debugPrint('何らかのエラーが発生し削除できませんでした。');
          return false;
        }
        if (futureList.length == 2 || futureList.length > 2) {
          debugPrint('アカウントを削除しました！');
          return true;
        }
      }
    }
    debugPrint('登録されているアカウントが無いため、削除できませんでした。');
    return false;
  }

}