// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MoorDataBase extends DataClass implements Insertable<MoorDataBase> {
  final int id;
  final String diaryTexts;
  final String tension;
  final int category;
  MoorDataBase(
      {@required this.id,
      @required this.diaryTexts,
      @required this.tension,
      this.category});
  factory MoorDataBase.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return MoorDataBase(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      diaryTexts: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}diary_texts']),
      tension:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}tension']),
      category:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}category']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || diaryTexts != null) {
      map['diary_texts'] = Variable<String>(diaryTexts);
    }
    if (!nullToAbsent || tension != null) {
      map['tension'] = Variable<String>(tension);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int>(category);
    }
    return map;
  }

  MoorDataBasesCompanion toCompanion(bool nullToAbsent) {
    return MoorDataBasesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      diaryTexts: diaryTexts == null && nullToAbsent
          ? const Value.absent()
          : Value(diaryTexts),
      tension: tension == null && nullToAbsent
          ? const Value.absent()
          : Value(tension),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory MoorDataBase.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorDataBase(
      id: serializer.fromJson<int>(json['id']),
      diaryTexts: serializer.fromJson<String>(json['diaryTexts']),
      tension: serializer.fromJson<String>(json['tension']),
      category: serializer.fromJson<int>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'diaryTexts': serializer.toJson<String>(diaryTexts),
      'tension': serializer.toJson<String>(tension),
      'category': serializer.toJson<int>(category),
    };
  }

  MoorDataBase copyWith(
          {int id, String diaryTexts, String tension, int category}) =>
      MoorDataBase(
        id: id ?? this.id,
        diaryTexts: diaryTexts ?? this.diaryTexts,
        tension: tension ?? this.tension,
        category: category ?? this.category,
      );
  @override
  String toString() {
    return (StringBuffer('MoorDataBase(')
          ..write('id: $id, ')
          ..write('diaryTexts: $diaryTexts, ')
          ..write('tension: $tension, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(diaryTexts.hashCode, $mrjc(tension.hashCode, category.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MoorDataBase &&
          other.id == this.id &&
          other.diaryTexts == this.diaryTexts &&
          other.tension == this.tension &&
          other.category == this.category);
}

class MoorDataBasesCompanion extends UpdateCompanion<MoorDataBase> {
  final Value<int> id;
  final Value<String> diaryTexts;
  final Value<String> tension;
  final Value<int> category;
  const MoorDataBasesCompanion({
    this.id = const Value.absent(),
    this.diaryTexts = const Value.absent(),
    this.tension = const Value.absent(),
    this.category = const Value.absent(),
  });
  MoorDataBasesCompanion.insert({
    this.id = const Value.absent(),
    @required String diaryTexts,
    @required String tension,
    this.category = const Value.absent(),
  })  : diaryTexts = Value(diaryTexts),
        tension = Value(tension);
  static Insertable<MoorDataBase> custom({
    Expression<int> id,
    Expression<String> diaryTexts,
    Expression<String> tension,
    Expression<int> category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (diaryTexts != null) 'diary_texts': diaryTexts,
      if (tension != null) 'tension': tension,
      if (category != null) 'category': category,
    });
  }

  MoorDataBasesCompanion copyWith(
      {Value<int> id,
      Value<String> diaryTexts,
      Value<String> tension,
      Value<int> category}) {
    return MoorDataBasesCompanion(
      id: id ?? this.id,
      diaryTexts: diaryTexts ?? this.diaryTexts,
      tension: tension ?? this.tension,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (diaryTexts.present) {
      map['diary_texts'] = Variable<String>(diaryTexts.value);
    }
    if (tension.present) {
      map['tension'] = Variable<String>(tension.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoorDataBasesCompanion(')
          ..write('id: $id, ')
          ..write('diaryTexts: $diaryTexts, ')
          ..write('tension: $tension, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $MoorDataBasesTable extends MoorDataBases
    with TableInfo<$MoorDataBasesTable, MoorDataBase> {
  final GeneratedDatabase _db;
  final String _alias;
  $MoorDataBasesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _diaryTextsMeta = const VerificationMeta('diaryTexts');
  GeneratedTextColumn _diaryTexts;
  @override
  GeneratedTextColumn get diaryTexts => _diaryTexts ??= _constructDiaryTexts();
  GeneratedTextColumn _constructDiaryTexts() {
    return GeneratedTextColumn('diary_texts', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _tensionMeta = const VerificationMeta('tension');
  GeneratedTextColumn _tension;
  @override
  GeneratedTextColumn get tension => _tension ??= _constructTension();
  GeneratedTextColumn _constructTension() {
    return GeneratedTextColumn('tension', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedIntColumn _category;
  @override
  GeneratedIntColumn get category => _category ??= _constructCategory();
  GeneratedIntColumn _constructCategory() {
    return GeneratedIntColumn(
      'category',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, diaryTexts, tension, category];
  @override
  $MoorDataBasesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'moor_data_bases';
  @override
  final String actualTableName = 'moor_data_bases';
  @override
  VerificationContext validateIntegrity(Insertable<MoorDataBase> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('diary_texts')) {
      context.handle(
          _diaryTextsMeta,
          diaryTexts.isAcceptableOrUnknown(
              data['diary_texts'], _diaryTextsMeta));
    } else if (isInserting) {
      context.missing(_diaryTextsMeta);
    }
    if (data.containsKey('tension')) {
      context.handle(_tensionMeta,
          tension.isAcceptableOrUnknown(data['tension'], _tensionMeta));
    } else if (isInserting) {
      context.missing(_tensionMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoorDataBase map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorDataBase.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MoorDataBasesTable createAlias(String alias) {
    return $MoorDataBasesTable(_db, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String description;
  Category({@required this.id, @required this.description});
  factory Category.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Category(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String>(description),
    };
  }

  Category copyWith({int id, String description}) => Category(
        id: id ?? this.id,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, description.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.description == this.description);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> description;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    @required String description,
  }) : description = Value(description);
  static Insertable<Category> custom({
    Expression<int> id,
    Expression<String> description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
    });
  }

  CategoriesCompanion copyWith({Value<int> id, Value<String> description}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, description];
  @override
  $CategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'categories';
  @override
  final String actualTableName = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Category.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(_db, alias);
  }
}

abstract class _$MyDataBase extends GeneratedDatabase {
  _$MyDataBase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $MoorDataBasesTable _moorDataBases;
  $MoorDataBasesTable get moorDataBases =>
      _moorDataBases ??= $MoorDataBasesTable(this);
  $CategoriesTable _categories;
  $CategoriesTable get categories => _categories ??= $CategoriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [moorDataBases, categories];
}
