import 'package:flutter/material.dart';
import 'package:my_first_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {

  // SharedPref Instance
  SharedPreferences _prefs;

  ///Constructor(Singleton)
  MySharedPref._();
  static MySharedPref _mySharedPref;
  factory MySharedPref() {
    _mySharedPref ??= MySharedPref._();
    return _mySharedPref;
  }

  /// -- [BEGIN] GET METHOD -- ///
  /// Get SharedPrefInstance
  Future<SharedPreferences> _getSharedPrefInstance() async {
    return _prefs ??= await SharedPreferences.getInstance();
  }
  /// Get UserName
  Future<String> getUserName() async {
    return await _getSharedPrefInstance().then((prefs) {
      return prefs.getString(Constants.userName);
    });
  }
  /// Get UserPass
  Future<String> getUserPass() async {
    return await _getSharedPrefInstance().then((prefs) {
      return prefs.getString(Constants.userPass);
    });
  }
  /// Get ProfileUserName
  Future<String> getProfileUserName() async {
    return await _getSharedPrefInstance().then((prefs) {
      return prefs.getString(Constants.profileUserName);
    });
  }
  /// Get DarkModeFlag
  Future<bool> getDarkModeFlag() async {
    return await _getSharedPrefInstance().then((prefs) {
      return prefs.getBool(Constants.darkModeFlagName);
    });
  }
  /// -- [END] GET METHOD -- ///

  /// -- [BEGIN] SET METHOD -- ///
  /// Register UserName
  Future<bool> setUserName(String inputName) async {
    bool result;
    //Check Existing UserName
    await getUserName().then((name) async {
      // ユーザー名が未登録だった時
      if (name == null) {
        await _getSharedPrefInstance().then((prefs) async {
          // SharedPrefに書き込み処理
          await prefs.setString(Constants.userName, inputName).then((value) {
            // 書き込みに成功
            if (value) {
              debugPrint('ユーザー名を新規に登録しました！(登録ユーザー名:$inputName)');
              // 書き込みに失敗
            } else {
              debugPrint('ユーザー名の新規登録に失敗しました。');
            }
            result = value;
          });
        });
      // 既にユーザー名が登録されていた時
      } else {
        debugPrint('既にユーザー名を登録済みです。');
        result = false;
      }
    });
    return result;
  }
  /// Register UserPass
  Future<bool> setUserPass(String inputPass) async {
    bool result;
    // Check Existing UserPass
    await getUserPass().then((pass) async {
      // パスワードが未登録だった時
      if (pass == null) {
        await _getSharedPrefInstance().then((prefs) async {
          // SharedPrefに書き込み処理
          await prefs.setString(Constants.userPass, inputPass).then((value) {
            // 登録に成功
            if (value) {
              debugPrint('パスワードを新規に登録しました！(登録パスワード:$inputPass)');
            // 登録に失敗
            } else {
              debugPrint('パスワードの登録に失敗しました。');
            }
            result = value;
          });
        });
      // 既にパスワードが登録されていた時
      } else {
        debugPrint('既にパスワードは登録済みです。');
        result = false;
      }
    });
    return result;
  }
  /// Register ProfileUserName
  Future<bool> setProfileUserName(String inputProfileName) async {
    bool result;
    //Check Existing UserName
    await getProfileUserName().then((name) async {
      // プロフィール名が未登録だった時
      if (name == null) {
        await _getSharedPrefInstance().then((prefs) async {
          // SharedPrefに書き込み処理
          await prefs.setString(Constants.profileUserName, inputProfileName).then((value) {
            // 書き込みに成功
            if (value) {
              debugPrint('プロフィール名を新規に登録しました！(プロフィール名:$inputProfileName)');
            // 書き込みに失敗
            } else {
              debugPrint('プロフィール名の新規登録に失敗しました。');
            }
            result = value;
          });
        });
      // 既にプロフィール名が登録されていた時
      } else {
        debugPrint('既にプロフィール名を登録済みです。');
        result = false;
      }
    });
    return result;
  }
  /// Register DarkModeFlag
  Future<bool> setDarkModeFlag(bool isDarkMode) async {
    bool result;
    String themeName;
    if (isDarkMode) {
      themeName = 'ダークモード';
    } else {
      themeName = 'ライトモード';
    }
    // Check Existing UserName
    return await getDarkModeFlag().then((bool) async {
      // 今の設定と同じモードが指定されたら何もしない
      if (bool != isDarkMode) {
        return await _getSharedPrefInstance().then((prefs) async {
          // SharedPrefに書き込み処理
          return await prefs.setBool(Constants.darkModeFlagName, isDarkMode).then((value) {
            // 書き込みに成功
            if (value) {
              debugPrint('$themeNameに設定しました！');
              // 書き込みに失敗
            } else {
              debugPrint('$themeNameの設定に失敗しました。');
            }
            return value;
          });
        });
      } else {
        debugPrint('既に$themeNameです');
        return false;
      }
    });
  }
  /// -- [END] SET METHOD -- ///

  /// -- [BEGIN] UPDATE METHOD -- ///
  /// Update UserName
  Future<void> updateUserName(String name) async {
    return await _getSharedPrefInstance().then((prefs) async {
      await prefs.setString(Constants.userName, name).then((value) => debugPrint('ユーザー名をアップデートしました！'));
    });
  }
  /// Update UserPass
  Future<void> updateUserPass(String pass) async {
    return await _getSharedPrefInstance().then((prefs) async {
      await prefs.setString(Constants.userPass, pass).then((value) => debugPrint('パスワードをアップデートしました！'));
    });
  }
  /// Update ProfileUserName
  Future<void> updateProfileUserName(String profileUserName) async {
    return await _getSharedPrefInstance().then((prefs) async {
      await prefs.setString(Constants.profileUserName, profileUserName).then((value) => debugPrint('プロフィール名をアップデートしました！'));
    });
  }
  /// -- [END] UPDATE METHOD -- ///

  /// -- [BEGIN] DELETE METHOD -- ///
  /// Delete Account
  Future<bool> deleteAccount() async {
    // SharedPrefのインスタンスGet
    return await _getSharedPrefInstance().then((prefs) async {
      String userName;
      String userPass;
      // 登録名と登録パスワードがあるかチェック
      if ( ( (userName = prefs.getString(Constants.userName) ) != null)
          && ( (userPass = prefs.getString(Constants.userPass) ) != null) ) {
        // 登録名とパスワードが正常に削除できたかのフラグリスト
//        List<bool> futureList = [];
        // エラーフラグを初期化
//        bool isError = false;
        // SharedPrefから登録名を削除処理
        return await prefs.remove(Constants.userName).then((bool) async {
          // 削除に失敗した時
          if (!bool) {
            debugPrint('登録名の削除に失敗しました。');
            // falseを返して終了
            return bool;
          // 削除成功したら、SharedPrefからパスワード削除処理
          } else {
            return await prefs.remove(Constants.userPass).then((bool) async {
              // 削除に失敗した時
              if (!bool) {
                // ユーザー名を登録し直す
                return await prefs.setString(Constants.userName, userName).then((value) {
                  debugPrint('パスワードの削除に失敗しました。');
                  // falseを返して終了
                  return bool;
                });
              } else {
                debugPrint('登録名・パスワードの削除に成功しました！');
                debugPrint('削除したアカウント情報【ユーザー名:$userName, パスワード:$userPass】');
                // 両方削除成功して、trueが返る
                return bool;
              }
            });
          }
        });
      // 登録されていない場合
      } else {
        debugPrint('登録されているアカウントが無いため、削除できませんでした。');
        return false;
      }
    });
  }
  /// Delete ProfileName
  /// * エラーがあればfalseを返す
  Future<bool> deleteProfileName() async {
    // SharedPrefのインスタンスGet
    return await _getSharedPrefInstance().then((prefs) async {
      // 登録プロフィール名があるかチェック
      if (prefs.getString(Constants.profileUserName) != null) {
        // SharedPrefから登録登録プロフィール名を削除
        return await prefs.remove(Constants.userName);
      } else {
        return false;
      }
    });
  }
  /// -- [END] DELETE METHOD -- ///

}