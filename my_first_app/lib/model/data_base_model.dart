import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:my_first_app/my_enum/data_base_state.dart';

class DataBaseModel {

  final String _tableName = 'history';
  final String _databaseName = 'MyDatabase.db';
  String get getDatabaseName => _databaseName;
  String get getTableName => _tableName;

  ///DataBase用
  final String _id = 'dbId';
  final String _date = 'dbDate';
  final String _tension = 'dbTension';
  final String _text = 'dbText';
  Map<String, dynamic> _historyMap;

  Database _instance;

  Future<Database> get database async {
    _instance ??= await openDatabase(
      ///path
      join(
        await getDatabasesPath(),
        getDatabaseName,
      ),
      ///pathが存在しない時、イニシャライズ的なイメージでデータベース新規作成
      onCreate: _createDatabase,
      ///データベースのバージョン
      version: 1,
    );
    return _instance;
  }

  ///データベース作成
  ///date→登録日時,tension→登録した日記のテンション,text→日記内容
  void _createDatabase(Database db, int version) async {
    await db.execute(
        """
          CREATE TABLE $_tableName(
            $_id INTEGER PRIMARY KEY AUTOINCREMENT,
            $_date BLOB,
            $_tension TEXT NOT NULL,
            $_text TEXT NOT NULL,
          )
        """
    );
  }

  ///DataBaseの登録ID
  static int _dataBaseId = 0;

  ///通信状態のStreamController(BehaviorSubject)
  final StreamController<DataBaseState> _databaseStream = BehaviorSubject<DataBaseState>();

  ///通信状態のStreamのGETメソッド
  Stream<DataBaseState> get state => _databaseStream.stream;

  int getId() {
    return _dataBaseId;
  }

  ///通信状態のStreamのSETメソッド
  void _streamSetState(DataBaseState state) {
    _databaseStream.add(state);
  }

  ///日記内容Map化
  Map<String, dynamic> _setHistoryData(List<int> time, String tension, String text) {
    return {
      'time': time,
      'tension': tension,
      'text': text,
    };
  }

  ///登録日時情報取得
  List<int> _getNowDate() {
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
    return [year, month, day, hour, minute, second];
  }

  ///日記内容登録
  Future<int> addHistory(String tension, String text) async {
    _streamSetState(DataBaseState.CONNECTING);
    _setHistoryData(_getNowDate(), tension, text);
    final DataBaseModel dataBaseModel = DataBaseModel();
    final Database database = await dataBaseModel.database;
    return await database.insert(dataBaseModel._tableName, _historyMap, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ///日記内容取得
//  Future<List> getHistory() async {
//    final DataBaseModel dataBaseModel = DataBaseModel();
//    final Database database = await dataBaseModel.database;
//    final List<Map<String, dynamic>> maps = await database.query(dataBaseModel._tableName);
//    return maps;
//  }

  ///データベース更新(未完成)、というか使いどころがまだ分かっていない
  Future<void> updateDataBase() async {
    final DataBaseModel dataBaseModel = DataBaseModel();
    final Database database = await dataBaseModel.database;
//    await database.update(history.tableName, )
  }

  ///データベース登録内容削除
  Future<void> deleteData(int id) async {
    final DataBaseModel dataBaseModel = DataBaseModel();
    final Database database = await dataBaseModel.database;
    await database.delete(
      dataBaseModel._tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  ///登録後Variable初期化
//  void resetValue() {
//    id = null;
//    nowDate = null;
//    tension = null;
//    text = null;
//  }

  void dispose() {
    _databaseStream.close();
  }

}