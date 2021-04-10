/// SharedPrefとMoorから取得した非同期情報を同期的に処理するクラス

class SyncDataBaseModel {
  /// Constructor(Singleton)
  SyncDataBaseModel._();
  static SyncDataBaseModel _instance;
  factory SyncDataBaseModel() {
    print('SyncDataBaseModel Instance!');
    return _instance ??= SyncDataBaseModel._();
  }

  /// Static Variable
  //　Info: staticで共通化
  // 登録ユーザー名
  static String _sUserName = '';
  // 登録パスワード
  static String _sUserPass = '';
  // 自分の名前
  static String _sName = '';
  //

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
  // -- [End]UserNameとUserPass -- //

  // -- [Begin]Name -- //

  // -- [End]Name -- //

}