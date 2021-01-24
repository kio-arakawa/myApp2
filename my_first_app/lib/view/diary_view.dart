import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view_model/diary_view_model.dart';
import 'package:my_first_app/model/data_base_model.dart';
import 'package:my_first_app/dimens/dimens_diary.dart';
import 'package:my_first_app/view/widget/bubble_border.dart';

class DiaryView extends StatelessWidget {

  ///Constructor
  DiaryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('diaryViewBuild');
    DimensManager.dimensDiarySize.initialDimens<DiaryView>();
    final TextEditingController textController = new TextEditingController();
    final databaseStream = Provider.of<DataBaseModel>(context);
    return WillPopScope(
      onWillPop: () async => true,
      child: Consumer<ChatViewModel>(
        builder: (_,model,__) {
          return Container(
            // 高さを指定しないと、タイムラインが空白の時テキストボックス＆送信ボタンWidgetができる限り小さくなろうとする
            // すなわち、Positionedでbottomを0指定していても無効化される
            height: DimensManager.dimensDiarySize.viewBaseHeight,
            width: DimensManager.dimensDiarySize.viewBaseWidth,
            margin: EdgeInsets.only(top: DimensManager.dimensDiarySize.diaryListTopMargin),
            child: StreamBuilder(
              initialData: DataBaseState.STOP,
              stream: databaseStream.state,
              builder: (BuildContext context, AsyncSnapshot<DataBaseState> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.done) {
                  if (model.getState == DataBaseState.STOP) {
                    return Stack(
                      children: <Widget>[

//                      model.chatWidgetMap[model.listIndex],

                        ///チャットタイムライン
                        ListView.builder(
                          padding: EdgeInsets.only(bottom: DimensManager.dimensDiarySize.diaryListBottomMargin),
                          //ListViewの大きさ自動調整ON(たまに出るエラーを防ぐため)
                          shrinkWrap: true,
                          itemCount: model.listIndex,
                          itemBuilder: (BuildContext context, int i) {
                            return model.registerStrings.isNotEmpty
                                ? _chatWidget(model)
                                : Container()
                            ;
                          },
                        ),

                        ///テキストボックスと登録ボタン
                        Positioned(
                          height: DimensManager.dimensDiarySize.inputTextBoxAndRegisterButtonContainerHeight,  ///0.075
                          left: DimensManager.dimensDiarySize.zero,
                          right: DimensManager.dimensDiarySize.zero,
                          bottom: DimensManager.dimensDiarySize.zero,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: <Widget>[

                                ///テキストフォーム
                                Positioned(
                                  height: DimensManager.dimensDiarySize.inputTextBoxHeight,
                                  width: DimensManager.dimensDiarySize.inputTextBoxWidth,
                                  left: DimensManager.dimensDiarySize.inputTextBoxMarginLeft,
                                  child: Center(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black),
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      controller: textController,
                                    ),
                                  ),
                                ),

                                ///登録ボタン
                                Positioned(
                                  height: DimensManager.dimensDiarySize.registerButtonHeight,
                                  width: DimensManager.dimensDiarySize.registerButtonWidth,
                                  top: DimensManager.dimensDiarySize.registerButtonMarginTop,
                                  right: DimensManager.dimensDiarySize.registerButtonMarginRight,
                                  child: RaisedButton(
                                    color: Colors.grey,
                                    shape: StadiumBorder(),
                                    onPressed: () {
                                      //通信中はBottomNavigationロック
//                                    _baseViewModel.setState(DataBaseState.CONNECTING);
                                      /// 登録ボタン押下時Action
                                      model.onTapRegisterButton(textController);
//                                    model.setChatWidget(++model.listIndex, _chatWidget(model, sizeWidth));
                                    },
                                    child: FittedBox(
                                      child: Text(
                                        '記録',
                                        style: TextStyle(
                                          fontSize: DimensManager.dimensDiarySize.registerButtonTextSize,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
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
      ),
    );
  }

  Widget _chatWidget(ChatViewModel model) {
    return Align(
      alignment: model.isMyRegisterString ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        key: model.key,
        decoration: ShapeDecoration(
          color: model.isMyRegisterString ? Colors.lightGreen : Colors.grey,
          shape: BubbleBorder(isMyRegister: model.isMyRegisterString),
        ),
        margin: EdgeInsets.only(
          left: model.isMyRegisterString
              ? DimensManager.dimensDiarySize.registerTextContainerForeMargin
              : DimensManager.dimensDiarySize.registerTextContainerBackMargin,
          right: model.isMyRegisterString
              ? DimensManager.dimensDiarySize.registerTextContainerBackMargin
              : DimensManager.dimensDiarySize.registerTextContainerForeMargin,
          bottom: DimensManager.dimensDiarySize.registerTextContainerMarginBottom,
        ),
        padding: EdgeInsets.fromLTRB(
          DimensManager.dimensDiarySize.registerTextContainerPaddingHorizontal,
          DimensManager.dimensDiarySize.registerTextContainerPaddingVertical,
          DimensManager.dimensDiarySize.registerTextContainerPaddingHorizontal,
          DimensManager.dimensDiarySize.registerTextContainerPaddingVertical,
        ),
        child: Text(
          //登録内容
          '${model.registerStrings}',
          //テキストは左寄せ
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: DimensManager.dimensDiarySize.registerTextFontSize,
          ),
        ),
      ),
    );

  }

}