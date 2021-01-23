import 'package:my_first_app/dimens/dimens_home.dart';
import 'package:my_first_app/view/diary_view.dart';
import 'package:my_first_app/view/home_view.dart';
import 'package:my_first_app/dimens/dimens_diary.dart';

class DimensManager {

  static DimensManager _instance;
  static DimensManager get instance => _instance;

  ///Constructor
  DimensManager._() {
    _initialViewDimens();
  }

  factory DimensManager() {
    // nullなら左辺の値を代入
    _instance ??= DimensManager._();
    return _instance;
  }

  ///Dimens Home
  DimensHome _dimensHome;
  DimensHome get dimensHomeInstance => _dimensHome;
  static DimensHome get dimensHomeSize => _instance.dimensHomeInstance;
  ///Dimens Diary
  DimensDiary _dimensDiary;
  DimensDiary get dimensDiaryInstance => _dimensDiary;
  static DimensDiary get dimensDiarySize => _instance.dimensDiaryInstance;

  void _initialViewDimens() {
    _dimensHome ??= DimensHome();
    _dimensDiary ??= DimensDiary();
  }

  void initialDimens<T>() {
    switch(T) {
      case HomeView:
        _dimensHome ??= DimensHome();
        _dimensHome.calculatorRatio();
        break;
      case DiaryView:
        _dimensDiary ??= DimensDiary();
        _dimensDiary.calculatorRatio();
        break;
      default:
        print('Dimens Data None!');
        break;
    }
  }

}