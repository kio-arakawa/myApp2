import 'package:my_first_app/dimens/dimens_history_view.dart';
import 'package:my_first_app/dimens/dimens_home.dart';
import 'package:my_first_app/dimens/dimens_profile_view.dart';
import 'package:my_first_app/dimens/dimens_setting_view.dart';
import 'package:my_first_app/view/diary_view.dart';
import 'package:my_first_app/view/history_view.dart';
import 'package:my_first_app/view/home_view.dart';
import 'package:my_first_app/dimens/dimens_diary.dart';
import 'package:my_first_app/view/profile_view.dart';
import 'package:my_first_app/view/setting_view.dart';

class DimensManager {

  ///Constructor
  DimensManager._() {
    _initialViewDimens();
    print('DimensManager Instance!');
  }
  static DimensManager _instance;
  static DimensManager get instance => _instance;
  factory DimensManager() {
    // nullなら左辺の値を代入
    return _instance ??= DimensManager._();
  }

  ///Dimens Home
  DimensHome _dimensHome;
  DimensHome get dimensHomeInstance => _dimensHome;
  static DimensHome get dimensHomeSize => _instance.dimensHomeInstance;
  ///Dimens Diary
  DimensDiary _dimensDiary;
  DimensDiary get dimensDiaryInstance => _dimensDiary;
  static DimensDiary get dimensDiarySize => _instance.dimensDiaryInstance;
  /// Dimens Profile
  DimensProfileView _dimensProfileView;
  DimensProfileView get dimensProfileInstance => _dimensProfileView;
  static DimensProfileView get dimensProfileViewSize => _instance.dimensProfileInstance;
  /// Dimens History
  DimensHistoryView _dimensHistoryView;
  DimensHistoryView get dimensHistoryInstance => _dimensHistoryView;
  static DimensHistoryView get dimensHistoryViewSize => _instance.dimensHistoryInstance;
  /// Dimens Setting
  DimensSettingView _dimensSettingView;
  DimensSettingView get dimensSettingInstance => _dimensSettingView;
  static DimensSettingView get dimensSettingViewSize => _instance.dimensSettingInstance;

  void _initialViewDimens() {
    _dimensHome ??= DimensHome();
    _dimensDiary ??= DimensDiary();
    _dimensProfileView ??= DimensProfileView();
    _dimensHistoryView ??= DimensHistoryView();
    _dimensSettingView ??= DimensSettingView();
  }

  void initialDimens<T>() {
    switch(T) {
      case HomeView:
        _dimensHome ??= DimensHome();
        _dimensHome.calculatorRatio<HomeView>();
        break;
      case DiaryView:
        _dimensDiary ??= DimensDiary();
        _dimensDiary.calculatorRatio<DiaryView>();
        break;
      case ProfileView:
        _dimensProfileView ??= DimensProfileView();
        _dimensProfileView.calculatorRatio<ProfileView>();
        break;
      case HistoryView:
        _dimensHistoryView ??= DimensHistoryView();
        _dimensHistoryView.calculatorRatio<HistoryView>();
        break;
      case SettingView:
        _dimensSettingView ??= DimensSettingView();
        _dimensSettingView.calculatorRatio<SettingView>();
        break;
      default:
        print('Dimens Data None!');
        break;
    }
  }

}