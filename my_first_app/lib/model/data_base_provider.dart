import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DataBaseProvider {

  Database _instance;

  String get databaseName;
  String get tableName;

  Future<Database> get database async {
    ///シングルトン
    if (_instance == null) {
      _instance = await openDatabase(

        ///path
        join(
          await getDatabasesPath(),
          databaseName,
        ),

        ///pathが存在しない時、イニシャライズ的なイメージでデータベース新規作成
        onCreate: createDatabase,

        version: 1,

      );
    }
    return _instance;
  }

  void createDatabase(Database db, int version);

}