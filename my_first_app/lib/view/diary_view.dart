import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:my_first_app/constants.dart';
import 'package:my_first_app/dimens/dimens_diary.dart';
import 'package:my_first_app/dimens/dimens_manager.dart';
import 'package:my_first_app/model/app_theme_model.dart';
import 'package:my_first_app/model/db/moor_db.dart';
import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:my_first_app/state/state_manager.dart';
import 'package:my_first_app/view_model/base_view_model.dart';
import 'package:my_first_app/view_model/diary_view_model.dart';
import 'package:my_first_app/view/widget/bubble_border.dart';

class DiaryView extends HookWidget {

  /// Constructor
  DiaryView({Key key}) : super(key: key);

  /// Variable
  // Info: Widgetツリー内でコントローラーを定義すると、キーボードを閉じる度に
  //       ツリーが初期化され、入力中テキストがクリアされてしまう。
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode onFocus = FocusNode();

  void _initializer(
      BuildContext context,
      BaseViewModel baseViewModel,
      ChatViewModel chatViewModel,
      DimensDiary dimensDiary,
      ) {
    // Info: キーボードに初回フォーカス当たった時
    onFocus.addListener(() {
      chatViewModel.initFocusTextFormField(
        textController.text,
        DimensManager.dimensDiarySize.inputTextBoxTextSize,
        DimensManager.dimensDiarySize.inputTextBoxWidth,
        1,
        dimensDiary,
      );
    });
    DimensManager.dimensDiarySize.initialDimens<DiaryView>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      baseViewModel.setState(DataBaseState.STOP);
      if(scrollController.hasClients) {
        scrollController.animateTo(
          100.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ChatViewModel chatViewModel = useProvider(diaryViewModelProvider);
    final BaseViewModel baseViewModel = useProvider(baseViewModelProvider);
    final DimensDiary dimensDiary = useProvider(dimensDiaryProvider);
    final AppThemeModel appThemeModel = useProvider(appThemeModelProvider);
    debugPrint('diaryViewBuild');
    _initializer(context, baseViewModel, chatViewModel, dimensDiary);
    //LoginViewに戻さない
    return WillPopScope(
      onWillPop: () async => true,
      //横画面の時用にSafeAreaでラップ
      child: Container(
        color: appThemeModel.isAppThemeDarkNow() ? Colors.black : Colors.white,
        child: SafeArea(
          child: GestureDetector(
                // 画面どこでもタップでキーボードを閉じる
                onTap: () {
                  debugPrint('keyBoard Close!');
                  FocusScope.of(context).unfocus();
//                chatViewModel.changeTextFormToMaxLines1();
                },
                child: Container(
                  // 高さを指定しないと、タイムラインが空白の時テキストボックス＆送信ボタンWidgetができる限り小さくなろうとする
                  // すなわち、Positionedでbottomを0指定していても無効化される
                  height: DimensManager.dimensDiarySize.viewBaseHeight,
                  margin: EdgeInsets.only(top: DimensManager.dimensDiarySize.diaryListTopMargin),
                  //LoginViewに戻さない
                  child: StreamBuilder(
                    initialData: DataBaseState.STOP,
                    stream: chatViewModel.state,
                    builder: (BuildContext context, AsyncSnapshot<DataBaseState> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.done) {
                        if (chatViewModel.getState == DataBaseState.STOP) {
                          return Stack(
                            fit: StackFit.expand,
                            children: <Widget>[

                              ///チャットタイムライン
                              FutureBuilder(
                                future: chatViewModel.getFutureData(),
                                builder: (_, AsyncSnapshot<List<MoorDataBase>> snapshot) {
                                  debugPrint('data:${snapshot.data}');
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    // Info: 小さなぐるぐるを出さないように、1s間delayする
                                    return FutureBuilder(
                                      future: Future.delayed(Duration(milliseconds: Constants.circleProgressIndicatorBuildWaitTime)),
                                      builder: (_, delayTime) {
                                        if (delayTime.connectionState == ConnectionState.done) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    );
                                  } else {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        controller: scrollController,
                                        padding: EdgeInsets.only(bottom: DimensManager.dimensDiarySize.diaryListBottomMargin),
                                        //ListViewの大きさ自動調整ON(たまに出るエラーを防ぐため)
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (_, int widgetId) {
                                          return snapshot.data.isNotEmpty
                                              ? _chatWidget(chatViewModel, snapshot.data[widgetId])
                                              : Container()
                                          ;
                                        },
                                      );
                                    }
                                    // Info: 小さなぐるぐるを出さないように、1s間delayする
                                    return FutureBuilder(
                                      future: Future.delayed(Duration(milliseconds: Constants.circleProgressIndicatorBuildWaitTime)),
                                      builder: (_, delayTime) {
                                        if (delayTime.connectionState == ConnectionState.done) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    );
                                  }
                                },
                              ),

                              ///テキストボックスと登録ボタン
                              Positioned(
                                height: dimensDiary.inputTextBoxAndRegisterButtonContainerHeight,
                                left: DimensManager.dimensDiarySize.zero,
                                right: DimensManager.dimensDiarySize.zero,
                                bottom: DimensManager.dimensDiarySize.zero,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
                                    color: appThemeModel.isAppThemeDarkNow()
                                        ? Colors.black.withOpacity(0.85)
                                        : Colors.white.withOpacity(0.95),
                                  ),
                                  child: Stack(
                                    children: <Widget>[

                                      ///テキストフォーム
                                      Positioned(
                                        height: dimensDiary.inputTextBoxHeight,
                                        width: DimensManager.dimensDiarySize.inputTextBoxWidth,
                                        left: DimensManager.dimensDiarySize.inputTextBoxMarginLeft,
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(
                                            vertical: 5.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                vertical: 0.0,
//                                              horizontal: 10.0
                                              ),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.transparent),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.transparent),
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: appThemeModel.isAppThemeDarkNow() ? Colors.white : Colors.black,
                                              fontSize: DimensManager.dimensDiarySize.inputTextBoxTextSize,
                                              letterSpacing: 1,
                                            ),
                                            controller: textController,
                                            maxLines: null,
                                            keyboardType: TextInputType.multiline,
                                            onChanged: (text) {
                                              chatViewModel.checkTextFormMaxLine3(
                                                text,
                                                DimensManager.dimensDiarySize.inputTextBoxTextSize,
                                                DimensManager.dimensDiarySize.inputTextBoxWidth,
                                                1,
                                                dimensDiary,
                                              );
                                            },
                                            focusNode: onFocus,
                                          ),
                                        ),
                                      ),

                                      ///登録ボタン
                                      Positioned(
                                        height: DimensManager.dimensDiarySize.registerButtonHeight,
                                        width: DimensManager.dimensDiarySize.registerButtonWidth,
                                        top: dimensDiary.registerButtonMarginTop,
                                        right: DimensManager.dimensDiarySize.inputTextBoxMarginRight,
                                        child: RaisedButton(
                                          color: Colors.grey.withOpacity(0.6),
                                          shape: StadiumBorder(),
                                          elevation: 10,
                                          highlightColor: Colors.blue,
                                          highlightElevation: 15,
                                          onPressed: () {
                                            if(textController.text.isNotEmpty) {
                                              //通信中はBottomNavigationロック
                                              baseViewModel.setState(DataBaseState.CONNECTING);
                                              /// 登録ボタン押下時Action
                                              chatViewModel.onTapRegisterButton(textController);
                                              scrollController.animateTo(
                                                scrollController.position.maxScrollExtent,
                                                duration: const Duration(milliseconds: 500),
                                                curve: Curves.easeOut,
                                              );
                                            }
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
                ),
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