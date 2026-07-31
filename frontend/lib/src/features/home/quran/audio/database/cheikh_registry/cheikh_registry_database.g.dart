// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cheikh_registry_database.dart';

// ignore_for_file: type=lint
class $CheikhListTableTable extends CheikhListTable
    with TableInfo<$CheikhListTableTable, CheikhListTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheikhListTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameArabicMeta = const VerificationMeta(
    'nameArabic',
  );
  @override
  late final GeneratedColumn<String> nameArabic = GeneratedColumn<String>(
    'name_arabic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameSimpleMeta = const VerificationMeta(
    'nameSimple',
  );
  @override
  late final GeneratedColumn<String> nameSimple = GeneratedColumn<String>(
    'name_simple',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dbAssetPathMeta = const VerificationMeta(
    'dbAssetPath',
  );
  @override
  late final GeneratedColumn<String> dbAssetPath = GeneratedColumn<String>(
    'db_asset_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameArabic,
    nameSimple,
    dbAssetPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cheikh_list';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheikhListTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_arabic')) {
      context.handle(
        _nameArabicMeta,
        nameArabic.isAcceptableOrUnknown(data['name_arabic']!, _nameArabicMeta),
      );
    } else if (isInserting) {
      context.missing(_nameArabicMeta);
    }
    if (data.containsKey('name_simple')) {
      context.handle(
        _nameSimpleMeta,
        nameSimple.isAcceptableOrUnknown(data['name_simple']!, _nameSimpleMeta),
      );
    } else if (isInserting) {
      context.missing(_nameSimpleMeta);
    }
    if (data.containsKey('db_asset_path')) {
      context.handle(
        _dbAssetPathMeta,
        dbAssetPath.isAcceptableOrUnknown(
          data['db_asset_path']!,
          _dbAssetPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dbAssetPathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CheikhListTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheikhListTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_arabic'],
      )!,
      nameSimple: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_simple'],
      )!,
      dbAssetPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}db_asset_path'],
      )!,
    );
  }

  @override
  $CheikhListTableTable createAlias(String alias) {
    return $CheikhListTableTable(attachedDatabase, alias);
  }
}

