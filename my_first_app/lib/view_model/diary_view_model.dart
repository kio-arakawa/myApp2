import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:sqflite/sqflite.dart';

import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:my_first_app/view_model/change_notifier_model.dart';
import 'package:my_first_app/model/moor_db.dart';

class ChatViewModel extends ChangeNotifierModel {

  ///Constructor
  ChatViewModel._() {
    _myDatabase ??= MyDatabase();
  }

  static ChatViewModel _chatViewModel;
  static ChatViewModel _instance() => ChatViewModel._();
  //factory constructor
  factory ChatViewModel() {
    _chatViewModel ??= _instance();
    return _chatViewModel;
  }

  ///Variable
  //データベース
  MyDatabase _myDatabase;
  //登録内容
  String registerStrings;
  //自分が送信したかどうか
  bool isMyRegisterString;
  //リストの数
  // Todo: データベースから日記リストの登録内容を取得し、起動時に全件表示する
  int listIndex = 0;
  //リストのKey
  ValueKey key;
  //初期値「0:Container()」
  Map<int, Widget> chatWidgetMap = {0 : Container()};

  ///ValueKey生成用API
  ValueKey _createValueKey(int listIndex) {
    key = ValueKey(listIndex);
    return key;
  }


  ///登録ボタン押下時API
  void onTapRegisterButton(TextEditingController controller) {
    ///_chatWidgetに入力内容をセット
    registerStrings = controller.value.text;
    ///空文字の時は登録しない（_chatWidgetも生成しないし、変更通知もしない）
    if (registerStrings.isNotEmpty) {
      ///データベース処理
      //データ登録
      _myDatabase.addDiary(
        MoorDataBasesCompanion(
          diaryTexts: Value(registerStrings),
          // Todo:テンションをセットできるようにする
          tension: Value('Good'),
        ),
      );
      //自分で登録した時はTrueにする
      isMyRegisterString = true;
      //リスト(Container)の数を増やす
      listIndex++;
      //テキストフィールドの文字をクリア
      controller.clear();
      final Future allData = _myDatabase.allDiaryEntries;
      allData.then((value) {
        final List<MoorDataBase> data = value;
        if (data.length > 10) {
          debugPrint('登録数が10件を超えました。全件削除します。');
          _myDatabase.deleteAllDiary().then((value) {
            debugPrint('全件削除完了');
            debugPrint('現在の登録数:0件');
          });
        } else {
          //登録内容全件をコンソールに表示
          debugPrint('総登録内容:$data');
          debugPrint('現在の登録数:${data.length}件');
        }
      });
      ///変更通知
      notifyListeners();
    }
  }

  ///Widgetの追加API
  void setChatWidget(int id, Widget widget) {
    chatWidgetMap[id] = widget;
  }

}