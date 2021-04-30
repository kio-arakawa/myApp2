import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/model/db/my_shared_pref.dart';
import 'package:my_first_app/model/sync_data_base_model.dart';

class InitSettingAndTutorialViewModel extends BaseViewModel {

  ///Constructor
  //private constructor
  InitSettingAndTutorialViewModel._() {
    _initViewModel();
  }

  static InitSettingAndTutorialViewModel _instance() => InitSettingAndTutorialViewModel._();
  static InitSettingAndTutorialViewModel _initSettingAndTutorialViewModel;
  //factory constructor
  factory InitSettingAndTutorialViewModel() {
    return _initSettingAndTutorialViewModel ??= _instance();
  }

  void _initViewModel() {}

  // ユーザー名設定Page表示かどうか
  bool isDrawSettingUserNamePage = true;
  // ユーザー名設定Page表示Flag変更通知
  void changeIsDrawSettingUserNamePageFlag() async {
    if(_cacheProfileName != null) {
      // SharedPrefに登録
      await mySharedPrefInstance().setProfileUserName(_cacheProfileName).then((bool) {
        if(bool) {
          // 同期クラスにもセット
          syncDataBaseModelInstance().syncSetProfileUserNameIntoSync(_cacheProfileName);
          // チュートリアル表示通知
          isDrawSettingUserNamePage = false;
          notifyListeners();
        }
      });
    }
  }

  // ユーザー名入力完了したかどうか
  bool isFinishSettingUserName = false;
  // ユーザー名入力完了Flag変更通知
  void changeIsFinishSettingUserName(bool isFinish) {
    if(isFinishSettingUserName != isFinish) {
      isFinishSettingUserName = isFinish;
      notifyListeners();
    }
  }

  // ユーザー名が0文字以上かどうかチェック
  // 結果がtrueならボタン表示
  void checkInputUserName(String userName) {
    // Info: trim()で空白自動トリミング
    _cacheProfileName = userName.trim();
    if(userName.isNotEmpty && userName.length > 0) {
      if(!isFinishSettingUserName) {
        changeIsFinishSettingUserName(true);
      }
    } else {
      if(isFinishSettingUserName) {
        changeIsFinishSettingUserName(false);
      }
    }
  }

  // Profile名のキャッシュ
  String _cacheProfileName;
  void _setCacheProfileName(String profileName) {
    _cacheProfileName = profileName;
  }

}