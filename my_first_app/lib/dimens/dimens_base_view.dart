import 'package:my_first_app/dimens/dimens_base.dart';

class DimensBaseView extends DimensBase {
  /// Variable
  // Body部分の高さ
  double tutorialPageBodyHeight = 0;
  // Button部分の高さ
  double tutorialPageButtonHeight = 0;

  void calculatorRatio<BaseView>(){
    tutorialPageBodyHeight = fullHeight * 0.85;
    tutorialPageButtonHeight = fullHeight - tutorialPageBodyHeight;
  }

}