import 'package:my_first_app/model/data_base_provider.dart';
import 'package:sqflite/sqflite.dart';


class HistoryDataBase extends DataBaseProvider {

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
        time INTEGER,
        tension TEXT,
        text TEXT,
      )
    """
  );

}