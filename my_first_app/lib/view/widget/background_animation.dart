import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:my_first_app/model/animation_model.dart';

class BackGroundAnimation extends StatefulWidget {

  ///Constructor
  BackGroundAnimation(this._animationModel);

  ///Variable
  AnimationModel _animationModel;

  @override
  _BackGroundAnimationState createState() => _BackGroundAnimationState();
}

class _BackGroundAnimationState extends State<BackGroundAnimation> {

  ///Variable
  //Opacity用タイマーフラグ
  bool isOpacity = false;
  //Alignmentリスト取り出し用数値
  int _alignmentIndex1 = 0;
  int _alignmentIndex2 = 0;
  //Randomインスタンス
  Random _random;
  //アニメーションTimer
  Timer _opacityTimers;
  Timer _alignmentTimers;

  //Alignment位置指定用リスト
  static const List<Alignment> _alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  @override
  void initState() {
    super.initState();
    _random  = new Random();
    _opacityTimer();
    _alignmentTimer();
  }

  @override
  void dispose() {
    //Todo
    //アニメーションTimerのメモリリソース解放
    _opacityTimers.cancel();
    _alignmentTimers.cancel();
    super.dispose();
  }

  //Opacity用タイマー開始API
  void _opacityTimer() {
    _opacityTimers = Timer.periodic(
      Duration(milliseconds: 4000),
      _changeOpacity,
    );
  }

  //animationTimer用CallBack
  void _changeOpacity(Timer timer) {
    isOpacity = !isOpacity;
    setState(() {});
  }

  //Alignment用タイマー開始API
  void _alignmentTimer() {
    _alignmentTimers = Timer.periodic(
      Duration(milliseconds: 2000),
      _changeAlignment,
    );
  }

  //alignmentTimer用CallBack
  void _changeAlignment(Timer timer) {
    //乱数生成
    _alignmentIndex1 = _random.nextInt(5);
    _alignmentIndex2 = _random.nextInt(5);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget._animationModel.isAnimationStop) {
      return Container();
    } else {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 3000),
        opacity: isOpacity ? 0.2 : 0.05,
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[

              AnimatedContainer(
                duration: Duration(milliseconds: 3000),
                alignment: _alignments[_alignmentIndex1],
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: const BorderRadius.all(const Radius.circular(100.0)),
                  ),
                ),
              ),

              AnimatedContainer(
                duration: Duration(milliseconds: 5000),
                alignment: _alignments[_alignmentIndex2],
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    border: Border.all(
                      color: Colors.indigoAccent,
                    ),
                    borderRadius: const BorderRadius.all(const Radius.circular(100.0)),
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    }
  }

}