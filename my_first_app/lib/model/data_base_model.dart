import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';

import 'package:my_first_app/my_enum/data_base_state.dart';
import 'package:sqflite/sqflite.dart';

import 'history_database.dart';

class DataBaseModel {

  ///DataBase用
  int id;
  List<int> nowDate;
  String tension;
  String text;

  ///DataBaseの登録ID
  static int _dataBaseId = 0;

  ///通信状態のStreamController(BehaviorSubject)
  final StreamController<DataBaseState> _databaseStream = BehaviorSubject<DataBaseState>();

  ///通信状態のStreamのGETメソッド
  Stream<DataBaseState> get state => _databaseStream.stream;

  ///登録IDの取得(テキストが入力されているチャットの登録ボタン押下APIからしかインクリメントさせない)==バグを防ぐためのフラグ
  int getId(bool isBeText) {
    if (isBeText) {
      return ++_dataBaseId;
    } else {
      return _dataBaseId;
    }
  }

  ///通信状態のStreamのSETメソッド
  void streamSetState(DataBaseState state) {
    _databaseStream.add(state);
  }

  ///日記内容Map化
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': nowDate,
      'tension': tension,
      'text': text,
    };
  }

  ///登録日時情報取得
  List<int> getNowDate() {
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
    return nowDate = [year, month, day, hour, minute, second];
  }

  ///日記内容登録
  Future<int> addHistory() async {
    streamSetState(DataBaseState.CONNECTING);
    final HistoryDataBase history = HistoryDataBase();
    final Database database = await history.database;
    getNowDate();
    return await database.insert(history.tableName, toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ///日記内容取得
  Future<List> getHistory() async {
    final HistoryDataBase history = HistoryDataBase();
    final Database database = await history.database;
    final List<Map<String, dynamic>> maps = await database.query(history.tableName);
    return maps;
  }

  ///データベース更新(未完成)、というか使いどころがまだ分かっていない
  Future<void> updateDataBase() async {
    final HistoryDataBase history = HistoryDataBase();
    final Database database = await history.database;
//    await database.update(history.tableName, )
  }

  ///データベース登録内容削除
  Future<void> deleteData(int id) async {
    final HistoryDataBase history = HistoryDataBase();
    final Database database = await history.database;
    await database.delete(
      history.tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  ///登録後Variable初期化
  void resetValue() {
    id = null;
    nowDate = null;
    tension = null;
    text = null;
  }

  void dispose() {
    _databaseStream.close();
  }

}