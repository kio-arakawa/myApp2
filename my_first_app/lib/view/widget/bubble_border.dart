import 'package:flutter/material.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';

class BubbleBorder extends ShapeBorder {

  BubbleBorder({@required this.isMyRegister});
  final isMyRegister;

  // Container内のpadding的なやつ（今回はContainer側で取っているため設定なし）
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    //
    final r = Rect.fromPoints(rect.topLeft, rect.bottomRight);
    return Path()
      // 角丸長方形を作成する時に使う
      ..addRRect(RRect.fromRectAndRadius(r, Radius.circular(DimensManager.dimensDiarySize.registerTextContainerBorderRadius)))
      // どの方向にどれだけ移動させるか（ex. r.center.dy：Y軸方向中心(x,0)から開始)
      ..moveTo(
        isMyRegister ? r.centerRight.dx : r.centerLeft.dx,
        r.center.dy - 7.5,
      )
      // relativeLineToで点から点へと線を作成する
      ..relativeLineTo(0, 10)
      ..relativeLineTo(
        isMyRegister ? 7 : -7,
        -14,
      )
      ..close()
    ;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

}