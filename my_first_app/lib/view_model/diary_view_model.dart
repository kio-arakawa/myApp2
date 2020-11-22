import 'package:flutter/material.dart';
import 'package:my_first_app/model/history_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

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
  //Todo: 本来はSharedPrefから日記リストの登録数を取ってきて起動時の初期値に設定する
  int listIndex = 0;
  //リストのKey
  ValueKey key;

  ///ValueKey生成用API
  ValueKey _createValueKey(int listIndex) {
    key = ValueKey(listIndex);
    return key;
  }

  ///DataBase用
  int _id;
  List<int> _nowDate;
  String _tension;
  String _text;

  ///登録ボタン押下時API
  void onTapRegisterButton(String value) {
    //空文字だけの時は、登録しないかつタイムラインにも表示しない
    if (value != '' && _id != null && _tension != null) {
      _text = value;
      //リスト(Container)の数増やす
      listIndex++;
      _createValueKey(listIndex);
      //増やしたリスト(Container)に文字セット
      registerStrings = value;
      //自分で登録したからTrue
      isMyRegisterString = true;
      //データベース登録
      _addHistory();
      //変更通知
      notifyListeners();
    }
  }

  ///登録日時情報取得
  void _getNowDate() {
    DateTime now = DateTime.now();
    var yearFormatter = DateFormat('yyyy');
    var monthFormatter = DateFormat('MM');
    var dayFormatter = DateFormat('dd');
    var hourFormatter = DateFormat('H');
    var minuteFormatter = DateFormat('Hm');
    var secondFormatter = DateFormat('Hms');
    int year = int.parse(yearFormatter.format(now));
    int month = int.parse(monthFormatter.format(now));
    int day = int.parse(dayFormatter.format(now));
    int hour = int.parse(hourFormatter.format(now));
    int minute = int.parse(minuteFormatter.format(now));
    int second = int.parse(secondFormatter.format(now));
    _nowDate = [year, month, day, hour, minute, second];
  }

  ///日記内容Map化
  Map<String, dynamic> _toMap() {
    return {
      'id': _id,
      'time': _nowDate,
      'tension': _tension,
      'text': _text,
    };
  }

  ///日記内容登録
  Future<int> _addHistory() async {
    final HistoryDataBase history = HistoryDataBase();
    final Database database = await history.database;
    _getNowDate();
    return await database.insert(history.tableName, _toMap());
  }

}