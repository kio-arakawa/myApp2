import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/model/db/my_shared_pref.dart';
import 'package:my_first_app/model/sync_data_base_model.dart';

class HistoryViewModel extends BaseViewModel {

  ///Constructor
  //private constructor
  HistoryViewModel._() {
    _initViewModel();
  }

  static HistoryViewModel _instance() => HistoryViewModel._();

  //factory constructor
  factory HistoryViewModel() => _instance();

  void _initViewModel() {
    setIsCurrentDarkMode(syncDataBaseModelInstance().getDarkModeFlagFromSync());
  }

}