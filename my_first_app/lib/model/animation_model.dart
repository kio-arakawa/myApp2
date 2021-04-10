import 'package:my_first_app/view_model/change_notifier_model.dart';

// LoginViewのBackGroundAnimation状態
enum BackGroundAnimationState {
  // アニメーション中
  RUNNING,
  // 停止中
  PAUSE,
}

class AnimationModel extends ChangeNotifierModel {

  AnimationModel._();
  static AnimationModel _instance;
  factory AnimationModel() {
    return _instance ??= AnimationModel._();
  }

  ///Variable
  //アニメーション停止フラグ
  BackGroundAnimationState _backGroundAnimationState;
  BackGroundAnimationState get getBackGroundAnimationState => _backGroundAnimationState;

  // BackGroundAnimation状態の変更通知
  void changeAnimationState(BackGroundAnimationState state) {
    _backGroundAnimationState = state;
    notifyListeners();
  }

}