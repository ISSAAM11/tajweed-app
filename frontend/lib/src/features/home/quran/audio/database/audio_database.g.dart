// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_database.dart';

// ignore_for_file: type=lint
class $SegmentsTableTable extends SegmentsTable
    with TableInfo<$SegmentsTableTable, SegmentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SegmentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecMeta = const VerificationMeta(
    'durationSec',
  );
  @override
  late final GeneratedColumn<int> durationSec = GeneratedColumn<int>(
    'duration_sec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampFromMeta = const VerificationMeta(
    'timestampFrom',
  );
  @override
  late final GeneratedColumn<int> timestampFrom = GeneratedColumn<int>(
    'timestamp_from',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampToMeta = const VerificationMeta(
    'timestampTo',
  );
  @override
  late final GeneratedColumn<int> timestampTo = GeneratedColumn<int>(
    'timestamp_to',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _segmentsMeta = const VerificationMeta(
    'segments',
  );
  @override
  late final GeneratedColumn<String> segments = GeneratedColumn<String>(
    'segments',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    surahNumber,
    ayahNumber,
    durationSec,
    timestampFrom,
    timestampTo,
    segments,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'segments';
  @override
  VerificationContext validateIntegrity(
    Insertable<SegmentsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('duration_sec')) {
      context.handle(
        _durationSecMeta,
        durationSec.isAcceptableOrUnknown(
          data['duration_sec']!,
          _durationSecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecMeta);
    }
    if (data.containsKey('timestamp_from')) {
      context.handle(
        _timestampFromMeta,
        timestampFrom.isAcceptableOrUnknown(
          data['timestamp_from']!,
          _timestampFromMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampFromMeta);
    }
    if (data.containsKey('timestamp_to')) {
      context.handle(
        _timestampToMeta,
        timestampTo.isAcceptableOrUnknown(
          data['timestamp_to']!,
          _timestampToMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampToMeta);
    }
    if (data.containsKey('segments')) {
      context.handle(
        _segmentsMeta,
        segments.isAcceptableOrUnknown(data['segments']!, _segmentsMeta),
      );
    } else if (isInserting) {
      context.missing(_segmentsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surahNumber, ayahNumber};
  @override
  SegmentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SegmentsTableData(
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      durationSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_sec'],
      )!,
      timestampFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_from'],
      )!,
      timestampTo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_to'],
      )!,
      segments: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}segments'],
      )!,
    );
  }

  @override
  $SegmentsTableTable createAlias(String alias) {
    return $SegmentsTableTable(attachedDatabase, alias);
  }
}

