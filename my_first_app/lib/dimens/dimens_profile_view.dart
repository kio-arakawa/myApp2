import 'dimens_base.dart';

class DimensProfileView extends DimensBase {
  /// Variable
  // ProfileView DisplayArea
  double displayAreaHeight = 0;
  double displayAreaWidth = 0;
  double displayAreaMarginTop = 0;
  // Avatar Image
  double avatarContainerHalfHeight = 0;
  double avatarContainerWidth = 0;
  // UserName Container
  double userNameFieldHeight = 0;
  double userNameFieldWidth = 0;

  @override
  void calculatorRatio<ProfileView>() {
    // DisplayArea
    displayAreaHeight = fullHeightSafeArea - headerHeight;
    displayAreaWidth = fullWidthSafeArea;
    displayAreaMarginTop = displayAreaHeight * 0.05;
    // Avatar
    avatarContainerHalfHeight = displayAreaHeight * 0.1;
    avatarContainerWidth = fullWidthSafeArea;
    // UserNameContainer
    userNameFieldHeight = displayAreaHeight * 0.2;
  }

}