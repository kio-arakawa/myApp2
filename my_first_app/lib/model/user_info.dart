/// Info: UserInfoDateクラスに移行しました
//import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//class UserInfo{
//
//  ///Constructor
//  //private constructor
//  UserInfo._();
//
//  static UserInfo _instance() => UserInfo._();
//
//  factory UserInfo() => _instance();
//
//  ///Variable
//  String _userName;
//  String _userPassWord;
//  SharedPreferences _pref;
//  String _userNameKey = 'name';
//  String _userPassWordKey = 'pass';
//
//  ///リポジトリのインスタンス作成
//  Future<void> _setPref() async{
//    _pref = await SharedPreferences.getInstance();
//  }
//
//  ///------------同期処理------------///
//  ///ユーザーネーム取得
//  String getUserName() {
//    return _userName;
//  }
//
//  ///パスワード情報取得
//  String getPassWord() {
//    return _userPassWord;
//  }
//
//  ///ユーザーネーム登録
//  void setUserName(String name) {
//    _userName = name;
//  }
//
//  ///パスワード登録
//  void setPassWord(String pass) {
//    _userPassWord = pass;
//  }
//
//  ///登録情報の初期化
//  void initializationInfo() {
//    _userName = null;
//    _userPassWord = null;
//  }
//
//
//  ///------------非同期処理------------///
//  ///ユーザーネームを非同期で取得
//  Future<String> getFutureName() async{
//    if (_pref == null) _setPref();
//    return _pref.getString(_userName);
//  }
//
//  ///パスワード情報を非同期で取得
//  Future<String> getFuturePass() async{
//    if (_pref == null) _setPref();
//    return _pref.getString(_userPassWordKey);
//  }
//
//  ///ユーザーネームを非同期で登録
//  Future<void> setFutureName(String name) async{
//    if (_pref == null) _setPref();
//    await _pref.setString(_userName, name);
//  }
//
//  ///パスワードを非同期で登録
//  Future<void> setFuturePass(String pass) async{
//    if (_pref == null) _setPref();
//    await _pref.setString(_userNameKey, pass);
//  }
//
//  ///登録情報を非同期で初期化
//  Future<void> initializationFutureInfo() async{
//    await _pref.remove(_userNameKey);
//    await _pref.remove(_userPassWordKey);
//  }
//
//}