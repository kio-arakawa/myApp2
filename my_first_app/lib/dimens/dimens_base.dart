import 'dart:io';
import 'package:flutter/material.dart';

class DimensBase extends ChangeNotifier{
  // Platform
  bool _ios = Platform.isIOS;
  bool get isPlatformIos => _ios;
  bool _android = Platform.isAndroid;
  bool get isPlatformAndroid => _android;
  // Orientation情報
  Orientation currentOrientation;

  //再計算する必要があるかどうか
  bool _isNeedReCalcRatio = false;

  double fullHeight = 0;
  double fullWidth = 0;
  static double staticStatusBarHeight = 0;
  double statusBarHeight = 0;
  static double staticHomeIndicatorHeight = 0;
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
    /// staticな値が0なら必ず再計算処理実行
    // Info: Scaffoldのbody内のClassから、「MediaQuery.of(context).padding.[top][bottom]」
    //       の値を取ると、描画できない値として取得してしまうので、再代入しないようにする必要がある
    //       → すなわち、MediaQuery.of(context).padding.[top][bottom]メソッドは、
    //       そのViewからは描画できない範囲の値を返すようになっていると考えられる
    if ( (staticStatusBarHeight == 0 && staticHomeIndicatorHeight == 0)) {
      staticStatusBarHeight = newStatusBarHeight;
      statusBarHeight = newStatusBarHeight;
      staticHomeIndicatorHeight = newHomeIndicatorHeight;
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
      bottomNavigationBarHeight = isPlatformIos
          ? (fullHeightSafeArea * 0.08) + homeIndicatorHeight
          : (fullHeightSafeArea * 0.1) + homeIndicatorHeight;
      viewBaseHeight = fullHeight - (headerHeight + statusBarHeight + bottomNavigationBarHeight);
      viewBaseWidth = fullWidth;
      debugPrint('CurrentOrientation:$currentOrientation, fullHeight:$fullHeight, fullWidth:$fullWidth, paddingTop:$statusBarHeight, paddingBottom:$homeIndicatorHeight, '
          'fullHeightSafeArea:$fullHeightSafeArea, fullWidthSafeArea:$fullWidthSafeArea');
      debugPrint('Call [$T] CalculatorRatio!');
      calculatorRatio<T>();
    }
  }

  void calculatorRatio<T>(){}

}