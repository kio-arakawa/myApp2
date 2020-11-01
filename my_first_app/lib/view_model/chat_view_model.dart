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

  //SwitchListViewのサイズ
  //Todo: 本来はSharedPrefもしくはFireBaseから日記リストの登録数を取ってきて起動時の初期値に設定する
  int listIndex = 0;

  //登録ボタン押下時API
  void onTapRegisterButton(String value) {
    if (value != '') {
      registerStrings = value;
      listIndex++;
      notifyListeners();
    }
  }
}