class SegmentsTableData extends DataClass
    implements Insertable<SegmentsTableData> {
  final int surahNumber;
  final int ayahNumber;
  final int durationSec;
  final int timestampFrom;
  final int timestampTo;
  final String segments;
  const SegmentsTableData({
    required this.surahNumber,
    required this.ayahNumber,
    required this.durationSec,
    required this.timestampFrom,
    required this.timestampTo,
    required this.segments,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['duration_sec'] = Variable<int>(durationSec);
    map['timestamp_from'] = Variable<int>(timestampFrom);
    map['timestamp_to'] = Variable<int>(timestampTo);
    map['segments'] = Variable<String>(segments);
    return map;
  }

  SegmentsTableCompanion toCompanion(bool nullToAbsent) {
    return SegmentsTableCompanion(
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      durationSec: Value(durationSec),
      timestampFrom: Value(timestampFrom),
      timestampTo: Value(timestampTo),
      segments: Value(segments),
    );
  }

  factory SegmentsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SegmentsTableData(
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      durationSec: serializer.fromJson<int>(json['durationSec']),
      timestampFrom: serializer.fromJson<int>(json['timestampFrom']),
      timestampTo: serializer.fromJson<int>(json['timestampTo']),
      segments: serializer.fromJson<String>(json['segments']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'durationSec': serializer.toJson<int>(durationSec),
      'timestampFrom': serializer.toJson<int>(timestampFrom),
      'timestampTo': serializer.toJson<int>(timestampTo),
      'segments': serializer.toJson<String>(segments),
    };
  }

  SegmentsTableData copyWith({
    int? surahNumber,
    int? ayahNumber,
    int? durationSec,
    int? timestampFrom,
    int? timestampTo,
    String? segments,
  }) => SegmentsTableData(
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    durationSec: durationSec ?? this.durationSec,
    timestampFrom: timestampFrom ?? this.timestampFrom,
    timestampTo: timestampTo ?? this.timestampTo,
    segments: segments ?? this.segments,
  );
  SegmentsTableData copyWithCompanion(SegmentsTableCompanion data) {
    return SegmentsTableData(
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      durationSec: data.durationSec.present
          ? data.durationSec.value
          : this.durationSec,
      timestampFrom: data.timestampFrom.present
          ? data.timestampFrom.value
          : this.timestampFrom,
      timestampTo: data.timestampTo.present
          ? data.timestampTo.value
          : this.timestampTo,
      segments: data.segments.present ? data.segments.value : this.segments,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SegmentsTableData(')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('durationSec: $durationSec, ')
          ..write('timestampFrom: $timestampFrom, ')
          ..write('timestampTo: $timestampTo, ')
          ..write('segments: $segments')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    surahNumber,
    ayahNumber,
    durationSec,
    timestampFrom,
    timestampTo,
    segments,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SegmentsTableData &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.durationSec == this.durationSec &&
          other.timestampFrom == this.timestampFrom &&
          other.timestampTo == this.timestampTo &&
          other.segments == this.segments);
}

class SegmentsTableCompanion extends UpdateCompanion<SegmentsTableData> {
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<int> durationSec;
  final Value<int> timestampFrom;
  final Value<int> timestampTo;
  final Value<String> segments;
  final Value<int> rowid;
  const SegmentsTableCompanion({
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.durationSec = const Value.absent(),
    this.timestampFrom = const Value.absent(),
    this.timestampTo = const Value.absent(),
    this.segments = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SegmentsTableCompanion.insert({
    required int surahNumber,
    required int ayahNumber,
    required int durationSec,
    required int timestampFrom,
    required int timestampTo,
    required String segments,
    this.rowid = const Value.absent(),
  }) : surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber),
       durationSec = Value(durationSec),
       timestampFrom = Value(timestampFrom),
       timestampTo = Value(timestampTo),
       segments = Value(segments);
  static Insertable<SegmentsTableData> custom({
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<int>? durationSec,
    Expression<int>? timestampFrom,
    Expression<int>? timestampTo,
    Expression<String>? segments,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (durationSec != null) 'duration_sec': durationSec,
      if (timestampFrom != null) 'timestamp_from': timestampFrom,
      if (timestampTo != null) 'timestamp_to': timestampTo,
      if (segments != null) 'segments': segments,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SegmentsTableCompanion copyWith({
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<int>? durationSec,
    Value<int>? timestampFrom,
    Value<int>? timestampTo,
    Value<String>? segments,
    Value<int>? rowid,
  }) {
    return SegmentsTableCompanion(
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      durationSec: durationSec ?? this.durationSec,
      timestampFrom: timestampFrom ?? this.timestampFrom,
      timestampTo: timestampTo ?? this.timestampTo,
      segments: segments ?? this.segments,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (durationSec.present) {
      map['duration_sec'] = Variable<int>(durationSec.value);
    }
    if (timestampFrom.present) {
      map['timestamp_from'] = Variable<int>(timestampFrom.value);
    }
    if (timestampTo.present) {
      map['timestamp_to'] = Variable<int>(timestampTo.value);
    }
    if (segments.present) {
      map['segments'] = Variable<String>(segments.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SegmentsTableCompanion(')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('durationSec: $durationSec, ')
          ..write('timestampFrom: $timestampFrom, ')
          ..write('timestampTo: $timestampTo, ')
          ..write('segments: $segments, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SurahListTableTable extends SurahListTable
    with TableInfo<$SurahListTableTable, SurahListTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurahListTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioUrlMeta = const VerificationMeta(
    'audioUrl',
  );
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
    'audio_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [surahNumber, audioUrl, duration];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'surah_list';
  @override
  VerificationContext validateIntegrity(
    Insertable<SurahListTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    }
    if (data.containsKey('audio_url')) {
      context.handle(
        _audioUrlMeta,
        audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_audioUrlMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surahNumber};
  @override
  SurahListTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurahListTableData(
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      audioUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_url'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      )!,
    );
  }

  @override
  $SurahListTableTable createAlias(String alias) {
    return $SurahListTableTable(attachedDatabase, alias);
  }
}

class SurahListTableData extends DataClass
    implements Insertable<SurahListTableData> {
  final int surahNumber;
  final String audioUrl;
  final int duration;
  const SurahListTableData({
    required this.surahNumber,
    required this.audioUrl,
    required this.duration,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['surah_number'] = Variable<int>(surahNumber);
    map['audio_url'] = Variable<String>(audioUrl);
    map['duration'] = Variable<int>(duration);
    return map;
  }

  SurahListTableCompanion toCompanion(bool nullToAbsent) {
    return SurahListTableCompanion(
      surahNumber: Value(surahNumber),
      audioUrl: Value(audioUrl),
      duration: Value(duration),
    );
  }

  factory SurahListTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurahListTableData(
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      audioUrl: serializer.fromJson<String>(json['audioUrl']),
      duration: serializer.fromJson<int>(json['duration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surahNumber': serializer.toJson<int>(surahNumber),
      'audioUrl': serializer.toJson<String>(audioUrl),
      'duration': serializer.toJson<int>(duration),
    };
  }

  SurahListTableData copyWith({
    int? surahNumber,
    String? audioUrl,
    int? duration,
  }) => SurahListTableData(
    surahNumber: surahNumber ?? this.surahNumber,
    audioUrl: audioUrl ?? this.audioUrl,
    duration: duration ?? this.duration,
  );
  SurahListTableData copyWithCompanion(SurahListTableCompanion data) {
    return SurahListTableData(
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
      duration: data.duration.present ? data.duration.value : this.duration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SurahListTableData(')
          ..write('surahNumber: $surahNumber, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('duration: $duration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(surahNumber, audioUrl, duration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurahListTableData &&
          other.surahNumber == this.surahNumber &&
          other.audioUrl == this.audioUrl &&
          other.duration == this.duration);
}

class SurahListTableCompanion extends UpdateCompanion<SurahListTableData> {
  final Value<int> surahNumber;
  final Value<String> audioUrl;
  final Value<int> duration;
  const SurahListTableCompanion({
    this.surahNumber = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.duration = const Value.absent(),
  });
  SurahListTableCompanion.insert({
    this.surahNumber = const Value.absent(),
    required String audioUrl,
    required int duration,
  }) : audioUrl = Value(audioUrl),
       duration = Value(duration);
  static Insertable<SurahListTableData> custom({
    Expression<int>? surahNumber,
    Expression<String>? audioUrl,
    Expression<int>? duration,
  }) {
    return RawValuesInsertable({
      if (surahNumber != null) 'surah_number': surahNumber,
      if (audioUrl != null) 'audio_url': audioUrl,
      if (duration != null) 'duration': duration,
    });
  }

  SurahListTableCompanion copyWith({
    Value<int>? surahNumber,
    Value<String>? audioUrl,
    Value<int>? duration,
  }) {
    return SurahListTableCompanion(
      surahNumber: surahNumber ?? this.surahNumber,
      audioUrl: audioUrl ?? this.audioUrl,
      duration: duration ?? this.duration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurahListTableCompanion(')
          ..write('surahNumber: $surahNumber, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('duration: $duration')
          ..write(')'))
        .toString();
  }
}

abstract class _$AudioDatabase extends GeneratedDatabase {
  _$AudioDatabase(QueryExecutor e) : super(e);
  $AudioDatabaseManager get managers => $AudioDatabaseManager(this);
  late final $SegmentsTableTable segmentsTable = $SegmentsTableTable(this);
  late final $SurahListTableTable surahListTable = $SurahListTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    segmentsTable,
    surahListTable,
  ];
}

typedef $$SegmentsTableTableCreateCompanionBuilder =
    SegmentsTableCompanion Function({
      required int surahNumber,
      required int ayahNumber,
      required int durationSec,
      required int timestampFrom,
      required int timestampTo,
      required String segments,
      Value<int> rowid,
    });
typedef $$SegmentsTableTableUpdateCompanionBuilder =
    SegmentsTableCompanion Function({
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<int> durationSec,
      Value<int> timestampFrom,
      Value<int> timestampTo,
      Value<String> segments,
      Value<int> rowid,
    });

class $$SegmentsTableTableFilterComposer
    extends Composer<_$AudioDatabase, $SegmentsTableTable> {
  $$SegmentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestampFrom => $composableBuilder(
    column: $table.timestampFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestampTo => $composableBuilder(
    column: $table.timestampTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get segments => $composableBuilder(
    column: $table.segments,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SegmentsTableTableOrderingComposer
    extends Composer<_$AudioDatabase, $SegmentsTableTable> {
  $$SegmentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestampFrom => $composableBuilder(
    column: $table.timestampFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestampTo => $composableBuilder(
    column: $table.timestampTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get segments => $composableBuilder(
    column: $table.segments,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SegmentsTableTableAnnotationComposer
    extends Composer<_$AudioDatabase, $SegmentsTableTable> {
  $$SegmentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timestampFrom => $composableBuilder(
    column: $table.timestampFrom,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timestampTo => $composableBuilder(
    column: $table.timestampTo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get segments =>
      $composableBuilder(column: $table.segments, builder: (column) => column);
}

class $$SegmentsTableTableTableManager
    extends
        RootTableManager<
          _$AudioDatabase,
          $SegmentsTableTable,
          SegmentsTableData,
          $$SegmentsTableTableFilterComposer,
          $$SegmentsTableTableOrderingComposer,
          $$SegmentsTableTableAnnotationComposer,
          $$SegmentsTableTableCreateCompanionBuilder,
          $$SegmentsTableTableUpdateCompanionBuilder,
          (
            SegmentsTableData,
            BaseReferences<
              _$AudioDatabase,
              $SegmentsTableTable,
              SegmentsTableData
            >,
          ),
          SegmentsTableData,
          PrefetchHooks Function()
        > {
  $$SegmentsTableTableTableManager(
    _$AudioDatabase db,
    $SegmentsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SegmentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SegmentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SegmentsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<int> durationSec = const Value.absent(),
                Value<int> timestampFrom = const Value.absent(),
                Value<int> timestampTo = const Value.absent(),
                Value<String> segments = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SegmentsTableCompanion(
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                durationSec: durationSec,
                timestampFrom: timestampFrom,
                timestampTo: timestampTo,
                segments: segments,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int surahNumber,
                required int ayahNumber,
                required int durationSec,
                required int timestampFrom,
                required int timestampTo,
                required String segments,
                Value<int> rowid = const Value.absent(),
              }) => SegmentsTableCompanion.insert(
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                durationSec: durationSec,
                timestampFrom: timestampFrom,
                timestampTo: timestampTo,
                segments: segments,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SegmentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AudioDatabase,
      $SegmentsTableTable,
      SegmentsTableData,
      $$SegmentsTableTableFilterComposer,
      $$SegmentsTableTableOrderingComposer,
      $$SegmentsTableTableAnnotationComposer,
      $$SegmentsTableTableCreateCompanionBuilder,
      $$SegmentsTableTableUpdateCompanionBuilder,
      (
        SegmentsTableData,
        BaseReferences<_$AudioDatabase, $SegmentsTableTable, SegmentsTableData>,
      ),
      SegmentsTableData,
      PrefetchHooks Function()
    >;
typedef $$SurahListTableTableCreateCompanionBuilder =
    SurahListTableCompanion Function({
      Value<int> surahNumber,
      required String audioUrl,
      required int duration,
    });
typedef $$SurahListTableTableUpdateCompanionBuilder =
    SurahListTableCompanion Function({
      Value<int> surahNumber,
      Value<String> audioUrl,
      Value<int> duration,
    });

class $$SurahListTableTableFilterComposer
    extends Composer<_$AudioDatabase, $SurahListTableTable> {
  $$SurahListTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SurahListTableTableOrderingComposer
    extends Composer<_$AudioDatabase, $SurahListTableTable> {
  $$SurahListTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SurahListTableTableAnnotationComposer
    extends Composer<_$AudioDatabase, $SurahListTableTable> {
  $$SurahListTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);
}

class $$SurahListTableTableTableManager
    extends
        RootTableManager<
          _$AudioDatabase,
          $SurahListTableTable,
          SurahListTableData,
          $$SurahListTableTableFilterComposer,
          $$SurahListTableTableOrderingComposer,
          $$SurahListTableTableAnnotationComposer,
          $$SurahListTableTableCreateCompanionBuilder,
          $$SurahListTableTableUpdateCompanionBuilder,
          (
            SurahListTableData,
            BaseReferences<
              _$AudioDatabase,
              $SurahListTableTable,
              SurahListTableData
            >,
          ),
          SurahListTableData,
          PrefetchHooks Function()
        > {
  $$SurahListTableTableTableManager(
    _$AudioDatabase db,
    $SurahListTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SurahListTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SurahListTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SurahListTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> surahNumber = const Value.absent(),
                Value<String> audioUrl = const Value.absent(),
                Value<int> duration = const Value.absent(),
              }) => SurahListTableCompanion(
                surahNumber: surahNumber,
                audioUrl: audioUrl,
                duration: duration,
              ),
          createCompanionCallback:
              ({
                Value<int> surahNumber = const Value.absent(),
                required String audioUrl,
                required int duration,
              }) => SurahListTableCompanion.insert(
                surahNumber: surahNumber,
                audioUrl: audioUrl,
                duration: duration,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SurahListTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AudioDatabase,
      $SurahListTableTable,
      SurahListTableData,
      $$SurahListTableTableFilterComposer,
      $$SurahListTableTableOrderingComposer,
      $$SurahListTableTableAnnotationComposer,
      $$SurahListTableTableCreateCompanionBuilder,
      $$SurahListTableTableUpdateCompanionBuilder,
      (
        SurahListTableData,
        BaseReferences<
          _$AudioDatabase,
          $SurahListTableTable,
          SurahListTableData
        >,
      ),
      SurahListTableData,
      PrefetchHooks Function()
    >;

class $AudioDatabaseManager {
  final _$AudioDatabase _db;
  $AudioDatabaseManager(this._db);
  $$SegmentsTableTableTableManager get segmentsTable =>
      $$SegmentsTableTableTableManager(_db, _db.segmentsTable);
  $$SurahListTableTableTableManager get surahListTable =>
      $$SurahListTableTableTableManager(_db, _db.surahListTable);
}
