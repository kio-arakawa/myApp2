import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view_model/diary_view_model.dart';
import 'package:my_first_app/model/data_base_model.dart';

class DiaryView extends StatelessWidget {

  ///Constructor
  DiaryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('diaryViewBuild');
    final textController = new TextEditingController();
    ///MediaQueryで端末のサイズを取得する位置はBaseViewでリビルドが走らないとこですべき、またはBaseViewModel
    final Size size = MediaQuery.of(context).size;
    final double sizeHeight = size.height;
    final double sizeWidth = size.width;
    final databaseStream = Provider.of<DataBaseModel>(context);
    return Consumer<ChatViewModel>(
      builder: (_,model,__) {
        return Container(
          // 高さを指定しないと、タイムラインが空白の時テキストボックス＆送信ボタンWidgetができる限り小さくなろうとする
          // すなわち、Positionedでbottomを0指定していても無効化される
          height: sizeHeight,
          margin: EdgeInsets.only(top: 20),
          child: StreamBuilder(
            initialData: DataBaseState.STOP,
            stream: databaseStream.state,
            builder: (BuildContext context, AsyncSnapshot<DataBaseState> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.done) {
                if (model.getState == DataBaseState.STOP) {
                  return Stack(
                    children: <Widget>[

//                      model.chatWidgetMap[model.listIndex],

//                      ///チャットタイムライン
                      ListView.builder(
                        padding: EdgeInsets.only(bottom: sizeHeight * 0.075),
                        //ListViewの大きさ自動調整ON(たまに出るエラーを防ぐため)
                        shrinkWrap: true,
                        itemCount: model.listIndex,
                        itemBuilder: (BuildContext context, int i) {
                          return _chatWidget(model, sizeWidth);
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
                                  onPressed: () {
                                    //通信中はBottomNavigationロック
//                                    _baseViewModel.setState(DataBaseState.CONNECTING);
                                    model.onTapRegisterButton(textController.value.text);
//                                    model.setChatWidget(++model.listIndex, _chatWidget(model, sizeWidth));
                                  },
                                  child: Text('記録'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }

              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      },
    );
  }

  Widget _chatWidget(ChatViewModel model, double sizeWidth) {
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
  }

}