import 'package:flutter/material.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/model/moor_db.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view_model/diary_view_model.dart';
import 'package:my_first_app/model/data_base_model.dart';
import 'package:my_first_app/view/widget/bubble_border.dart';

class DiaryView extends StatelessWidget {

  final BaseViewModel _baseViewModel = BaseViewModel();

  ///Constructor
  DiaryView({Key key}) : super(key: key);

  void _initializer(BuildContext context) {
    DimensManager.dimensDiarySize.initialDimens<DiaryView>(context);
    //BottomNavigationBarのロック
//    _baseViewModel.setState(DataBaseState.CONNECTING);
    //buildメソッドを抜けた＝＝通信が完了した
    //→ BottomNavigationBarのロック解除
//    WidgetsBinding.instance.addPostFrameCallback((cb) {
//      _baseViewModel.setState(DataBaseState.STOP);
//    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('diaryViewBuild');
    _initializer(context);
    final TextEditingController textController = new TextEditingController();
    final databaseStream = Provider.of<DataBaseModel>(context);
    //LoginViewに戻さない
    return WillPopScope(
      onWillPop: () async => true,
      //横画面の時用にSafeAreaでラップ
      child: SafeArea(
        child: Container(
//          height: DimensManager.dimensDiarySize.fullHeight,
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//              begin: FractionalOffset.topCenter,
//              end: FractionalOffset.bottomCenter,
//              colors: [
//                Colors.white.withOpacity(1),
//                Colors.grey.withOpacity(1),
//              ],
//            ),
//          ),
          child: Consumer<ChatViewModel>(
            builder: (_,model,__) {
              return Container(
                // 高さを指定しないと、タイムラインが空白の時テキストボックス＆送信ボタンWidgetができる限り小さくなろうとする
                // すなわち、Positionedでbottomを0指定していても無効化される
                height: DimensManager.dimensDiarySize.viewBaseHeight,
//              width: DimensManager.dimensDiarySize.viewBaseWidth,
                margin: EdgeInsets.only(top: DimensManager.dimensDiarySize.diaryListTopMargin),
                child: StreamBuilder(
                  initialData: DataBaseState.STOP,
                  stream: databaseStream.state,
                  builder: (BuildContext context, AsyncSnapshot<DataBaseState> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.done) {
                      if (model.getState == DataBaseState.STOP) {
                        return Stack(
                          children: <Widget>[

                            ///チャットタイムライン
                            FutureBuilder(
                              future: model.getFutureData(),
                              builder: (_, AsyncSnapshot<List<MoorDataBase>> snapshot) {
                                debugPrint('data:${snapshot.data}');
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  //BottomNavigationロック
//                              _baseViewModel.setState(DataBaseState.CONNECTING);
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                                    ),
                                  );
                                } else {
                                  if (snapshot.hasData) {
                                    //BottomNavigationロック
//                                _baseViewModel.setState(DataBaseState.STOP);
                                    return ListView.builder(
                                      padding: EdgeInsets.only(bottom: DimensManager.dimensDiarySize.diaryListBottomMargin),
                                      //ListViewの大きさ自動調整ON(たまに出るエラーを防ぐため)
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (_, int widgetId) {
                                        return snapshot.data.isNotEmpty
                                            ? _chatWidget(model, snapshot.data[widgetId])
                                            : Container()
                                        ;
                                      },
                                    );
                                  }
                                  //BottomNavigationロック
//                              _baseViewModel.setState(DataBaseState.CONNECTING);
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                                    ),
                                  );
                                }
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
                                  color: model.getIsCurrentDarkMode() ? Colors.grey.withOpacity(0.95): Colors.white.withOpacity(0.95),
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
        ),
      ),
    );
  }

  Widget _chatWidget(ChatViewModel model, MoorDataBase data) {
    return Align(
      //Todo:自分が登録したか、相手が登録したかもDBに登録する（現状エラーになる）
      //Todo:tensionのアリナシで、自分か相手（Non)かを判定することにする予定
      alignment: model.isMyRegister ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        key: model.key,
        // 自作のBubbleBorderクラスで吹き出し方のContainerを作成
        decoration: ShapeDecoration(
          color: model.isMyRegister ? Colors.blueGrey.withOpacity(0.3) : Colors.grey,
          shape: BubbleBorder(isMyRegister: model.isMyRegister),
        ),
        margin: EdgeInsets.only(
          left: model.isMyRegister
              ? DimensManager.dimensDiarySize.registerTextContainerForeMargin
              : DimensManager.dimensDiarySize.registerTextContainerBackMargin,
          right: model.isMyRegister
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
          '${data.diaryTexts}',
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