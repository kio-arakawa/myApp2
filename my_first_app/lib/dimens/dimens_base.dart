import 'dart:ui';
import 'package:flutter/material.dart';

class DimensBase {

  //再計算する必要があるかどうか
  bool _isNeedReCalcRatio = false;

  double fullHeight = 0;
  double fullWidth = 0;
  double statusBarHeight = 0;
  double homeIndicatorHeight = 0;
  double fullHeightSafeArea = 0;
  double fullWidthSafeArea = 0;
  double headerHeight = 0;
  double bottomNavigationBarHeight = 0;
  //zero
  final double zero = 0.0;
  //全てのViewの高さ
  double viewBaseHeight = 0;
  double viewBaseWidth = 0;

  void initialDimens<T>() {
    final newFullHeight = MediaQueryData.fromWindow(window).size.height;
    final newFullWidth = MediaQueryData.fromWindow(window).size.width;
    final newStatusBarHeight = MediaQueryData.fromWindow(window).padding.top;
    final newHomeIndicatorHeight = MediaQueryData.fromWindow(window).padding.bottom;
    if (fullHeight == 0 && fullWidth == 0) {
      fullHeight = newFullHeight;
      fullWidth = newFullWidth;
      debugPrint('Calc FullHeight & FullWidth!');
      _isNeedReCalcRatio = true;
    }
    if ( (statusBarHeight == 0 && homeIndicatorHeight == 0) && (newStatusBarHeight != 0 && newHomeIndicatorHeight != 0) ) {
      statusBarHeight = newStatusBarHeight;
      homeIndicatorHeight = newHomeIndicatorHeight;
      debugPrint('Calc statusBarHeight & homeIndicatorHeight!');
      _isNeedReCalcRatio = true;
    }
    if (_isNeedReCalcRatio == true) {
      fullHeightSafeArea = fullHeight - (statusBarHeight + homeIndicatorHeight);
      fullHeightSafeArea = fullWidth;
      headerHeight = (fullHeightSafeArea * 0.05) + statusBarHeight;
      bottomNavigationBarHeight = (fullHeightSafeArea * 0.15) + homeIndicatorHeight;
      viewBaseHeight = fullHeight - (headerHeight + bottomNavigationBarHeight);
      viewBaseWidth = fullWidth;
      print('fullHeight:$fullHeight, fullWidth:$fullWidth, paddingTop:$statusBarHeight, paddingBottom:$homeIndicatorHeight, '
          'fullHeightSafeArea:$fullHeightSafeArea, fullWidthSafeArea:$fullWidthSafeArea');

      calculatorRatio<T>();
    }
  }

  void calculatorRatio<T>(){}

}