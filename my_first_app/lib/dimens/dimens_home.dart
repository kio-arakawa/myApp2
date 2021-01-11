import 'package:my_first_app/dimens/dimens_base.dart';

class DimensHome extends DimensBase {

  static DimensHome _instance;

  static DimensHome get instance => _instance;

  DimensHome._();

  factory DimensHome() {
    _instance ??= DimensHome._();
    return _instance;
  }

  @override
  void calculatorRatio<DimensHome>() {

  }

}