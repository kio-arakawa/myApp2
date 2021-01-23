import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {

  ///Constructor
  HistoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('historyViewBuild');
    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        height: 900,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              //Columnの中央揃え
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

              ],
            ),
          ),
        ),
      ),
    );
  }
}