import 'package:flutter/material.dart';

import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view_model/setting_view_model.dart';


class SplashView extends StatefulWidget {

  ///Constructor
  SplashView(this._baseViewModel, this._settingViewModel);

  ///Variable
  final BaseViewModel _baseViewModel;
  final SettingViewModel _settingViewModel;

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin{

  ///Variable
  AnimationController _controller;
  CurvedAnimation _curvedAnimation;
  Animation<double> _scale;

  @override
  void initState() {
    debugPrint('splashViewBuild');
    super.initState();

    //文字アニメーション用controller初期化(初回起動時のみ)
    if (_controller == null) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 6000),
        vsync: this,
      )
        ..addListener(() {
          setState(() {});
        });
      //CurveTransition初期化
      _curvedAnimation = CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.30, 0.70,
          curve: Curves.elasticIn,
        ),
      );

      //ScaleTransition初期化
      _scale = Tween(begin: 1.0, end: 0.0).animate(_curvedAnimation);

      //アニメーション開始
      _controller.forward();
    }

    //View終了タイマー発行
    widget._baseViewModel.initSplash();
  }

  //(アプリkill時のみ)
  @override
  void dispose() {
    //controller破棄
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: widget._baseViewModel.isStartFadeOut ? 0.0 : 1.0,
      child: Scaffold(
        body: Container(
          color: Colors.grey,
          child: Center(
            child: Transform.scale(
              scale: _scale.value,
              child: Text(
                'Roding Now...',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}