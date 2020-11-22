import 'package:my_first_app/model/data_base_provider.dart';
import 'package:sqflite/sqflite.dart';


class HistoryDataBase extends DataBaseProvider {

  static HistoryDataBase _historyDataBase;

  HistoryDataBase._();

  factory HistoryDataBase() {
    if (_historyDataBase == null) {
      _historyDataBase = HistoryDataBase._();
    }
    return _historyDataBase;
  }

  @override
  String get databaseName => 'history_database.db';

  @override
  String get tableName => 'history';

  ///データベース作成
  ///time→登録日時,tension→登録した日記のテンション,text→日記内容
  @override
  createDatabase(Database db, int version) => db.execute(
    """
      CREATE TABLE history(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        time BLOB,
        tension TEXT,
        text TEXT,
      )
    """
  );

}