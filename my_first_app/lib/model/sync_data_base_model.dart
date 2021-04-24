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
  static String _sProfileUserName = '';
  // ダークモードかどうかのフラグ
  static bool _isDarkMode = false;

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
}