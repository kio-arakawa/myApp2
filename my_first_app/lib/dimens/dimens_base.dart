import 'dart:ui';
import 'package:flutter/material.dart';

class DimensBase {
  // Orientation情報
  Orientation currentOrientation;

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

  void initialDimens<T>(BuildContext context) {
    //初期化
    _isNeedReCalcRatio = false;
    //新規値取得
    final newFullHeight = MediaQuery.of(context).size.height;
    final newFullWidth = MediaQuery.of(context).size.width;
    final newStatusBarHeight = MediaQuery.of(context).padding.top;
    final newHomeIndicatorHeight = MediaQuery.of(context).padding.bottom;
    final newOrientation = MediaQuery.of(context).orientation;
    /// Orientationが変わっていたら必ず再計算
    if (currentOrientation != newOrientation) {
      _isNeedReCalcRatio = true;
    }
    /// 初回または値がなかったら更新（→ 全て計算する）
    if (fullHeight == 0 && fullWidth == 0) {
      _isNeedReCalcRatio = true;
    }
    /// 取れた値が0でない かつ 新旧で異なりがある時のみ更新（→ 全て計算する）
    if ( (statusBarHeight == 0 && homeIndicatorHeight == 0) && (newStatusBarHeight != 0 && newHomeIndicatorHeight != 0) ) {
      statusBarHeight = newStatusBarHeight;
      homeIndicatorHeight = newHomeIndicatorHeight;
      _isNeedReCalcRatio = true;
    }
    /// 全て計算処理する必要がある時のみ処理
    if (_isNeedReCalcRatio == true) {
      currentOrientation = newOrientation;
      fullHeight = newFullHeight;
      fullWidth = newFullWidth;
      fullHeightSafeArea = fullHeight - (statusBarHeight + homeIndicatorHeight);
      fullWidthSafeArea = fullWidth;
      // ⚠︎ScaffoldのAppBarプロパティのpreferredSizeを使用しているため、statusBarHeightは考慮しない
      headerHeight = fullHeightSafeArea * 0.08;
      // ⚠︎SizedBoxを使用する場合は、HomeIndicatorの高さを考慮する
      bottomNavigationBarHeight = (fullHeightSafeArea * 0.08) + homeIndicatorHeight;
      viewBaseHeight = fullHeight - (headerHeight + bottomNavigationBarHeight);
      viewBaseWidth = fullWidth;
      debugPrint('CurrentOrientation:$currentOrientation, fullHeight:$fullHeight, fullWidth:$fullWidth, paddingTop:$statusBarHeight, paddingBottom:$homeIndicatorHeight, '
          'fullHeightSafeArea:$fullHeightSafeArea, fullWidthSafeArea:$fullWidthSafeArea');
      debugPrint('Call [$T] CalculatorRatio!');
      calculatorRatio<T>();
    }
  }

  void calculatorRatio<T>(){}

}