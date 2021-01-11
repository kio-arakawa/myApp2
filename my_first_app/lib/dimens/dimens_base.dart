import 'dart:ui';

import 'package:flutter/material.dart';

class DimensBase {

  double fullHeight = 0;
  double fullWidth = 0;
  double paddingTop = 0;
  double paddingBottom = 0;
  double fullHeightSafeArea = 0;
  double fullWidthSafeArea = 0;
  double headerHeight = 0;
  double bottomNavigationBarHeight = 0;

  void initialDimens<T>() {
    fullHeight = MediaQueryData.fromWindow(window).size.height;
    fullWidth = MediaQueryData.fromWindow(window).size.width;
    paddingTop = MediaQueryData.fromWindow(window).padding.top;
    paddingBottom = MediaQueryData.fromWindow(window).padding.bottom;
    fullHeightSafeArea = fullHeight - (paddingTop + paddingBottom);
    fullHeightSafeArea = fullWidth;
    headerHeight = fullHeightSafeArea * 0.13;
    bottomNavigationBarHeight = fullHeightSafeArea * 0.15;
    print('fullHeight:$fullHeight, fullWidth:$fullWidth, paddingTop:$paddingTop, paddingBottom:$paddingBottom, '
        'fullHeightSafeArea:$fullHeightSafeArea, fullWidthSafeArea:$fullWidthSafeArea');

    calculatorRatio();
  }

  void calculatorRatio<T>(){}

}