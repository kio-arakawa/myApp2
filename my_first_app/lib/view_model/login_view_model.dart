import 'package:flutter/material.dart';
import 'package:my_first_app/model/user_info_data.dart';

class LoginViewModel extends ChangeNotifier {

  UserInfoData _userInfoData;

  //初回登録かどうかのフラグ
  bool _isRegisterAccount = true;
  bool get isRegisterAccount => _isRegisterAccount;
  void setIsFirstLogin(bool isRegisterAccount) {
    _isRegisterAccount = isRegisterAccount;
    notifyListeners();
  }
  //プロフィール画像設定フラグ
  bool _isSetImage = false;
  bool get isSetImage => _isSetImage;
  void setIsSetImage(bool isSetImage) => _isSetImage = isSetImage;
  //ユーザー名入力完了フラグ
  bool _isDoneName = false;
  bool get isDoneName => _isDoneName;
  void setIsDoneName(bool isDoneName) => _isDoneName = isDoneName;
  //パスワード入力完了フラグ
  bool _isDonePass = false;
  bool get isDonePass => _isDonePass;
  void setIsDonePass(bool isDonePass) => _isDonePass = isDonePass;
  //必須設定項目完了フラグ
  bool _isDoneAll = false;
  bool get isDoneAll => _isDoneAll;
  void setIsDoneAll(bool isDoneAll) => _isDoneAll = isDoneAll;
  //ユーザー名
  String _name;
  String get userName => _name;
  void setUserName(String name) => _name = name;
  //パスワード
  String _pass;
  String get userPass => _pass;
  void setUserPass(String pass) => _pass = pass;

  ///Constructor
  LoginViewModel._() {
   _userInfoData = UserInfoData();
  }
  static LoginViewModel _loginViewModel;
  factory LoginViewModel() {
    _loginViewModel ??= LoginViewModel._();
    return _loginViewModel;
  }

  void checkDoneAll() {
    if (isDoneName && isDonePass) {
      setIsDoneAll(true);
      notifyListeners();
    }
  }

  void changeIsDoneName(bool isDone) {
    setIsDoneName(isDone);
    if (isDoneName && isDonePass) {
      setIsDoneAll(true);
    } else {
      setIsDoneAll(false);
    }
  }

  void changeIsDonePass(bool isDone) {
    setIsDonePass(isDone);
    if (isDoneName && isDonePass) {
      setIsDoneAll(true);
    } else {
      setIsDoneAll(false);
    }
  }

  Future<bool> checkMatchAccount(String name, String pass) async {
    if ( (name != null) && (pass != null) ) {
      if (name != await _userInfoData.getUserName()) {
        debugPrint('ユーザー名またはパスワードが異なっています。');
        return false;
      }
      if (pass != await _userInfoData.getUserPass()) {
        debugPrint('パスワード名またはパスワードが異なっています。');
        return false;
      }
    }
    debugPrint('アカウントが正常に照合されました！');
    return true;
  }

  // アカウント作成
  Future<void> registerAccount(String name, String pass) async {
    await _userInfoData.setUserName(name);
    await _userInfoData.setUserPass(pass);
  }

  // アカウント削除
  Future<bool> deleteAccount() async {
    return await _userInfoData.deleteAccount();
  }

}