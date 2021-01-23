import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:my_first_app/view_model/change_notifier_model.dart';

class ChatViewModel extends ChangeNotifierModel {

  ///Constructor
  ChatViewModel._();

  static ChatViewModel _instance() => ChatViewModel._();

  //factory constructor
  factory ChatViewModel() => _instance();

  ///Variable
  //登録内容
  String registerStrings;
  //自分が送信したかどうか
  bool isMyRegisterString;
  //リストの数
  //Todo: 本来はSharedPrefから日記リストの登録数を取ってきて起動時の初期値に設定する
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
    //空文字だけの時は、登録しないかつタイムラインにも表示しない
//    if (value != '' && id != null && tension != null) {
//      text = value;
//      id = getId(true);
//      //リスト(Container)の数増やす
//      listIndex++;
//      _createValueKey(listIndex);
//      //増やしたリスト(Container)に文字セット
//      registerStrings = value;
//      //自分で登録したからTrue
//      isMyRegisterString = true;
//      //データベース登録
//      addHistory().then((value) {
//        ///登録完了後処理
//          streamSetState(DataBaseState.STOP);
//          setState(DataBaseState.STOP);
//          debugPrint('register data [id: $id nowDate: $nowDate tension: $tension text: $text');
//          ///DataBaseModelの登録情報変数を初期化
//          resetValue();
//      });
//      //変更通知
//      notifyListeners();
//    }

      //増やしたリスト(Container)に文字セット
      registerStrings = controller.value.text;
      if (registerStrings.isNotEmpty) {
        //自分で登録したからTrue
        isMyRegisterString = true;
        //リスト(Container)の数を増やす
        listIndex++;
        //テキストフィールドの文字をクリア
        controller.clear();
        //データベースID登録
//      setId(listIndex);
        //テンション登録
//      setTension('TBD');
        //データベース登録
        addHistory('TBD', controller.value.text);
//      debugPrint('登録内容${getHistory()}');
      }
      //変更通知
      notifyListeners();
  }

  ///Widgetの追加API
  void setChatWidget(int id, Widget widget) {
    chatWidgetMap[id] = widget;
  }

}