import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {

  ///Constructor
  ChatView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = new TextEditingController();
    ///MediaQueryで端末のサイズを取得する位置はBaseViewでリビルドが走らないとこですべき、またはBaseViewModel
    final Size size = MediaQuery.of(context).size;
    final double sizeHeight = size.height;
    final double sizeWidth = size.width;
    return Stack(
      children: <Widget>[

        ///チャットタイムライン
        ListView(

        ),

        ///テキストボックスと登録ボタン
        Positioned(
          height: sizeHeight * 0.08,  ///8%
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: <Widget>[

                ///テキストフォーム
                Positioned(
                  height: sizeHeight * 0.075,
                  width: sizeWidth * 0.65,
                  left: sizeWidth * 0.07,
                  child: Center(
                    child: TextFormField(
                      controller: textController,
                    ),
                  ),
                ),

                ///登録ボタン
                Positioned(
                  height: sizeHeight * 0.04,
                  width: sizeWidth * 0.2,
                  right: sizeWidth * 0.04,
                  top: sizeHeight * 0.02,
                  child: RaisedButton(
                    color: Colors.grey,
                    shape: StadiumBorder(),
                    onPressed: () {},
                    child: Text("送信"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}