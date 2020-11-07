import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier{

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
  //Todo: 本来はSharedPrefもしくはFireBaseから日記リストの登録数を取ってきて起動時の初期値に設定する
  int listIndex = 0;
  //リストのKey
  ValueKey key;

  //ValueKey生成用API
  ValueKey _createValueKey(int listIndex) {
    key = ValueKey(listIndex);
    return key;
  }

  //登録ボタン押下時API
  void onTapRegisterButton(String value) {
    //空文字だけの時は、登録しないかつタイムラインにも表示しない
    if (value != '') {
      //リスト(Container)の数増やす
      listIndex++;
      _createValueKey(listIndex);
      //増やしたリスト(Container)に文字セット
      registerStrings = value;
      //自分で登録したからTrue
      isMyRegisterString = true;
      notifyListeners();
    }
  }

}