class CheikhListTableData extends DataClass
    implements Insertable<CheikhListTableData> {
  final String id;
  final String nameArabic;
  final String nameSimple;
  final String dbAssetPath;
  const CheikhListTableData({
    required this.id,
    required this.nameArabic,
    required this.nameSimple,
    required this.dbAssetPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_arabic'] = Variable<String>(nameArabic);
    map['name_simple'] = Variable<String>(nameSimple);
    map['db_asset_path'] = Variable<String>(dbAssetPath);
    return map;
  }

  CheikhListTableCompanion toCompanion(bool nullToAbsent) {
    return CheikhListTableCompanion(
      id: Value(id),
      nameArabic: Value(nameArabic),
      nameSimple: Value(nameSimple),
      dbAssetPath: Value(dbAssetPath),
    );
  }

  factory CheikhListTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheikhListTableData(
      id: serializer.fromJson<String>(json['id']),
      nameArabic: serializer.fromJson<String>(json['nameArabic']),
      nameSimple: serializer.fromJson<String>(json['nameSimple']),
      dbAssetPath: serializer.fromJson<String>(json['dbAssetPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameArabic': serializer.toJson<String>(nameArabic),
      'nameSimple': serializer.toJson<String>(nameSimple),
      'dbAssetPath': serializer.toJson<String>(dbAssetPath),
    };
  }

  CheikhListTableData copyWith({
    String? id,
    String? nameArabic,
    String? nameSimple,
    String? dbAssetPath,
  }) => CheikhListTableData(
    id: id ?? this.id,
    nameArabic: nameArabic ?? this.nameArabic,
    nameSimple: nameSimple ?? this.nameSimple,
    dbAssetPath: dbAssetPath ?? this.dbAssetPath,
  );
  CheikhListTableData copyWithCompanion(CheikhListTableCompanion data) {
    return CheikhListTableData(
      id: data.id.present ? data.id.value : this.id,
      nameArabic: data.nameArabic.present
          ? data.nameArabic.value
          : this.nameArabic,
      nameSimple: data.nameSimple.present
          ? data.nameSimple.value
          : this.nameSimple,
      dbAssetPath: data.dbAssetPath.present
          ? data.dbAssetPath.value
          : this.dbAssetPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CheikhListTableData(')
          ..write('id: $id, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameSimple: $nameSimple, ')
          ..write('dbAssetPath: $dbAssetPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameArabic, nameSimple, dbAssetPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheikhListTableData &&
          other.id == this.id &&
          other.nameArabic == this.nameArabic &&
          other.nameSimple == this.nameSimple &&
          other.dbAssetPath == this.dbAssetPath);
}

class CheikhListTableCompanion extends UpdateCompanion<CheikhListTableData> {
  final Value<String> id;
  final Value<String> nameArabic;
  final Value<String> nameSimple;
  final Value<String> dbAssetPath;
  final Value<int> rowid;
  const CheikhListTableCompanion({
    this.id = const Value.absent(),
    this.nameArabic = const Value.absent(),
    this.nameSimple = const Value.absent(),
    this.dbAssetPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CheikhListTableCompanion.insert({
    required String id,
    required String nameArabic,
    required String nameSimple,
    required String dbAssetPath,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameArabic = Value(nameArabic),
       nameSimple = Value(nameSimple),
       dbAssetPath = Value(dbAssetPath);
  static Insertable<CheikhListTableData> custom({
    Expression<String>? id,
    Expression<String>? nameArabic,
    Expression<String>? nameSimple,
    Expression<String>? dbAssetPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameArabic != null) 'name_arabic': nameArabic,
      if (nameSimple != null) 'name_simple': nameSimple,
      if (dbAssetPath != null) 'db_asset_path': dbAssetPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CheikhListTableCompanion copyWith({
    Value<String>? id,
    Value<String>? nameArabic,
    Value<String>? nameSimple,
    Value<String>? dbAssetPath,
    Value<int>? rowid,
  }) {
    return CheikhListTableCompanion(
      id: id ?? this.id,
      nameArabic: nameArabic ?? this.nameArabic,
      nameSimple: nameSimple ?? this.nameSimple,
      dbAssetPath: dbAssetPath ?? this.dbAssetPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameArabic.present) {
      map['name_arabic'] = Variable<String>(nameArabic.value);
    }
    if (nameSimple.present) {
      map['name_simple'] = Variable<String>(nameSimple.value);
    }
    if (dbAssetPath.present) {
      map['db_asset_path'] = Variable<String>(dbAssetPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheikhListTableCompanion(')
          ..write('id: $id, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameSimple: $nameSimple, ')
          ..write('dbAssetPath: $dbAssetPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CheikhRegistryDatabase extends GeneratedDatabase {
  _$CheikhRegistryDatabase(QueryExecutor e) : super(e);
  $CheikhRegistryDatabaseManager get managers =>
      $CheikhRegistryDatabaseManager(this);
  late final $CheikhListTableTable cheikhListTable = $CheikhListTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cheikhListTable];
}

typedef $$CheikhListTableTableCreateCompanionBuilder =
    CheikhListTableCompanion Function({
      required String id,
      required String nameArabic,
      required String nameSimple,
      required String dbAssetPath,
      Value<int> rowid,
    });
typedef $$CheikhListTableTableUpdateCompanionBuilder =
    CheikhListTableCompanion Function({
      Value<String> id,
      Value<String> nameArabic,
      Value<String> nameSimple,
      Value<String> dbAssetPath,
      Value<int> rowid,
    });

class $$CheikhListTableTableFilterComposer
    extends Composer<_$CheikhRegistryDatabase, $CheikhListTableTable> {
  $$CheikhListTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameSimple => $composableBuilder(
    column: $table.nameSimple,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dbAssetPath => $composableBuilder(
    column: $table.dbAssetPath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CheikhListTableTableOrderingComposer
    extends Composer<_$CheikhRegistryDatabase, $CheikhListTableTable> {
  $$CheikhListTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameSimple => $composableBuilder(
    column: $table.nameSimple,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dbAssetPath => $composableBuilder(
    column: $table.dbAssetPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CheikhListTableTableAnnotationComposer
    extends Composer<_$CheikhRegistryDatabase, $CheikhListTableTable> {
  $$CheikhListTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameSimple => $composableBuilder(
    column: $table.nameSimple,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dbAssetPath => $composableBuilder(
    column: $table.dbAssetPath,
    builder: (column) => column,
  );
}

class $$CheikhListTableTableTableManager
    extends
        RootTableManager<
          _$CheikhRegistryDatabase,
          $CheikhListTableTable,
          CheikhListTableData,
          $$CheikhListTableTableFilterComposer,
          $$CheikhListTableTableOrderingComposer,
          $$CheikhListTableTableAnnotationComposer,
          $$CheikhListTableTableCreateCompanionBuilder,
          $$CheikhListTableTableUpdateCompanionBuilder,
          (
            CheikhListTableData,
            BaseReferences<
              _$CheikhRegistryDatabase,
              $CheikhListTableTable,
              CheikhListTableData
            >,
          ),
          CheikhListTableData,
          PrefetchHooks Function()
        > {
  $$CheikhListTableTableTableManager(
    _$CheikhRegistryDatabase db,
    $CheikhListTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheikhListTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheikhListTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheikhListTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameArabic = const Value.absent(),
                Value<String> nameSimple = const Value.absent(),
                Value<String> dbAssetPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheikhListTableCompanion(
                id: id,
                nameArabic: nameArabic,
                nameSimple: nameSimple,
                dbAssetPath: dbAssetPath,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameArabic,
                required String nameSimple,
                required String dbAssetPath,
                Value<int> rowid = const Value.absent(),
              }) => CheikhListTableCompanion.insert(
                id: id,
                nameArabic: nameArabic,
                nameSimple: nameSimple,
                dbAssetPath: dbAssetPath,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CheikhListTableTableProcessedTableManager =
    ProcessedTableManager<
      _$CheikhRegistryDatabase,
      $CheikhListTableTable,
      CheikhListTableData,
      $$CheikhListTableTableFilterComposer,
      $$CheikhListTableTableOrderingComposer,
      $$CheikhListTableTableAnnotationComposer,
      $$CheikhListTableTableCreateCompanionBuilder,
      $$CheikhListTableTableUpdateCompanionBuilder,
      (
        CheikhListTableData,
        BaseReferences<
          _$CheikhRegistryDatabase,
          $CheikhListTableTable,
          CheikhListTableData
        >,
      ),
      CheikhListTableData,
      PrefetchHooks Function()
    >;

class $CheikhRegistryDatabaseManager {
  final _$CheikhRegistryDatabase _db;
  $CheikhRegistryDatabaseManager(this._db);
  $$CheikhListTableTableTableManager get cheikhListTable =>
      $$CheikhListTableTableTableManager(_db, _db.cheikhListTable);
}
