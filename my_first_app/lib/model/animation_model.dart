import 'package:flutter/material.dart';

class AnimationModel extends ChangeNotifier {

  ///Variable
  //アニメーション停止フラグ
  bool _isAnimationStop = false;
  bool get getAnimationState => _isAnimationStop;

  void stopAnimation(bool value) {
    _isAnimationStop = value;
    notifyListeners();
  }

}