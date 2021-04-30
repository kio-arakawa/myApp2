import 'package:flutter/material.dart';
import 'package:my_first_app/model/db/my_shared_pref.dart';
import 'package:my_first_app/view_model/base_view_model.dart';

class LoginViewModel extends BaseViewModel {

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
  LoginViewModel._();
  static LoginViewModel _loginViewModel;
  factory LoginViewModel() {
    _loginViewModel ??= LoginViewModel._();
    return _loginViewModel;
  }

  // ユーザー名・パスワードチェック
  void checkDoneAll() {
    if (isDoneName && isDonePass) {
      setIsDoneAll(true);
      notifyListeners();
    }
  }

  // ユーザー名のフラグ変更
  void changeIsDoneName(bool isDone) {
    // ユーザー名のフラグセット
    setIsDoneName(isDone);
    // ユーザー名・パスワードのフラグチェック
    if (isDoneName && isDonePass) {
      // 両方チェックOKの場合
      setIsDoneAll(true);
      // どちらかでもNGの場合
    } else {
      setIsDoneAll(false);
    }
//    notifyListeners();
  }

  // パスワードのフラグ変更
  void changeIsDonePass(bool isDone) {
    // パスワードのフラグセット
    setIsDonePass(isDone);
    // ユーザー名・パスワードのフラグチェック
    if (isDoneName && isDonePass) {
      // 両方チェックOKの場合
      setIsDoneAll(true);
      // どちらかでもNGの場合
    } else {
      setIsDoneAll(false);
    }
//    notifyListeners();
  }

  // アカウント情報のチェック
  Future<bool> checkMatchAccount(String name, String pass) async {
    // ユーザー名とパスワードがnullでない時
    if ( (name != null) && (pass != null) ) {
      if (name != await mySharedPrefInstance().getUserName()) {
        debugPrint('ユーザー名またはパスワードが異なっています。');
        return false;
      }
      if (pass != await mySharedPrefInstance().getUserPass()) {
        debugPrint('パスワード名またはパスワードが異なっています。');
        return false;
      }
    // ユーザー名またはパスワードがnullの時
    } else {
      return false;
    }
    debugPrint('アカウントが正常に照合されました！');
    return true;
  }

  // アカウント作成
  Future<bool> registerAccount(String name, String pass) async {
    // 正常に登録できたかのフラグリスト
    List<bool> futureList = [];
    futureList.add(await mySharedPrefInstance().setUserName(name));
    futureList.add(await mySharedPrefInstance().setUserPass(pass));
    return futureList.contains(false);
  }

  // アカウント削除
  Future<bool> deleteAccount() async {
    return await mySharedPrefInstance().deleteAccount();
  }

}