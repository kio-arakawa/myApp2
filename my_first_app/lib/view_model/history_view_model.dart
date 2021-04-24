import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/model/my_shared_pref.dart';
import 'package:my_first_app/model/sync_data_base_model.dart';

class HistoryViewModel extends BaseViewModel {

  MySharedPref _mySharedPref;
  SyncDataBaseModel _syncDataBaseModel;

  ///Constructor
  //private constructor
  HistoryViewModel._() {
    _mySharedPref ??= MySharedPref();
    _syncDataBaseModel ??= SyncDataBaseModel();
    _initViewModel();
  }

  static HistoryViewModel _instance() => HistoryViewModel._();

  //factory constructor
  factory HistoryViewModel() => _instance();

  void _initViewModel() {
    // 設定テーマの初期設定
//    _isDarkMode = _syncDataBaseModel.getDarkModeFlagFromSync();
    // 基底クラスにもセット
//    setIsCurrentDarkMode(_isDarkMode);
    setIsCurrentDarkMode(_syncDataBaseModel.getDarkModeFlagFromSync());
  }

}