import 'package:flutter/material.dart';
import 'package:my_first_app/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: Consumer<ChatViewModel>(
        builder: (_,model,__) {
          return Container(
            // 高さを指定しないと、タイムラインが空白の時テキストボックス＆送信ボタンWidgetができる限り小さくなろうとする
            // すなわち、Positionedでbottomを0指定していても無効化される
            height: sizeHeight,
            margin: EdgeInsets.only(top: 20),
            child: Stack(
              children: <Widget>[

                ///チャットタイムライン
                ListView.builder(
                  padding: EdgeInsets.only(bottom: sizeHeight * 0.075),
                  //ListViewの大きさ自動調整ON(たまに出るエラーを防ぐため)
                  shrinkWrap: true,
                  itemCount: model.listIndex,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                      key: model.key,
                      decoration: BoxDecoration(
                        //角丸にする
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.lightGreen,
                      ),
                      margin: EdgeInsets.only(
                        bottom: 10,
                        left: model.isMyRegisterString ? sizeWidth * 0.05 : 0,
                        right: model.isMyRegisterString ? sizeWidth * 0.01 : 0,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '${model.registerStrings}',
                        //テキストは右寄せ
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                ),

                ///テキストボックスと登録ボタン
                Positioned(
                  height: sizeHeight * 0.075,  ///8%
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
                            child: TextField(
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
                            onPressed: () {
                              model.onTapRegisterButton(textController.value.text);
                            },
                            child: Text('送信'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}