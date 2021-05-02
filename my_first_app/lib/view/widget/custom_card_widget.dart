import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  /// Variable
  final bool isCard;
  final double height;
  final double width;
  final Color cardColor;
  final Widget child;

  /// Constructor
  CustomCardWidget({
    this.isCard,
    this.child,
    this.cardColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
  return Container(
    width: width,
    height: height,
    margin: EdgeInsets.all(10.0),
    decoration: isCard
        ? BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1.0,
                blurRadius: 10.0,
                offset: Offset(10, 10),
              ),
            ],
          )
        : BoxDecoration(),
    child: isCard
        ? Card(
            color: cardColor,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: child,
            ),
          )
        : Padding(
            padding: EdgeInsets.all(10.0),
            child: child,
          ),
    );
  }

}