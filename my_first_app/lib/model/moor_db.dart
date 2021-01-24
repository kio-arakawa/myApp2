import 'dart:io';

import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';

/// moor_db.g.dartは、このmoor_db.dartの一部ですよ、という宣言
/// moor_db.g.dartの方では、「part of 'moor_db.dart'」と記述する必要がある
part 'moor_db.g.dart';

/// 末尾の「s」はmoor_db.g.dartでは自動削除される
/// → データベース名が「moorDataBase」となる
class MoorDataBases extends Table {
  // id (autoIncrement)
  IntColumn get id => integer().autoIncrement()();
  // 登録内容 (1文字以上）
  TextColumn get diaryTexts => text().withLength(min: 1)();
  // テンション (1文字以上)
  TextColumn get tension => text().withLength(min: 1)();
  // カラムに別名を付ける
//  TextColumn get content => text().named('Diary')();
  // nullableな数字
  IntColumn get category => integer().nullable()();
}

/// 末尾の「s」はmoor_db.g.dartでは自動削除される
/// → データベース名が「category」となる
@DataClassName("Category")
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase( () async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [MoorDataBases, Categories])
class MyDatabase extends _$MyDataBase {

  /// シングルトン
  MyDatabase._() : super(_openConnection());
  static MyDatabase _instance;
  factory MyDatabase() {
    _instance ??= MyDatabase._();
    return _instance;
  }

  /// ??
  @override
  int get schemaVersion => 1;

  /// @param allDiaryEntries 全ての登録内容を取得する
  Future<List<MoorDataBase>> get allDiaryEntries => select(moorDataBases).get();

  /// @param watchEntriesInCategory
  /// Categoryに紐づく全ての登録内容を取得する
  /// DBの変更を監視し、変更があると更新結果を自動返却
  //  ↓
  // 「moorDataBase」DBから、
  // 「category」DBのIDと紐づいているidの登録内容をwatch(監視)
  Stream<List<MoorDataBase>> watchEntriesInCategory(Category c) {
    return (select(moorDataBases)..where((t) => t.category.equals(c.id))).watch();
  }

  /// @param todoById
  /// 対応するIDの登録内容を取得する
  /// DBの変更を監視し、変更があると更新結果を自動返却
  Stream<MoorDataBase> todoById(int id) {
    return (select(moorDataBases)..where((t) => t.id.equals(id))).watchSingle();
  }

  /// @param addDiaryEntry 日記内容をDBに登録する＋登録時のIDを返却する
  /// @param MoorDataBasesCompanion 
  Future<int> addDiary(MoorDataBasesCompanion diary) {
    return into(moorDataBases).insert(diary);
  }

  /// @param updateDiary 対象IDの登録内容をアップデート＋更新された行数を返却
  Future<int> updateDiary(int id, MoorDataBasesCompanion diary) {
    return (update(moorDataBases)..where((it) => it.id.equals(id))).write(diary);
  }

  /// @param deleteDiary 対象IDの登録内容を削除＋削除した行数を返却
  Future<int> deleteDiary(int id) {
    return (delete(moorDataBases)..where((it) => it.id.equals(id))).go();
  }

  /// @param deleteAllDairy 全てのデータを削除＋削除した行数を返却
  Future deleteAllDiary() {
    return (delete(moorDataBases)).go();
  }

}