import 'package:flutter/material.dart';

class AnimationModel extends ChangeNotifier{

  ///Variable
  //アニメーション停止フラグ
  bool isAnimationStop = false;

  void stopAnimation(bool value) {
    isAnimationStop = value;
    notifyListeners();
  }

}