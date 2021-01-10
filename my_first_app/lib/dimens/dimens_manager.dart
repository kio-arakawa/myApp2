import 'package:my_first_app/dimens/dimens_home.dart';
import 'package:my_first_app/view/home_view.dart';

class DimensManager {

  static DimensManager _instance;
  static DimensManager get instance => _instance;

  ///Constructor
  DimensManager._() {
    _initialViewDimens();
  }

  factory DimensManager() {
    // nullなら左辺の値を代入
    _instance ??= instance;
    return _instance;
  }

  ///Dimens Home
  DimensHome _dimensHome;
  DimensHome get dimensHomeInstance => _dimensHome;
  static DimensHome get dimensHomeSize => _instance.dimensHomeInstance;

  void _initialViewDimens() {
    _dimensHome ??= DimensHome();
  }

  void calculatorRatio<T>() {
    switch(T) {
      case HomeView:
        _dimensHome ??= DimensHome();
        _dimensHome.calculatorRatio();
        break;
      default:
        print('Dimens Data None!');
        break;
    }
  }

}