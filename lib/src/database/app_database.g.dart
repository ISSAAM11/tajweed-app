// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WordsTable extends Words with TableInfo<$WordsTable, WordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<WordLocation, String> location =
      GeneratedColumn<String>(
        'location',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WordLocation>($WordsTable.$converterlocation);
  static const VerificationMeta _surahMeta = const VerificationMeta('surah');
  @override
  late final GeneratedColumn<int> surah = GeneratedColumn<int>(
    'surah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahMeta = const VerificationMeta('ayah');
  @override
  late final GeneratedColumn<int> ayah = GeneratedColumn<int>(
    'ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<int> word = GeneratedColumn<int>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _text_Meta = const VerificationMeta('text_');
  @override
  late final GeneratedColumn<String> text_ = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    location,
    surah,
    ayah,
    word,
    text_,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah')) {
      context.handle(
        _surahMeta,
        surah.isAcceptableOrUnknown(data['surah']!, _surahMeta),
      );
    } else if (isInserting) {
      context.missing(_surahMeta);
    }
    if (data.containsKey('ayah')) {
      context.handle(
        _ayahMeta,
        ayah.isAcceptableOrUnknown(data['ayah']!, _ayahMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _text_Meta,
        text_.isAcceptableOrUnknown(data['text']!, _text_Meta),
      );
    } else if (isInserting) {
      context.missing(_text_Meta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      location: $WordsTable.$converterlocation.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}location'],
        )!,
      ),
      surah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah'],
      )!,
      ayah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah'],
      )!,
      word: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word'],
      )!,
      text_: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }

  static TypeConverter<WordLocation, String> $converterlocation =
      const WordLocationConverter();
}

class WordRow extends DataClass implements Insertable<WordRow> {
  final int id;
  final WordLocation location;
  final int surah;
  final int ayah;
  final int word;
  final String text_;
  const WordRow({
    required this.id,
    required this.location,
    required this.surah,
    required this.ayah,
    required this.word,
    required this.text_,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['location'] = Variable<String>(
        $WordsTable.$converterlocation.toSql(location),
      );
    }
    map['surah'] = Variable<int>(surah);
    map['ayah'] = Variable<int>(ayah);
    map['word'] = Variable<int>(word);
    map['text'] = Variable<String>(text_);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      location: Value(location),
      surah: Value(surah),
      ayah: Value(ayah),
      word: Value(word),
      text_: Value(text_),
    );
  }

  factory WordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordRow(
      id: serializer.fromJson<int>(json['id']),
      location: serializer.fromJson<WordLocation>(json['location']),
      surah: serializer.fromJson<int>(json['surah']),
      ayah: serializer.fromJson<int>(json['ayah']),
      word: serializer.fromJson<int>(json['word']),
      text_: serializer.fromJson<String>(json['text_']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'location': serializer.toJson<WordLocation>(location),
      'surah': serializer.toJson<int>(surah),
      'ayah': serializer.toJson<int>(ayah),
      'word': serializer.toJson<int>(word),
      'text_': serializer.toJson<String>(text_),
    };
  }

  WordRow copyWith({
    int? id,
    WordLocation? location,
    int? surah,
    int? ayah,
    int? word,
    String? text_,
  }) => WordRow(
    id: id ?? this.id,
    location: location ?? this.location,
    surah: surah ?? this.surah,
    ayah: ayah ?? this.ayah,
    word: word ?? this.word,
    text_: text_ ?? this.text_,
  );
  WordRow copyWithCompanion(WordsCompanion data) {
    return WordRow(
      id: data.id.present ? data.id.value : this.id,
      location: data.location.present ? data.location.value : this.location,
      surah: data.surah.present ? data.surah.value : this.surah,
      ayah: data.ayah.present ? data.ayah.value : this.ayah,
      word: data.word.present ? data.word.value : this.word,
      text_: data.text_.present ? data.text_.value : this.text_,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordRow(')
          ..write('id: $id, ')
          ..write('location: $location, ')
          ..write('surah: $surah, ')
          ..write('ayah: $ayah, ')
          ..write('word: $word, ')
          ..write('text_: $text_')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, location, surah, ayah, word, text_);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordRow &&
          other.id == this.id &&
          other.location == this.location &&
          other.surah == this.surah &&
          other.ayah == this.ayah &&
          other.word == this.word &&
          other.text_ == this.text_);
}

class WordsCompanion extends UpdateCompanion<WordRow> {
  final Value<int> id;
  final Value<WordLocation> location;
  final Value<int> surah;
  final Value<int> ayah;
  final Value<int> word;
  final Value<String> text_;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.location = const Value.absent(),
    this.surah = const Value.absent(),
    this.ayah = const Value.absent(),
    this.word = const Value.absent(),
    this.text_ = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required WordLocation location,
    required int surah,
    required int ayah,
    required int word,
    required String text_,
  }) : location = Value(location),
       surah = Value(surah),
       ayah = Value(ayah),
       word = Value(word),
       text_ = Value(text_);
  static Insertable<WordRow> custom({
    Expression<int>? id,
    Expression<String>? location,
    Expression<int>? surah,
    Expression<int>? ayah,
    Expression<int>? word,
    Expression<String>? text_,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (location != null) 'location': location,
      if (surah != null) 'surah': surah,
      if (ayah != null) 'ayah': ayah,
      if (word != null) 'word': word,
      if (text_ != null) 'text': text_,
    });
  }

  WordsCompanion copyWith({
    Value<int>? id,
    Value<WordLocation>? location,
    Value<int>? surah,
    Value<int>? ayah,
    Value<int>? word,
    Value<String>? text_,
  }) {
    return WordsCompanion(
      id: id ?? this.id,
      location: location ?? this.location,
      surah: surah ?? this.surah,
      ayah: ayah ?? this.ayah,
      word: word ?? this.word,
      text_: text_ ?? this.text_,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(
        $WordsTable.$converterlocation.toSql(location.value),
      );
    }
    if (surah.present) {
      map['surah'] = Variable<int>(surah.value);
    }
    if (ayah.present) {
      map['ayah'] = Variable<int>(ayah.value);
    }
    if (word.present) {
      map['word'] = Variable<int>(word.value);
    }
    if (text_.present) {
      map['text'] = Variable<String>(text_.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('location: $location, ')
          ..write('surah: $surah, ')
          ..write('ayah: $ayah, ')
          ..write('word: $word, ')
          ..write('text_: $text_')
          ..write(')'))
        .toString();
  }
}

class $ChaptersTable extends Chapters
    with TableInfo<$ChaptersTable, ChapterRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChaptersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
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
  static const VerificationMeta _revelationOrderMeta = const VerificationMeta(
    'revelationOrder',
  );
  @override
  late final GeneratedColumn<int> revelationOrder = GeneratedColumn<int>(
    'revelation_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RevelationPlace, String>
  revelationPlace = GeneratedColumn<String>(
    'revelation_place',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<RevelationPlace>($ChaptersTable.$converterrevelationPlace);
  static const VerificationMeta _versesCountMeta = const VerificationMeta(
    'versesCount',
  );
  @override
  late final GeneratedColumn<int> versesCount = GeneratedColumn<int>(
    'verses_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<bool, int> bismillahPre =
      GeneratedColumn<int>(
        'bismillah_pre',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<bool>($ChaptersTable.$converterbismillahPre);
  static const VerificationMeta _nameGlyphMeta = const VerificationMeta(
    'nameGlyph',
  );
  @override
  late final GeneratedColumn<String> nameGlyph = GeneratedColumn<String>(
    'name_glyph',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nameSimple,
    nameArabic,
    revelationOrder,
    revelationPlace,
    versesCount,
    bismillahPre,
    nameGlyph,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapters';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChapterRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_simple')) {
      context.handle(
        _nameSimpleMeta,
        nameSimple.isAcceptableOrUnknown(data['name_simple']!, _nameSimpleMeta),
      );
    } else if (isInserting) {
      context.missing(_nameSimpleMeta);
    }
    if (data.containsKey('name_arabic')) {
      context.handle(
        _nameArabicMeta,
        nameArabic.isAcceptableOrUnknown(data['name_arabic']!, _nameArabicMeta),
      );
    } else if (isInserting) {
      context.missing(_nameArabicMeta);
    }
    if (data.containsKey('revelation_order')) {
      context.handle(
        _revelationOrderMeta,
        revelationOrder.isAcceptableOrUnknown(
          data['revelation_order']!,
          _revelationOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_revelationOrderMeta);
    }
    if (data.containsKey('verses_count')) {
      context.handle(
        _versesCountMeta,
        versesCount.isAcceptableOrUnknown(
          data['verses_count']!,
          _versesCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_versesCountMeta);
    }
    if (data.containsKey('name_glyph')) {
      context.handle(
        _nameGlyphMeta,
        nameGlyph.isAcceptableOrUnknown(data['name_glyph']!, _nameGlyphMeta),
      );
    } else if (isInserting) {
      context.missing(_nameGlyphMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChapterRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChapterRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameSimple: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_simple'],
      )!,
      nameArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_arabic'],
      )!,
      revelationOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revelation_order'],
      )!,
      revelationPlace: $ChaptersTable.$converterrevelationPlace.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}revelation_place'],
        )!,
      ),
      versesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verses_count'],
      )!,
      bismillahPre: $ChaptersTable.$converterbismillahPre.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}bismillah_pre'],
        )!,
      ),
      nameGlyph: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_glyph'],
      )!,
    );
  }

  @override
  $ChaptersTable createAlias(String alias) {
    return $ChaptersTable(attachedDatabase, alias);
  }

  static TypeConverter<RevelationPlace, String> $converterrevelationPlace =
      const RevelationPlaceConverter();
  static TypeConverter<bool, int> $converterbismillahPre =
      const BoolIntConverter();
}

class ChapterRow extends DataClass implements Insertable<ChapterRow> {
  final int id;
  final String name;
  final String nameSimple;
  final String nameArabic;
  final int revelationOrder;
  final RevelationPlace revelationPlace;
  final int versesCount;
  final bool bismillahPre;
  final String nameGlyph;
  const ChapterRow({
    required this.id,
    required this.name,
    required this.nameSimple,
    required this.nameArabic,
    required this.revelationOrder,
    required this.revelationPlace,
    required this.versesCount,
    required this.bismillahPre,
    required this.nameGlyph,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['name_simple'] = Variable<String>(nameSimple);
    map['name_arabic'] = Variable<String>(nameArabic);
    map['revelation_order'] = Variable<int>(revelationOrder);
    {
      map['revelation_place'] = Variable<String>(
        $ChaptersTable.$converterrevelationPlace.toSql(revelationPlace),
      );
    }
    map['verses_count'] = Variable<int>(versesCount);
    {
      map['bismillah_pre'] = Variable<int>(
        $ChaptersTable.$converterbismillahPre.toSql(bismillahPre),
      );
    }
    map['name_glyph'] = Variable<String>(nameGlyph);
    return map;
  }

  ChaptersCompanion toCompanion(bool nullToAbsent) {
    return ChaptersCompanion(
      id: Value(id),
      name: Value(name),
      nameSimple: Value(nameSimple),
      nameArabic: Value(nameArabic),
      revelationOrder: Value(revelationOrder),
      revelationPlace: Value(revelationPlace),
      versesCount: Value(versesCount),
      bismillahPre: Value(bismillahPre),
      nameGlyph: Value(nameGlyph),
    );
  }

  factory ChapterRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChapterRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameSimple: serializer.fromJson<String>(json['nameSimple']),
      nameArabic: serializer.fromJson<String>(json['nameArabic']),
      revelationOrder: serializer.fromJson<int>(json['revelationOrder']),
      revelationPlace: serializer.fromJson<RevelationPlace>(
        json['revelationPlace'],
      ),
      versesCount: serializer.fromJson<int>(json['versesCount']),
      bismillahPre: serializer.fromJson<bool>(json['bismillahPre']),
      nameGlyph: serializer.fromJson<String>(json['nameGlyph']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameSimple': serializer.toJson<String>(nameSimple),
      'nameArabic': serializer.toJson<String>(nameArabic),
      'revelationOrder': serializer.toJson<int>(revelationOrder),
      'revelationPlace': serializer.toJson<RevelationPlace>(revelationPlace),
      'versesCount': serializer.toJson<int>(versesCount),
      'bismillahPre': serializer.toJson<bool>(bismillahPre),
      'nameGlyph': serializer.toJson<String>(nameGlyph),
    };
  }

  ChapterRow copyWith({
    int? id,
    String? name,
    String? nameSimple,
    String? nameArabic,
    int? revelationOrder,
    RevelationPlace? revelationPlace,
    int? versesCount,
    bool? bismillahPre,
    String? nameGlyph,
  }) => ChapterRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nameSimple: nameSimple ?? this.nameSimple,
    nameArabic: nameArabic ?? this.nameArabic,
    revelationOrder: revelationOrder ?? this.revelationOrder,
    revelationPlace: revelationPlace ?? this.revelationPlace,
    versesCount: versesCount ?? this.versesCount,
    bismillahPre: bismillahPre ?? this.bismillahPre,
    nameGlyph: nameGlyph ?? this.nameGlyph,
  );
  ChapterRow copyWithCompanion(ChaptersCompanion data) {
    return ChapterRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameSimple: data.nameSimple.present
          ? data.nameSimple.value
          : this.nameSimple,
      nameArabic: data.nameArabic.present
          ? data.nameArabic.value
          : this.nameArabic,
      revelationOrder: data.revelationOrder.present
          ? data.revelationOrder.value
          : this.revelationOrder,
      revelationPlace: data.revelationPlace.present
          ? data.revelationPlace.value
          : this.revelationPlace,
      versesCount: data.versesCount.present
          ? data.versesCount.value
          : this.versesCount,
      bismillahPre: data.bismillahPre.present
          ? data.bismillahPre.value
          : this.bismillahPre,
      nameGlyph: data.nameGlyph.present ? data.nameGlyph.value : this.nameGlyph,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChapterRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameSimple: $nameSimple, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('revelationOrder: $revelationOrder, ')
          ..write('revelationPlace: $revelationPlace, ')
          ..write('versesCount: $versesCount, ')
          ..write('bismillahPre: $bismillahPre, ')
          ..write('nameGlyph: $nameGlyph')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    nameSimple,
    nameArabic,
    revelationOrder,
    revelationPlace,
    versesCount,
    bismillahPre,
    nameGlyph,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChapterRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameSimple == this.nameSimple &&
          other.nameArabic == this.nameArabic &&
          other.revelationOrder == this.revelationOrder &&
          other.revelationPlace == this.revelationPlace &&
          other.versesCount == this.versesCount &&
          other.bismillahPre == this.bismillahPre &&
          other.nameGlyph == this.nameGlyph);
}

class ChaptersCompanion extends UpdateCompanion<ChapterRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> nameSimple;
  final Value<String> nameArabic;
  final Value<int> revelationOrder;
  final Value<RevelationPlace> revelationPlace;
  final Value<int> versesCount;
  final Value<bool> bismillahPre;
  final Value<String> nameGlyph;
  const ChaptersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameSimple = const Value.absent(),
    this.nameArabic = const Value.absent(),
    this.revelationOrder = const Value.absent(),
    this.revelationPlace = const Value.absent(),
    this.versesCount = const Value.absent(),
    this.bismillahPre = const Value.absent(),
    this.nameGlyph = const Value.absent(),
  });
  ChaptersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String nameSimple,
    required String nameArabic,
    required int revelationOrder,
    required RevelationPlace revelationPlace,
    required int versesCount,
    required bool bismillahPre,
    required String nameGlyph,
  }) : name = Value(name),
       nameSimple = Value(nameSimple),
       nameArabic = Value(nameArabic),
       revelationOrder = Value(revelationOrder),
       revelationPlace = Value(revelationPlace),
       versesCount = Value(versesCount),
       bismillahPre = Value(bismillahPre),
       nameGlyph = Value(nameGlyph);
  static Insertable<ChapterRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameSimple,
    Expression<String>? nameArabic,
    Expression<int>? revelationOrder,
    Expression<String>? revelationPlace,
    Expression<int>? versesCount,
    Expression<int>? bismillahPre,
    Expression<String>? nameGlyph,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameSimple != null) 'name_simple': nameSimple,
      if (nameArabic != null) 'name_arabic': nameArabic,
      if (revelationOrder != null) 'revelation_order': revelationOrder,
      if (revelationPlace != null) 'revelation_place': revelationPlace,
      if (versesCount != null) 'verses_count': versesCount,
      if (bismillahPre != null) 'bismillah_pre': bismillahPre,
      if (nameGlyph != null) 'name_glyph': nameGlyph,
    });
  }

  ChaptersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? nameSimple,
    Value<String>? nameArabic,
    Value<int>? revelationOrder,
    Value<RevelationPlace>? revelationPlace,
    Value<int>? versesCount,
    Value<bool>? bismillahPre,
    Value<String>? nameGlyph,
  }) {
    return ChaptersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameSimple: nameSimple ?? this.nameSimple,
      nameArabic: nameArabic ?? this.nameArabic,
      revelationOrder: revelationOrder ?? this.revelationOrder,
      revelationPlace: revelationPlace ?? this.revelationPlace,
      versesCount: versesCount ?? this.versesCount,
      bismillahPre: bismillahPre ?? this.bismillahPre,
      nameGlyph: nameGlyph ?? this.nameGlyph,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameSimple.present) {
      map['name_simple'] = Variable<String>(nameSimple.value);
    }
    if (nameArabic.present) {
      map['name_arabic'] = Variable<String>(nameArabic.value);
    }
    if (revelationOrder.present) {
      map['revelation_order'] = Variable<int>(revelationOrder.value);
    }
    if (revelationPlace.present) {
      map['revelation_place'] = Variable<String>(
        $ChaptersTable.$converterrevelationPlace.toSql(revelationPlace.value),
      );
    }
    if (versesCount.present) {
      map['verses_count'] = Variable<int>(versesCount.value);
    }
    if (bismillahPre.present) {
      map['bismillah_pre'] = Variable<int>(
        $ChaptersTable.$converterbismillahPre.toSql(bismillahPre.value),
      );
    }
    if (nameGlyph.present) {
      map['name_glyph'] = Variable<String>(nameGlyph.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChaptersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameSimple: $nameSimple, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('revelationOrder: $revelationOrder, ')
          ..write('revelationPlace: $revelationPlace, ')
          ..write('versesCount: $versesCount, ')
          ..write('bismillahPre: $bismillahPre, ')
          ..write('nameGlyph: $nameGlyph')
          ..write(')'))
        .toString();
  }
}

class $HizbsTable extends Hizbs with TableInfo<$HizbsTable, HizbRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HizbsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _hizbNumberMeta = const VerificationMeta(
    'hizbNumber',
  );
  @override
  late final GeneratedColumn<int> hizbNumber = GeneratedColumn<int>(
    'hizb_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versesCountMeta = const VerificationMeta(
    'versesCount',
  );
  @override
  late final GeneratedColumn<int> versesCount = GeneratedColumn<int>(
    'verses_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<VerseKey, String> firstVerseKey =
      GeneratedColumn<String>(
        'first_verse_key',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VerseKey>($HizbsTable.$converterfirstVerseKey);
  @override
  late final GeneratedColumnWithTypeConverter<VerseKey, String> lastVerseKey =
      GeneratedColumn<String>(
        'last_verse_key',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VerseKey>($HizbsTable.$converterlastVerseKey);
  @override
  late final GeneratedColumnWithTypeConverter<SurahRanges, String>
  verseMapping = GeneratedColumn<String>(
    'verse_mapping',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SurahRanges>($HizbsTable.$converterverseMapping);
  @override
  List<GeneratedColumn> get $columns => [
    hizbNumber,
    versesCount,
    firstVerseKey,
    lastVerseKey,
    verseMapping,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hizbs';
  @override
  VerificationContext validateIntegrity(
    Insertable<HizbRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('hizb_number')) {
      context.handle(
        _hizbNumberMeta,
        hizbNumber.isAcceptableOrUnknown(data['hizb_number']!, _hizbNumberMeta),
      );
    }
    if (data.containsKey('verses_count')) {
      context.handle(
        _versesCountMeta,
        versesCount.isAcceptableOrUnknown(
          data['verses_count']!,
          _versesCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_versesCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {hizbNumber};
  @override
  HizbRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HizbRow(
      hizbNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hizb_number'],
      )!,
      versesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verses_count'],
      )!,
      firstVerseKey: $HizbsTable.$converterfirstVerseKey.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}first_verse_key'],
        )!,
      ),
      lastVerseKey: $HizbsTable.$converterlastVerseKey.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}last_verse_key'],
        )!,
      ),
      verseMapping: $HizbsTable.$converterverseMapping.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}verse_mapping'],
        )!,
      ),
    );
  }

  @override
  $HizbsTable createAlias(String alias) {
    return $HizbsTable(attachedDatabase, alias);
  }

  static TypeConverter<VerseKey, String> $converterfirstVerseKey =
      const VerseKeyConverter();
  static TypeConverter<VerseKey, String> $converterlastVerseKey =
      const VerseKeyConverter();
  static TypeConverter<SurahRanges, String> $converterverseMapping =
      const SurahRangesConverter();
}

class HizbRow extends DataClass implements Insertable<HizbRow> {
  final int hizbNumber;
  final int versesCount;
  final VerseKey firstVerseKey;
  final VerseKey lastVerseKey;
  final SurahRanges verseMapping;
  const HizbRow({
    required this.hizbNumber,
    required this.versesCount,
    required this.firstVerseKey,
    required this.lastVerseKey,
    required this.verseMapping,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['hizb_number'] = Variable<int>(hizbNumber);
    map['verses_count'] = Variable<int>(versesCount);
    {
      map['first_verse_key'] = Variable<String>(
        $HizbsTable.$converterfirstVerseKey.toSql(firstVerseKey),
      );
    }
    {
      map['last_verse_key'] = Variable<String>(
        $HizbsTable.$converterlastVerseKey.toSql(lastVerseKey),
      );
    }
    {
      map['verse_mapping'] = Variable<String>(
        $HizbsTable.$converterverseMapping.toSql(verseMapping),
      );
    }
    return map;
  }

  HizbsCompanion toCompanion(bool nullToAbsent) {
    return HizbsCompanion(
      hizbNumber: Value(hizbNumber),
      versesCount: Value(versesCount),
      firstVerseKey: Value(firstVerseKey),
      lastVerseKey: Value(lastVerseKey),
      verseMapping: Value(verseMapping),
    );
  }

  factory HizbRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HizbRow(
      hizbNumber: serializer.fromJson<int>(json['hizbNumber']),
      versesCount: serializer.fromJson<int>(json['versesCount']),
      firstVerseKey: serializer.fromJson<VerseKey>(json['firstVerseKey']),
      lastVerseKey: serializer.fromJson<VerseKey>(json['lastVerseKey']),
      verseMapping: serializer.fromJson<SurahRanges>(json['verseMapping']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'hizbNumber': serializer.toJson<int>(hizbNumber),
      'versesCount': serializer.toJson<int>(versesCount),
      'firstVerseKey': serializer.toJson<VerseKey>(firstVerseKey),
      'lastVerseKey': serializer.toJson<VerseKey>(lastVerseKey),
      'verseMapping': serializer.toJson<SurahRanges>(verseMapping),
    };
  }

  HizbRow copyWith({
    int? hizbNumber,
    int? versesCount,
    VerseKey? firstVerseKey,
    VerseKey? lastVerseKey,
    SurahRanges? verseMapping,
  }) => HizbRow(
    hizbNumber: hizbNumber ?? this.hizbNumber,
    versesCount: versesCount ?? this.versesCount,
    firstVerseKey: firstVerseKey ?? this.firstVerseKey,
    lastVerseKey: lastVerseKey ?? this.lastVerseKey,
    verseMapping: verseMapping ?? this.verseMapping,
  );
  HizbRow copyWithCompanion(HizbsCompanion data) {
    return HizbRow(
      hizbNumber: data.hizbNumber.present
          ? data.hizbNumber.value
          : this.hizbNumber,
      versesCount: data.versesCount.present
          ? data.versesCount.value
          : this.versesCount,
      firstVerseKey: data.firstVerseKey.present
          ? data.firstVerseKey.value
          : this.firstVerseKey,
      lastVerseKey: data.lastVerseKey.present
          ? data.lastVerseKey.value
          : this.lastVerseKey,
      verseMapping: data.verseMapping.present
          ? data.verseMapping.value
          : this.verseMapping,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HizbRow(')
          ..write('hizbNumber: $hizbNumber, ')
          ..write('versesCount: $versesCount, ')
          ..write('firstVerseKey: $firstVerseKey, ')
          ..write('lastVerseKey: $lastVerseKey, ')
          ..write('verseMapping: $verseMapping')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    hizbNumber,
    versesCount,
    firstVerseKey,
    lastVerseKey,
    verseMapping,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HizbRow &&
          other.hizbNumber == this.hizbNumber &&
          other.versesCount == this.versesCount &&
          other.firstVerseKey == this.firstVerseKey &&
          other.lastVerseKey == this.lastVerseKey &&
          other.verseMapping == this.verseMapping);
}

class HizbsCompanion extends UpdateCompanion<HizbRow> {
  final Value<int> hizbNumber;
  final Value<int> versesCount;
  final Value<VerseKey> firstVerseKey;
  final Value<VerseKey> lastVerseKey;
  final Value<SurahRanges> verseMapping;
  const HizbsCompanion({
    this.hizbNumber = const Value.absent(),
    this.versesCount = const Value.absent(),
    this.firstVerseKey = const Value.absent(),
    this.lastVerseKey = const Value.absent(),
    this.verseMapping = const Value.absent(),
  });
  HizbsCompanion.insert({
    this.hizbNumber = const Value.absent(),
    required int versesCount,
    required VerseKey firstVerseKey,
    required VerseKey lastVerseKey,
    required SurahRanges verseMapping,
  }) : versesCount = Value(versesCount),
       firstVerseKey = Value(firstVerseKey),
       lastVerseKey = Value(lastVerseKey),
       verseMapping = Value(verseMapping);
  static Insertable<HizbRow> custom({
    Expression<int>? hizbNumber,
    Expression<int>? versesCount,
    Expression<String>? firstVerseKey,
    Expression<String>? lastVerseKey,
    Expression<String>? verseMapping,
  }) {
    return RawValuesInsertable({
      if (hizbNumber != null) 'hizb_number': hizbNumber,
      if (versesCount != null) 'verses_count': versesCount,
      if (firstVerseKey != null) 'first_verse_key': firstVerseKey,
      if (lastVerseKey != null) 'last_verse_key': lastVerseKey,
      if (verseMapping != null) 'verse_mapping': verseMapping,
    });
  }

  HizbsCompanion copyWith({
    Value<int>? hizbNumber,
    Value<int>? versesCount,
    Value<VerseKey>? firstVerseKey,
    Value<VerseKey>? lastVerseKey,
    Value<SurahRanges>? verseMapping,
  }) {
    return HizbsCompanion(
      hizbNumber: hizbNumber ?? this.hizbNumber,
      versesCount: versesCount ?? this.versesCount,
      firstVerseKey: firstVerseKey ?? this.firstVerseKey,
      lastVerseKey: lastVerseKey ?? this.lastVerseKey,
      verseMapping: verseMapping ?? this.verseMapping,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (hizbNumber.present) {
      map['hizb_number'] = Variable<int>(hizbNumber.value);
    }
    if (versesCount.present) {
      map['verses_count'] = Variable<int>(versesCount.value);
    }
    if (firstVerseKey.present) {
      map['first_verse_key'] = Variable<String>(
        $HizbsTable.$converterfirstVerseKey.toSql(firstVerseKey.value),
      );
    }
    if (lastVerseKey.present) {
      map['last_verse_key'] = Variable<String>(
        $HizbsTable.$converterlastVerseKey.toSql(lastVerseKey.value),
      );
    }
    if (verseMapping.present) {
      map['verse_mapping'] = Variable<String>(
        $HizbsTable.$converterverseMapping.toSql(verseMapping.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HizbsCompanion(')
          ..write('hizbNumber: $hizbNumber, ')
          ..write('versesCount: $versesCount, ')
          ..write('firstVerseKey: $firstVerseKey, ')
          ..write('lastVerseKey: $lastVerseKey, ')
          ..write('verseMapping: $verseMapping')
          ..write(')'))
        .toString();
  }
}

class $JuzsTable extends Juzs with TableInfo<$JuzsTable, JuzRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JuzsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _juzNumberMeta = const VerificationMeta(
    'juzNumber',
  );
  @override
  late final GeneratedColumn<int> juzNumber = GeneratedColumn<int>(
    'juz_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versesCountMeta = const VerificationMeta(
    'versesCount',
  );
  @override
  late final GeneratedColumn<int> versesCount = GeneratedColumn<int>(
    'verses_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<VerseKey, String> firstVerseKey =
      GeneratedColumn<String>(
        'first_verse_key',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VerseKey>($JuzsTable.$converterfirstVerseKey);
  @override
  late final GeneratedColumnWithTypeConverter<VerseKey, String> lastVerseKey =
      GeneratedColumn<String>(
        'last_verse_key',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VerseKey>($JuzsTable.$converterlastVerseKey);
  @override
  late final GeneratedColumnWithTypeConverter<SurahRanges, String>
  verseMapping = GeneratedColumn<String>(
    'verse_mapping',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SurahRanges>($JuzsTable.$converterverseMapping);
  @override
  List<GeneratedColumn> get $columns => [
    juzNumber,
    versesCount,
    firstVerseKey,
    lastVerseKey,
    verseMapping,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'juzs';
  @override
  VerificationContext validateIntegrity(
    Insertable<JuzRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('juz_number')) {
      context.handle(
        _juzNumberMeta,
        juzNumber.isAcceptableOrUnknown(data['juz_number']!, _juzNumberMeta),
      );
    }
    if (data.containsKey('verses_count')) {
      context.handle(
        _versesCountMeta,
        versesCount.isAcceptableOrUnknown(
          data['verses_count']!,
          _versesCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_versesCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {juzNumber};
  @override
  JuzRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JuzRow(
      juzNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}juz_number'],
      )!,
      versesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verses_count'],
      )!,
      firstVerseKey: $JuzsTable.$converterfirstVerseKey.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}first_verse_key'],
        )!,
      ),
      lastVerseKey: $JuzsTable.$converterlastVerseKey.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}last_verse_key'],
        )!,
      ),
      verseMapping: $JuzsTable.$converterverseMapping.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}verse_mapping'],
        )!,
      ),
    );
  }

  @override
  $JuzsTable createAlias(String alias) {
    return $JuzsTable(attachedDatabase, alias);
  }

  static TypeConverter<VerseKey, String> $converterfirstVerseKey =
      const VerseKeyConverter();
  static TypeConverter<VerseKey, String> $converterlastVerseKey =
      const VerseKeyConverter();
  static TypeConverter<SurahRanges, String> $converterverseMapping =
      const SurahRangesConverter();
}

class JuzRow extends DataClass implements Insertable<JuzRow> {
  final int juzNumber;
  final int versesCount;
  final VerseKey firstVerseKey;
  final VerseKey lastVerseKey;
  final SurahRanges verseMapping;
  const JuzRow({
    required this.juzNumber,
    required this.versesCount,
    required this.firstVerseKey,
    required this.lastVerseKey,
    required this.verseMapping,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['juz_number'] = Variable<int>(juzNumber);
    map['verses_count'] = Variable<int>(versesCount);
    {
      map['first_verse_key'] = Variable<String>(
        $JuzsTable.$converterfirstVerseKey.toSql(firstVerseKey),
      );
    }
    {
      map['last_verse_key'] = Variable<String>(
        $JuzsTable.$converterlastVerseKey.toSql(lastVerseKey),
      );
    }
    {
      map['verse_mapping'] = Variable<String>(
        $JuzsTable.$converterverseMapping.toSql(verseMapping),
      );
    }
    return map;
  }

  JuzsCompanion toCompanion(bool nullToAbsent) {
    return JuzsCompanion(
      juzNumber: Value(juzNumber),
      versesCount: Value(versesCount),
      firstVerseKey: Value(firstVerseKey),
      lastVerseKey: Value(lastVerseKey),
      verseMapping: Value(verseMapping),
    );
  }

  factory JuzRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JuzRow(
      juzNumber: serializer.fromJson<int>(json['juzNumber']),
      versesCount: serializer.fromJson<int>(json['versesCount']),
      firstVerseKey: serializer.fromJson<VerseKey>(json['firstVerseKey']),
      lastVerseKey: serializer.fromJson<VerseKey>(json['lastVerseKey']),
      verseMapping: serializer.fromJson<SurahRanges>(json['verseMapping']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'juzNumber': serializer.toJson<int>(juzNumber),
      'versesCount': serializer.toJson<int>(versesCount),
      'firstVerseKey': serializer.toJson<VerseKey>(firstVerseKey),
      'lastVerseKey': serializer.toJson<VerseKey>(lastVerseKey),
      'verseMapping': serializer.toJson<SurahRanges>(verseMapping),
    };
  }

  JuzRow copyWith({
    int? juzNumber,
    int? versesCount,
    VerseKey? firstVerseKey,
    VerseKey? lastVerseKey,
    SurahRanges? verseMapping,
  }) => JuzRow(
    juzNumber: juzNumber ?? this.juzNumber,
    versesCount: versesCount ?? this.versesCount,
    firstVerseKey: firstVerseKey ?? this.firstVerseKey,
    lastVerseKey: lastVerseKey ?? this.lastVerseKey,
    verseMapping: verseMapping ?? this.verseMapping,
  );
  JuzRow copyWithCompanion(JuzsCompanion data) {
    return JuzRow(
      juzNumber: data.juzNumber.present ? data.juzNumber.value : this.juzNumber,
      versesCount: data.versesCount.present
          ? data.versesCount.value
          : this.versesCount,
      firstVerseKey: data.firstVerseKey.present
          ? data.firstVerseKey.value
          : this.firstVerseKey,
      lastVerseKey: data.lastVerseKey.present
          ? data.lastVerseKey.value
          : this.lastVerseKey,
      verseMapping: data.verseMapping.present
          ? data.verseMapping.value
          : this.verseMapping,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JuzRow(')
          ..write('juzNumber: $juzNumber, ')
          ..write('versesCount: $versesCount, ')
          ..write('firstVerseKey: $firstVerseKey, ')
          ..write('lastVerseKey: $lastVerseKey, ')
          ..write('verseMapping: $verseMapping')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    juzNumber,
    versesCount,
    firstVerseKey,
    lastVerseKey,
    verseMapping,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JuzRow &&
          other.juzNumber == this.juzNumber &&
          other.versesCount == this.versesCount &&
          other.firstVerseKey == this.firstVerseKey &&
          other.lastVerseKey == this.lastVerseKey &&
          other.verseMapping == this.verseMapping);
}

class JuzsCompanion extends UpdateCompanion<JuzRow> {
  final Value<int> juzNumber;
  final Value<int> versesCount;
  final Value<VerseKey> firstVerseKey;
  final Value<VerseKey> lastVerseKey;
  final Value<SurahRanges> verseMapping;
  const JuzsCompanion({
    this.juzNumber = const Value.absent(),
    this.versesCount = const Value.absent(),
    this.firstVerseKey = const Value.absent(),
    this.lastVerseKey = const Value.absent(),
    this.verseMapping = const Value.absent(),
  });
  JuzsCompanion.insert({
    this.juzNumber = const Value.absent(),
    required int versesCount,
    required VerseKey firstVerseKey,
    required VerseKey lastVerseKey,
    required SurahRanges verseMapping,
  }) : versesCount = Value(versesCount),
       firstVerseKey = Value(firstVerseKey),
       lastVerseKey = Value(lastVerseKey),
       verseMapping = Value(verseMapping);
  static Insertable<JuzRow> custom({
    Expression<int>? juzNumber,
    Expression<int>? versesCount,
    Expression<String>? firstVerseKey,
    Expression<String>? lastVerseKey,
    Expression<String>? verseMapping,
  }) {
    return RawValuesInsertable({
      if (juzNumber != null) 'juz_number': juzNumber,
      if (versesCount != null) 'verses_count': versesCount,
      if (firstVerseKey != null) 'first_verse_key': firstVerseKey,
      if (lastVerseKey != null) 'last_verse_key': lastVerseKey,
      if (verseMapping != null) 'verse_mapping': verseMapping,
    });
  }

  JuzsCompanion copyWith({
    Value<int>? juzNumber,
    Value<int>? versesCount,
    Value<VerseKey>? firstVerseKey,
    Value<VerseKey>? lastVerseKey,
    Value<SurahRanges>? verseMapping,
  }) {
    return JuzsCompanion(
      juzNumber: juzNumber ?? this.juzNumber,
      versesCount: versesCount ?? this.versesCount,
      firstVerseKey: firstVerseKey ?? this.firstVerseKey,
      lastVerseKey: lastVerseKey ?? this.lastVerseKey,
      verseMapping: verseMapping ?? this.verseMapping,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (juzNumber.present) {
      map['juz_number'] = Variable<int>(juzNumber.value);
    }
    if (versesCount.present) {
      map['verses_count'] = Variable<int>(versesCount.value);
    }
    if (firstVerseKey.present) {
      map['first_verse_key'] = Variable<String>(
        $JuzsTable.$converterfirstVerseKey.toSql(firstVerseKey.value),
      );
    }
    if (lastVerseKey.present) {
      map['last_verse_key'] = Variable<String>(
        $JuzsTable.$converterlastVerseKey.toSql(lastVerseKey.value),
      );
    }
    if (verseMapping.present) {
      map['verse_mapping'] = Variable<String>(
        $JuzsTable.$converterverseMapping.toSql(verseMapping.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JuzsCompanion(')
          ..write('juzNumber: $juzNumber, ')
          ..write('versesCount: $versesCount, ')
          ..write('firstVerseKey: $firstVerseKey, ')
          ..write('lastVerseKey: $lastVerseKey, ')
          ..write('verseMapping: $verseMapping')
          ..write(')'))
        .toString();
  }
}

class $RukusTable extends Rukus with TableInfo<$RukusTable, RukuRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RukusTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rukuNumberMeta = const VerificationMeta(
    'rukuNumber',
  );
  @override
  late final GeneratedColumn<int> rukuNumber = GeneratedColumn<int>(
    'ruku_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _surahRukuNumberMeta = const VerificationMeta(
    'surahRukuNumber',
  );
  @override
  late final GeneratedColumn<int> surahRukuNumber = GeneratedColumn<int>(
    'surah_ruku_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versesCountMeta = const VerificationMeta(
    'versesCount',
  );
  @override
  late final GeneratedColumn<int> versesCount = GeneratedColumn<int>(
    'verses_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<VerseKey, String> firstVerseKey =
      GeneratedColumn<String>(
        'first_verse_key',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VerseKey>($RukusTable.$converterfirstVerseKey);
  @override
  late final GeneratedColumnWithTypeConverter<VerseKey, String> lastVerseKey =
      GeneratedColumn<String>(
        'last_verse_key',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VerseKey>($RukusTable.$converterlastVerseKey);
  @override
  late final GeneratedColumnWithTypeConverter<SurahRanges, String>
  verseMapping = GeneratedColumn<String>(
    'verse_mapping',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SurahRanges>($RukusTable.$converterverseMapping);
  @override
  List<GeneratedColumn> get $columns => [
    rukuNumber,
    surahRukuNumber,
    versesCount,
    firstVerseKey,
    lastVerseKey,
    verseMapping,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rukus';
  @override
  VerificationContext validateIntegrity(
    Insertable<RukuRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ruku_number')) {
      context.handle(
        _rukuNumberMeta,
        rukuNumber.isAcceptableOrUnknown(data['ruku_number']!, _rukuNumberMeta),
      );
    }
    if (data.containsKey('surah_ruku_number')) {
      context.handle(
        _surahRukuNumberMeta,
        surahRukuNumber.isAcceptableOrUnknown(
          data['surah_ruku_number']!,
          _surahRukuNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahRukuNumberMeta);
    }
    if (data.containsKey('verses_count')) {
      context.handle(
        _versesCountMeta,
        versesCount.isAcceptableOrUnknown(
          data['verses_count']!,
          _versesCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_versesCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rukuNumber};
  @override
  RukuRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RukuRow(
      rukuNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ruku_number'],
      )!,
      surahRukuNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_ruku_number'],
      )!,
      versesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verses_count'],
      )!,
      firstVerseKey: $RukusTable.$converterfirstVerseKey.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}first_verse_key'],
        )!,
      ),
      lastVerseKey: $RukusTable.$converterlastVerseKey.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}last_verse_key'],
        )!,
      ),
      verseMapping: $RukusTable.$converterverseMapping.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}verse_mapping'],
        )!,
      ),
    );
  }

  @override
  $RukusTable createAlias(String alias) {
    return $RukusTable(attachedDatabase, alias);
  }

  static TypeConverter<VerseKey, String> $converterfirstVerseKey =
      const VerseKeyConverter();
  static TypeConverter<VerseKey, String> $converterlastVerseKey =
      const VerseKeyConverter();
  static TypeConverter<SurahRanges, String> $converterverseMapping =
      const SurahRangesConverter();
}

class RukuRow extends DataClass implements Insertable<RukuRow> {
  final int rukuNumber;
  final int surahRukuNumber;
  final int versesCount;
  final VerseKey firstVerseKey;
  final VerseKey lastVerseKey;
  final SurahRanges verseMapping;
  const RukuRow({
    required this.rukuNumber,
    required this.surahRukuNumber,
    required this.versesCount,
    required this.firstVerseKey,
    required this.lastVerseKey,
    required this.verseMapping,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ruku_number'] = Variable<int>(rukuNumber);
    map['surah_ruku_number'] = Variable<int>(surahRukuNumber);
    map['verses_count'] = Variable<int>(versesCount);
    {
      map['first_verse_key'] = Variable<String>(
        $RukusTable.$converterfirstVerseKey.toSql(firstVerseKey),
      );
    }
    {
      map['last_verse_key'] = Variable<String>(
        $RukusTable.$converterlastVerseKey.toSql(lastVerseKey),
      );
    }
    {
      map['verse_mapping'] = Variable<String>(
        $RukusTable.$converterverseMapping.toSql(verseMapping),
      );
    }
    return map;
  }

  RukusCompanion toCompanion(bool nullToAbsent) {
    return RukusCompanion(
      rukuNumber: Value(rukuNumber),
      surahRukuNumber: Value(surahRukuNumber),
      versesCount: Value(versesCount),
      firstVerseKey: Value(firstVerseKey),
      lastVerseKey: Value(lastVerseKey),
      verseMapping: Value(verseMapping),
    );
  }

  factory RukuRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RukuRow(
      rukuNumber: serializer.fromJson<int>(json['rukuNumber']),
      surahRukuNumber: serializer.fromJson<int>(json['surahRukuNumber']),
      versesCount: serializer.fromJson<int>(json['versesCount']),
      firstVerseKey: serializer.fromJson<VerseKey>(json['firstVerseKey']),
      lastVerseKey: serializer.fromJson<VerseKey>(json['lastVerseKey']),
      verseMapping: serializer.fromJson<SurahRanges>(json['verseMapping']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rukuNumber': serializer.toJson<int>(rukuNumber),
      'surahRukuNumber': serializer.toJson<int>(surahRukuNumber),
      'versesCount': serializer.toJson<int>(versesCount),
      'firstVerseKey': serializer.toJson<VerseKey>(firstVerseKey),
      'lastVerseKey': serializer.toJson<VerseKey>(lastVerseKey),
      'verseMapping': serializer.toJson<SurahRanges>(verseMapping),
    };
  }

  RukuRow copyWith({
    int? rukuNumber,
    int? surahRukuNumber,
    int? versesCount,
    VerseKey? firstVerseKey,
    VerseKey? lastVerseKey,
    SurahRanges? verseMapping,
  }) => RukuRow(
    rukuNumber: rukuNumber ?? this.rukuNumber,
    surahRukuNumber: surahRukuNumber ?? this.surahRukuNumber,
    versesCount: versesCount ?? this.versesCount,
    firstVerseKey: firstVerseKey ?? this.firstVerseKey,
    lastVerseKey: lastVerseKey ?? this.lastVerseKey,
    verseMapping: verseMapping ?? this.verseMapping,
  );
  RukuRow copyWithCompanion(RukusCompanion data) {
    return RukuRow(
      rukuNumber: data.rukuNumber.present
          ? data.rukuNumber.value
          : this.rukuNumber,
      surahRukuNumber: data.surahRukuNumber.present
          ? data.surahRukuNumber.value
          : this.surahRukuNumber,
      versesCount: data.versesCount.present
          ? data.versesCount.value
          : this.versesCount,
      firstVerseKey: data.firstVerseKey.present
          ? data.firstVerseKey.value
          : this.firstVerseKey,
      lastVerseKey: data.lastVerseKey.present
          ? data.lastVerseKey.value
          : this.lastVerseKey,
      verseMapping: data.verseMapping.present
          ? data.verseMapping.value
          : this.verseMapping,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RukuRow(')
          ..write('rukuNumber: $rukuNumber, ')
          ..write('surahRukuNumber: $surahRukuNumber, ')
          ..write('versesCount: $versesCount, ')
          ..write('firstVerseKey: $firstVerseKey, ')
          ..write('lastVerseKey: $lastVerseKey, ')
          ..write('verseMapping: $verseMapping')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    rukuNumber,
    surahRukuNumber,
    versesCount,
    firstVerseKey,
    lastVerseKey,
    verseMapping,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RukuRow &&
          other.rukuNumber == this.rukuNumber &&
          other.surahRukuNumber == this.surahRukuNumber &&
          other.versesCount == this.versesCount &&
          other.firstVerseKey == this.firstVerseKey &&
          other.lastVerseKey == this.lastVerseKey &&
          other.verseMapping == this.verseMapping);
}

class RukusCompanion extends UpdateCompanion<RukuRow> {
  final Value<int> rukuNumber;
  final Value<int> surahRukuNumber;
  final Value<int> versesCount;
  final Value<VerseKey> firstVerseKey;
  final Value<VerseKey> lastVerseKey;
  final Value<SurahRanges> verseMapping;
  const RukusCompanion({
    this.rukuNumber = const Value.absent(),
    this.surahRukuNumber = const Value.absent(),
    this.versesCount = const Value.absent(),
    this.firstVerseKey = const Value.absent(),
    this.lastVerseKey = const Value.absent(),
    this.verseMapping = const Value.absent(),
  });
  RukusCompanion.insert({
    this.rukuNumber = const Value.absent(),
    required int surahRukuNumber,
    required int versesCount,
    required VerseKey firstVerseKey,
    required VerseKey lastVerseKey,
    required SurahRanges verseMapping,
  }) : surahRukuNumber = Value(surahRukuNumber),
       versesCount = Value(versesCount),
       firstVerseKey = Value(firstVerseKey),
       lastVerseKey = Value(lastVerseKey),
       verseMapping = Value(verseMapping);
  static Insertable<RukuRow> custom({
    Expression<int>? rukuNumber,
    Expression<int>? surahRukuNumber,
    Expression<int>? versesCount,
    Expression<String>? firstVerseKey,
    Expression<String>? lastVerseKey,
    Expression<String>? verseMapping,
  }) {
    return RawValuesInsertable({
      if (rukuNumber != null) 'ruku_number': rukuNumber,
      if (surahRukuNumber != null) 'surah_ruku_number': surahRukuNumber,
      if (versesCount != null) 'verses_count': versesCount,
      if (firstVerseKey != null) 'first_verse_key': firstVerseKey,
      if (lastVerseKey != null) 'last_verse_key': lastVerseKey,
      if (verseMapping != null) 'verse_mapping': verseMapping,
    });
  }

  RukusCompanion copyWith({
    Value<int>? rukuNumber,
    Value<int>? surahRukuNumber,
    Value<int>? versesCount,
    Value<VerseKey>? firstVerseKey,
    Value<VerseKey>? lastVerseKey,
    Value<SurahRanges>? verseMapping,
  }) {
    return RukusCompanion(
      rukuNumber: rukuNumber ?? this.rukuNumber,
      surahRukuNumber: surahRukuNumber ?? this.surahRukuNumber,
      versesCount: versesCount ?? this.versesCount,
      firstVerseKey: firstVerseKey ?? this.firstVerseKey,
      lastVerseKey: lastVerseKey ?? this.lastVerseKey,
      verseMapping: verseMapping ?? this.verseMapping,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rukuNumber.present) {
      map['ruku_number'] = Variable<int>(rukuNumber.value);
    }
    if (surahRukuNumber.present) {
      map['surah_ruku_number'] = Variable<int>(surahRukuNumber.value);
    }
    if (versesCount.present) {
      map['verses_count'] = Variable<int>(versesCount.value);
    }
    if (firstVerseKey.present) {
      map['first_verse_key'] = Variable<String>(
        $RukusTable.$converterfirstVerseKey.toSql(firstVerseKey.value),
      );
    }
    if (lastVerseKey.present) {
      map['last_verse_key'] = Variable<String>(
        $RukusTable.$converterlastVerseKey.toSql(lastVerseKey.value),
      );
    }
    if (verseMapping.present) {
      map['verse_mapping'] = Variable<String>(
        $RukusTable.$converterverseMapping.toSql(verseMapping.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RukusCompanion(')
          ..write('rukuNumber: $rukuNumber, ')
          ..write('surahRukuNumber: $surahRukuNumber, ')
          ..write('versesCount: $versesCount, ')
          ..write('firstVerseKey: $firstVerseKey, ')
          ..write('lastVerseKey: $lastVerseKey, ')
          ..write('verseMapping: $verseMapping')
          ..write(')'))
        .toString();
  }
}

class $SajdahsTable extends Sajdahs with TableInfo<$SajdahsTable, SajdahRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SajdahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sajdahNumberMeta = const VerificationMeta(
    'sajdahNumber',
  );
  @override
  late final GeneratedColumn<int> sajdahNumber = GeneratedColumn<int>(
    'sajdah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<VerseKey, String> verseKey =
      GeneratedColumn<String>(
        'verse_key',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VerseKey>($SajdahsTable.$converterverseKey);
  @override
  late final GeneratedColumnWithTypeConverter<SajdahType, String> sajdahType =
      GeneratedColumn<String>(
        'sajdah_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SajdahType>($SajdahsTable.$convertersajdahType);
  @override
  List<GeneratedColumn> get $columns => [sajdahNumber, verseKey, sajdahType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sajdahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SajdahRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sajdah_number')) {
      context.handle(
        _sajdahNumberMeta,
        sajdahNumber.isAcceptableOrUnknown(
          data['sajdah_number']!,
          _sajdahNumberMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sajdahNumber};
  @override
  SajdahRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SajdahRow(
      sajdahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sajdah_number'],
      )!,
      verseKey: $SajdahsTable.$converterverseKey.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}verse_key'],
        )!,
      ),
      sajdahType: $SajdahsTable.$convertersajdahType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sajdah_type'],
        )!,
      ),
    );
  }

  @override
  $SajdahsTable createAlias(String alias) {
    return $SajdahsTable(attachedDatabase, alias);
  }

  static TypeConverter<VerseKey, String> $converterverseKey =
      const VerseKeyConverter();
  static TypeConverter<SajdahType, String> $convertersajdahType =
      const SajdahTypeConverter();
}

class SajdahRow extends DataClass implements Insertable<SajdahRow> {
  final int sajdahNumber;
  final VerseKey verseKey;
  final SajdahType sajdahType;
  const SajdahRow({
    required this.sajdahNumber,
    required this.verseKey,
    required this.sajdahType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sajdah_number'] = Variable<int>(sajdahNumber);
    {
      map['verse_key'] = Variable<String>(
        $SajdahsTable.$converterverseKey.toSql(verseKey),
      );
    }
    {
      map['sajdah_type'] = Variable<String>(
        $SajdahsTable.$convertersajdahType.toSql(sajdahType),
      );
    }
    return map;
  }

  SajdahsCompanion toCompanion(bool nullToAbsent) {
    return SajdahsCompanion(
      sajdahNumber: Value(sajdahNumber),
      verseKey: Value(verseKey),
      sajdahType: Value(sajdahType),
    );
  }

  factory SajdahRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SajdahRow(
      sajdahNumber: serializer.fromJson<int>(json['sajdahNumber']),
      verseKey: serializer.fromJson<VerseKey>(json['verseKey']),
      sajdahType: serializer.fromJson<SajdahType>(json['sajdahType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sajdahNumber': serializer.toJson<int>(sajdahNumber),
      'verseKey': serializer.toJson<VerseKey>(verseKey),
      'sajdahType': serializer.toJson<SajdahType>(sajdahType),
    };
  }

  SajdahRow copyWith({
    int? sajdahNumber,
    VerseKey? verseKey,
    SajdahType? sajdahType,
  }) => SajdahRow(
    sajdahNumber: sajdahNumber ?? this.sajdahNumber,
    verseKey: verseKey ?? this.verseKey,
    sajdahType: sajdahType ?? this.sajdahType,
  );
  SajdahRow copyWithCompanion(SajdahsCompanion data) {
    return SajdahRow(
      sajdahNumber: data.sajdahNumber.present
          ? data.sajdahNumber.value
          : this.sajdahNumber,
      verseKey: data.verseKey.present ? data.verseKey.value : this.verseKey,
      sajdahType: data.sajdahType.present
          ? data.sajdahType.value
          : this.sajdahType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SajdahRow(')
          ..write('sajdahNumber: $sajdahNumber, ')
          ..write('verseKey: $verseKey, ')
          ..write('sajdahType: $sajdahType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sajdahNumber, verseKey, sajdahType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SajdahRow &&
          other.sajdahNumber == this.sajdahNumber &&
          other.verseKey == this.verseKey &&
          other.sajdahType == this.sajdahType);
}

class SajdahsCompanion extends UpdateCompanion<SajdahRow> {
  final Value<int> sajdahNumber;
  final Value<VerseKey> verseKey;
  final Value<SajdahType> sajdahType;
  const SajdahsCompanion({
    this.sajdahNumber = const Value.absent(),
    this.verseKey = const Value.absent(),
    this.sajdahType = const Value.absent(),
  });
  SajdahsCompanion.insert({
    this.sajdahNumber = const Value.absent(),
    required VerseKey verseKey,
    required SajdahType sajdahType,
  }) : verseKey = Value(verseKey),
       sajdahType = Value(sajdahType);
  static Insertable<SajdahRow> custom({
    Expression<int>? sajdahNumber,
    Expression<String>? verseKey,
    Expression<String>? sajdahType,
  }) {
    return RawValuesInsertable({
      if (sajdahNumber != null) 'sajdah_number': sajdahNumber,
      if (verseKey != null) 'verse_key': verseKey,
      if (sajdahType != null) 'sajdah_type': sajdahType,
    });
  }

  SajdahsCompanion copyWith({
    Value<int>? sajdahNumber,
    Value<VerseKey>? verseKey,
    Value<SajdahType>? sajdahType,
  }) {
    return SajdahsCompanion(
      sajdahNumber: sajdahNumber ?? this.sajdahNumber,
      verseKey: verseKey ?? this.verseKey,
      sajdahType: sajdahType ?? this.sajdahType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sajdahNumber.present) {
      map['sajdah_number'] = Variable<int>(sajdahNumber.value);
    }
    if (verseKey.present) {
      map['verse_key'] = Variable<String>(
        $SajdahsTable.$converterverseKey.toSql(verseKey.value),
      );
    }
    if (sajdahType.present) {
      map['sajdah_type'] = Variable<String>(
        $SajdahsTable.$convertersajdahType.toSql(sajdahType.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SajdahsCompanion(')
          ..write('sajdahNumber: $sajdahNumber, ')
          ..write('verseKey: $verseKey, ')
          ..write('sajdahType: $sajdahType')
          ..write(')'))
        .toString();
  }
}

class $AyahMetasTable extends AyahMetas
    with TableInfo<$AyahMetasTable, AyahMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AyahMetasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _surahMeta = const VerificationMeta('surah');
  @override
  late final GeneratedColumn<int> surah = GeneratedColumn<int>(
    'surah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahMeta = const VerificationMeta('ayah');
  @override
  late final GeneratedColumn<int> ayah = GeneratedColumn<int>(
    'ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _globalIndexMeta = const VerificationMeta(
    'globalIndex',
  );
  @override
  late final GeneratedColumn<int> globalIndex = GeneratedColumn<int>(
    'global_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageNoMeta = const VerificationMeta('pageNo');
  @override
  late final GeneratedColumn<int> pageNo = GeneratedColumn<int>(
    'page_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _juzNoMeta = const VerificationMeta('juzNo');
  @override
  late final GeneratedColumn<int> juzNo = GeneratedColumn<int>(
    'juz_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hizbNoMeta = const VerificationMeta('hizbNo');
  @override
  late final GeneratedColumn<int> hizbNo = GeneratedColumn<int>(
    'hizb_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rukuNoMeta = const VerificationMeta('rukuNo');
  @override
  late final GeneratedColumn<int> rukuNo = GeneratedColumn<int>(
    'ruku_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<HizbFraction, int> hizbFraction =
      GeneratedColumn<int>(
        'hizb_fraction',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<HizbFraction>($AyahMetasTable.$converterhizbFraction);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surah,
    ayah,
    globalIndex,
    pageNo,
    juzNo,
    hizbNo,
    rukuNo,
    hizbFraction,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ayah_metas';
  @override
  VerificationContext validateIntegrity(
    Insertable<AyahMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah')) {
      context.handle(
        _surahMeta,
        surah.isAcceptableOrUnknown(data['surah']!, _surahMeta),
      );
    } else if (isInserting) {
      context.missing(_surahMeta);
    }
    if (data.containsKey('ayah')) {
      context.handle(
        _ayahMeta,
        ayah.isAcceptableOrUnknown(data['ayah']!, _ayahMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahMeta);
    }
    if (data.containsKey('global_index')) {
      context.handle(
        _globalIndexMeta,
        globalIndex.isAcceptableOrUnknown(
          data['global_index']!,
          _globalIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_globalIndexMeta);
    }
    if (data.containsKey('page_no')) {
      context.handle(
        _pageNoMeta,
        pageNo.isAcceptableOrUnknown(data['page_no']!, _pageNoMeta),
      );
    } else if (isInserting) {
      context.missing(_pageNoMeta);
    }
    if (data.containsKey('juz_no')) {
      context.handle(
        _juzNoMeta,
        juzNo.isAcceptableOrUnknown(data['juz_no']!, _juzNoMeta),
      );
    } else if (isInserting) {
      context.missing(_juzNoMeta);
    }
    if (data.containsKey('hizb_no')) {
      context.handle(
        _hizbNoMeta,
        hizbNo.isAcceptableOrUnknown(data['hizb_no']!, _hizbNoMeta),
      );
    } else if (isInserting) {
      context.missing(_hizbNoMeta);
    }
    if (data.containsKey('ruku_no')) {
      context.handle(
        _rukuNoMeta,
        rukuNo.isAcceptableOrUnknown(data['ruku_no']!, _rukuNoMeta),
      );
    } else if (isInserting) {
      context.missing(_rukuNoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AyahMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AyahMetaRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      surah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah'],
      )!,
      ayah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah'],
      )!,
      globalIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}global_index'],
      )!,
      pageNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_no'],
      )!,
      juzNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}juz_no'],
      )!,
      hizbNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hizb_no'],
      )!,
      rukuNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ruku_no'],
      )!,
      hizbFraction: $AyahMetasTable.$converterhizbFraction.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}hizb_fraction'],
        )!,
      ),
    );
  }

  @override
  $AyahMetasTable createAlias(String alias) {
    return $AyahMetasTable(attachedDatabase, alias);
  }

  static TypeConverter<HizbFraction, int> $converterhizbFraction =
      const HizbFractionConverter();
}

class AyahMetaRow extends DataClass implements Insertable<AyahMetaRow> {
  final int id;
  final int surah;
  final int ayah;
  final int globalIndex;
  final int pageNo;
  final int juzNo;
  final int hizbNo;
  final int rukuNo;
  final HizbFraction hizbFraction;
  const AyahMetaRow({
    required this.id,
    required this.surah,
    required this.ayah,
    required this.globalIndex,
    required this.pageNo,
    required this.juzNo,
    required this.hizbNo,
    required this.rukuNo,
    required this.hizbFraction,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah'] = Variable<int>(surah);
    map['ayah'] = Variable<int>(ayah);
    map['global_index'] = Variable<int>(globalIndex);
    map['page_no'] = Variable<int>(pageNo);
    map['juz_no'] = Variable<int>(juzNo);
    map['hizb_no'] = Variable<int>(hizbNo);
    map['ruku_no'] = Variable<int>(rukuNo);
    {
      map['hizb_fraction'] = Variable<int>(
        $AyahMetasTable.$converterhizbFraction.toSql(hizbFraction),
      );
    }
    return map;
  }

  AyahMetasCompanion toCompanion(bool nullToAbsent) {
    return AyahMetasCompanion(
      id: Value(id),
      surah: Value(surah),
      ayah: Value(ayah),
      globalIndex: Value(globalIndex),
      pageNo: Value(pageNo),
      juzNo: Value(juzNo),
      hizbNo: Value(hizbNo),
      rukuNo: Value(rukuNo),
      hizbFraction: Value(hizbFraction),
    );
  }

  factory AyahMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AyahMetaRow(
      id: serializer.fromJson<int>(json['id']),
      surah: serializer.fromJson<int>(json['surah']),
      ayah: serializer.fromJson<int>(json['ayah']),
      globalIndex: serializer.fromJson<int>(json['globalIndex']),
      pageNo: serializer.fromJson<int>(json['pageNo']),
      juzNo: serializer.fromJson<int>(json['juzNo']),
      hizbNo: serializer.fromJson<int>(json['hizbNo']),
      rukuNo: serializer.fromJson<int>(json['rukuNo']),
      hizbFraction: serializer.fromJson<HizbFraction>(json['hizbFraction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surah': serializer.toJson<int>(surah),
      'ayah': serializer.toJson<int>(ayah),
      'globalIndex': serializer.toJson<int>(globalIndex),
      'pageNo': serializer.toJson<int>(pageNo),
      'juzNo': serializer.toJson<int>(juzNo),
      'hizbNo': serializer.toJson<int>(hizbNo),
      'rukuNo': serializer.toJson<int>(rukuNo),
      'hizbFraction': serializer.toJson<HizbFraction>(hizbFraction),
    };
  }

  AyahMetaRow copyWith({
    int? id,
    int? surah,
    int? ayah,
    int? globalIndex,
    int? pageNo,
    int? juzNo,
    int? hizbNo,
    int? rukuNo,
    HizbFraction? hizbFraction,
  }) => AyahMetaRow(
    id: id ?? this.id,
    surah: surah ?? this.surah,
    ayah: ayah ?? this.ayah,
    globalIndex: globalIndex ?? this.globalIndex,
    pageNo: pageNo ?? this.pageNo,
    juzNo: juzNo ?? this.juzNo,
    hizbNo: hizbNo ?? this.hizbNo,
    rukuNo: rukuNo ?? this.rukuNo,
    hizbFraction: hizbFraction ?? this.hizbFraction,
  );
  AyahMetaRow copyWithCompanion(AyahMetasCompanion data) {
    return AyahMetaRow(
      id: data.id.present ? data.id.value : this.id,
      surah: data.surah.present ? data.surah.value : this.surah,
      ayah: data.ayah.present ? data.ayah.value : this.ayah,
      globalIndex: data.globalIndex.present
          ? data.globalIndex.value
          : this.globalIndex,
      pageNo: data.pageNo.present ? data.pageNo.value : this.pageNo,
      juzNo: data.juzNo.present ? data.juzNo.value : this.juzNo,
      hizbNo: data.hizbNo.present ? data.hizbNo.value : this.hizbNo,
      rukuNo: data.rukuNo.present ? data.rukuNo.value : this.rukuNo,
      hizbFraction: data.hizbFraction.present
          ? data.hizbFraction.value
          : this.hizbFraction,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AyahMetaRow(')
          ..write('id: $id, ')
          ..write('surah: $surah, ')
          ..write('ayah: $ayah, ')
          ..write('globalIndex: $globalIndex, ')
          ..write('pageNo: $pageNo, ')
          ..write('juzNo: $juzNo, ')
          ..write('hizbNo: $hizbNo, ')
          ..write('rukuNo: $rukuNo, ')
          ..write('hizbFraction: $hizbFraction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    surah,
    ayah,
    globalIndex,
    pageNo,
    juzNo,
    hizbNo,
    rukuNo,
    hizbFraction,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AyahMetaRow &&
          other.id == this.id &&
          other.surah == this.surah &&
          other.ayah == this.ayah &&
          other.globalIndex == this.globalIndex &&
          other.pageNo == this.pageNo &&
          other.juzNo == this.juzNo &&
          other.hizbNo == this.hizbNo &&
          other.rukuNo == this.rukuNo &&
          other.hizbFraction == this.hizbFraction);
}

class AyahMetasCompanion extends UpdateCompanion<AyahMetaRow> {
  final Value<int> id;
  final Value<int> surah;
  final Value<int> ayah;
  final Value<int> globalIndex;
  final Value<int> pageNo;
  final Value<int> juzNo;
  final Value<int> hizbNo;
  final Value<int> rukuNo;
  final Value<HizbFraction> hizbFraction;
  const AyahMetasCompanion({
    this.id = const Value.absent(),
    this.surah = const Value.absent(),
    this.ayah = const Value.absent(),
    this.globalIndex = const Value.absent(),
    this.pageNo = const Value.absent(),
    this.juzNo = const Value.absent(),
    this.hizbNo = const Value.absent(),
    this.rukuNo = const Value.absent(),
    this.hizbFraction = const Value.absent(),
  });
  AyahMetasCompanion.insert({
    this.id = const Value.absent(),
    required int surah,
    required int ayah,
    required int globalIndex,
    required int pageNo,
    required int juzNo,
    required int hizbNo,
    required int rukuNo,
    required HizbFraction hizbFraction,
  }) : surah = Value(surah),
       ayah = Value(ayah),
       globalIndex = Value(globalIndex),
       pageNo = Value(pageNo),
       juzNo = Value(juzNo),
       hizbNo = Value(hizbNo),
       rukuNo = Value(rukuNo),
       hizbFraction = Value(hizbFraction);
  static Insertable<AyahMetaRow> custom({
    Expression<int>? id,
    Expression<int>? surah,
    Expression<int>? ayah,
    Expression<int>? globalIndex,
    Expression<int>? pageNo,
    Expression<int>? juzNo,
    Expression<int>? hizbNo,
    Expression<int>? rukuNo,
    Expression<int>? hizbFraction,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surah != null) 'surah': surah,
      if (ayah != null) 'ayah': ayah,
      if (globalIndex != null) 'global_index': globalIndex,
      if (pageNo != null) 'page_no': pageNo,
      if (juzNo != null) 'juz_no': juzNo,
      if (hizbNo != null) 'hizb_no': hizbNo,
      if (rukuNo != null) 'ruku_no': rukuNo,
      if (hizbFraction != null) 'hizb_fraction': hizbFraction,
    });
  }

  AyahMetasCompanion copyWith({
    Value<int>? id,
    Value<int>? surah,
    Value<int>? ayah,
    Value<int>? globalIndex,
    Value<int>? pageNo,
    Value<int>? juzNo,
    Value<int>? hizbNo,
    Value<int>? rukuNo,
    Value<HizbFraction>? hizbFraction,
  }) {
    return AyahMetasCompanion(
      id: id ?? this.id,
      surah: surah ?? this.surah,
      ayah: ayah ?? this.ayah,
      globalIndex: globalIndex ?? this.globalIndex,
      pageNo: pageNo ?? this.pageNo,
      juzNo: juzNo ?? this.juzNo,
      hizbNo: hizbNo ?? this.hizbNo,
      rukuNo: rukuNo ?? this.rukuNo,
      hizbFraction: hizbFraction ?? this.hizbFraction,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surah.present) {
      map['surah'] = Variable<int>(surah.value);
    }
    if (ayah.present) {
      map['ayah'] = Variable<int>(ayah.value);
    }
    if (globalIndex.present) {
      map['global_index'] = Variable<int>(globalIndex.value);
    }
    if (pageNo.present) {
      map['page_no'] = Variable<int>(pageNo.value);
    }
    if (juzNo.present) {
      map['juz_no'] = Variable<int>(juzNo.value);
    }
    if (hizbNo.present) {
      map['hizb_no'] = Variable<int>(hizbNo.value);
    }
    if (rukuNo.present) {
      map['ruku_no'] = Variable<int>(rukuNo.value);
    }
    if (hizbFraction.present) {
      map['hizb_fraction'] = Variable<int>(
        $AyahMetasTable.$converterhizbFraction.toSql(hizbFraction.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AyahMetasCompanion(')
          ..write('id: $id, ')
          ..write('surah: $surah, ')
          ..write('ayah: $ayah, ')
          ..write('globalIndex: $globalIndex, ')
          ..write('pageNo: $pageNo, ')
          ..write('juzNo: $juzNo, ')
          ..write('hizbNo: $hizbNo, ')
          ..write('rukuNo: $rukuNo, ')
          ..write('hizbFraction: $hizbFraction')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WordsTable words = $WordsTable(this);
  late final $ChaptersTable chapters = $ChaptersTable(this);
  late final $HizbsTable hizbs = $HizbsTable(this);
  late final $JuzsTable juzs = $JuzsTable(this);
  late final $RukusTable rukus = $RukusTable(this);
  late final $SajdahsTable sajdahs = $SajdahsTable(this);
  late final $AyahMetasTable ayahMetas = $AyahMetasTable(this);
  late final QuranDao quranDao = QuranDao(this as AppDatabase);
  late final AyahMetaDao ayahMetaDao = AyahMetaDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    words,
    chapters,
    hizbs,
    juzs,
    rukus,
    sajdahs,
    ayahMetas,
  ];
}

typedef $$WordsTableCreateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      required WordLocation location,
      required int surah,
      required int ayah,
      required int word,
      required String text_,
    });
typedef $$WordsTableUpdateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      Value<WordLocation> location,
      Value<int> surah,
      Value<int> ayah,
      Value<int> word,
      Value<String> text_,
    });

class $$WordsTableFilterComposer extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WordLocation, WordLocation, String>
  get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get surah => $composableBuilder(
    column: $table.surah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayah => $composableBuilder(
    column: $table.ayah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get text_ => $composableBuilder(
    column: $table.text_,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surah => $composableBuilder(
    column: $table.surah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayah => $composableBuilder(
    column: $table.ayah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get text_ => $composableBuilder(
    column: $table.text_,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WordLocation, String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<int> get surah =>
      $composableBuilder(column: $table.surah, builder: (column) => column);

  GeneratedColumn<int> get ayah =>
      $composableBuilder(column: $table.ayah, builder: (column) => column);

  GeneratedColumn<int> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get text_ =>
      $composableBuilder(column: $table.text_, builder: (column) => column);
}

class $$WordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordsTable,
          WordRow,
          $$WordsTableFilterComposer,
          $$WordsTableOrderingComposer,
          $$WordsTableAnnotationComposer,
          $$WordsTableCreateCompanionBuilder,
          $$WordsTableUpdateCompanionBuilder,
          (WordRow, BaseReferences<_$AppDatabase, $WordsTable, WordRow>),
          WordRow,
          PrefetchHooks Function()
        > {
  $$WordsTableTableManager(_$AppDatabase db, $WordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<WordLocation> location = const Value.absent(),
                Value<int> surah = const Value.absent(),
                Value<int> ayah = const Value.absent(),
                Value<int> word = const Value.absent(),
                Value<String> text_ = const Value.absent(),
              }) => WordsCompanion(
                id: id,
                location: location,
                surah: surah,
                ayah: ayah,
                word: word,
                text_: text_,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required WordLocation location,
                required int surah,
                required int ayah,
                required int word,
                required String text_,
              }) => WordsCompanion.insert(
                id: id,
                location: location,
                surah: surah,
                ayah: ayah,
                word: word,
                text_: text_,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordsTable,
      WordRow,
      $$WordsTableFilterComposer,
      $$WordsTableOrderingComposer,
      $$WordsTableAnnotationComposer,
      $$WordsTableCreateCompanionBuilder,
      $$WordsTableUpdateCompanionBuilder,
      (WordRow, BaseReferences<_$AppDatabase, $WordsTable, WordRow>),
      WordRow,
      PrefetchHooks Function()
    >;
typedef $$ChaptersTableCreateCompanionBuilder =
    ChaptersCompanion Function({
      Value<int> id,
      required String name,
      required String nameSimple,
      required String nameArabic,
      required int revelationOrder,
      required RevelationPlace revelationPlace,
      required int versesCount,
      required bool bismillahPre,
      required String nameGlyph,
    });
typedef $$ChaptersTableUpdateCompanionBuilder =
    ChaptersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> nameSimple,
      Value<String> nameArabic,
      Value<int> revelationOrder,
      Value<RevelationPlace> revelationPlace,
      Value<int> versesCount,
      Value<bool> bismillahPre,
      Value<String> nameGlyph,
    });

class $$ChaptersTableFilterComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameSimple => $composableBuilder(
    column: $table.nameSimple,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revelationOrder => $composableBuilder(
    column: $table.revelationOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RevelationPlace, RevelationPlace, String>
  get revelationPlace => $composableBuilder(
    column: $table.revelationPlace,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<bool, bool, int> get bismillahPre =>
      $composableBuilder(
        column: $table.bismillahPre,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get nameGlyph => $composableBuilder(
    column: $table.nameGlyph,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChaptersTableOrderingComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameSimple => $composableBuilder(
    column: $table.nameSimple,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revelationOrder => $composableBuilder(
    column: $table.revelationOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get revelationPlace => $composableBuilder(
    column: $table.revelationPlace,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bismillahPre => $composableBuilder(
    column: $table.bismillahPre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameGlyph => $composableBuilder(
    column: $table.nameGlyph,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChaptersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameSimple => $composableBuilder(
    column: $table.nameSimple,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => column,
  );

  GeneratedColumn<int> get revelationOrder => $composableBuilder(
    column: $table.revelationOrder,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<RevelationPlace, String>
  get revelationPlace => $composableBuilder(
    column: $table.revelationPlace,
    builder: (column) => column,
  );

  GeneratedColumn<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<bool, int> get bismillahPre =>
      $composableBuilder(
        column: $table.bismillahPre,
        builder: (column) => column,
      );

  GeneratedColumn<String> get nameGlyph =>
      $composableBuilder(column: $table.nameGlyph, builder: (column) => column);
}

class $$ChaptersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChaptersTable,
          ChapterRow,
          $$ChaptersTableFilterComposer,
          $$ChaptersTableOrderingComposer,
          $$ChaptersTableAnnotationComposer,
          $$ChaptersTableCreateCompanionBuilder,
          $$ChaptersTableUpdateCompanionBuilder,
          (
            ChapterRow,
            BaseReferences<_$AppDatabase, $ChaptersTable, ChapterRow>,
          ),
          ChapterRow,
          PrefetchHooks Function()
        > {
  $$ChaptersTableTableManager(_$AppDatabase db, $ChaptersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChaptersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChaptersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChaptersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> nameSimple = const Value.absent(),
                Value<String> nameArabic = const Value.absent(),
                Value<int> revelationOrder = const Value.absent(),
                Value<RevelationPlace> revelationPlace = const Value.absent(),
                Value<int> versesCount = const Value.absent(),
                Value<bool> bismillahPre = const Value.absent(),
                Value<String> nameGlyph = const Value.absent(),
              }) => ChaptersCompanion(
                id: id,
                name: name,
                nameSimple: nameSimple,
                nameArabic: nameArabic,
                revelationOrder: revelationOrder,
                revelationPlace: revelationPlace,
                versesCount: versesCount,
                bismillahPre: bismillahPre,
                nameGlyph: nameGlyph,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String nameSimple,
                required String nameArabic,
                required int revelationOrder,
                required RevelationPlace revelationPlace,
                required int versesCount,
                required bool bismillahPre,
                required String nameGlyph,
              }) => ChaptersCompanion.insert(
                id: id,
                name: name,
                nameSimple: nameSimple,
                nameArabic: nameArabic,
                revelationOrder: revelationOrder,
                revelationPlace: revelationPlace,
                versesCount: versesCount,
                bismillahPre: bismillahPre,
                nameGlyph: nameGlyph,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChaptersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChaptersTable,
      ChapterRow,
      $$ChaptersTableFilterComposer,
      $$ChaptersTableOrderingComposer,
      $$ChaptersTableAnnotationComposer,
      $$ChaptersTableCreateCompanionBuilder,
      $$ChaptersTableUpdateCompanionBuilder,
      (ChapterRow, BaseReferences<_$AppDatabase, $ChaptersTable, ChapterRow>),
      ChapterRow,
      PrefetchHooks Function()
    >;
typedef $$HizbsTableCreateCompanionBuilder =
    HizbsCompanion Function({
      Value<int> hizbNumber,
      required int versesCount,
      required VerseKey firstVerseKey,
      required VerseKey lastVerseKey,
      required SurahRanges verseMapping,
    });
typedef $$HizbsTableUpdateCompanionBuilder =
    HizbsCompanion Function({
      Value<int> hizbNumber,
      Value<int> versesCount,
      Value<VerseKey> firstVerseKey,
      Value<VerseKey> lastVerseKey,
      Value<SurahRanges> verseMapping,
    });

class $$HizbsTableFilterComposer extends Composer<_$AppDatabase, $HizbsTable> {
  $$HizbsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get hizbNumber => $composableBuilder(
    column: $table.hizbNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VerseKey, VerseKey, String>
  get firstVerseKey => $composableBuilder(
    column: $table.firstVerseKey,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<VerseKey, VerseKey, String> get lastVerseKey =>
      $composableBuilder(
        column: $table.lastVerseKey,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<SurahRanges, SurahRanges, String>
  get verseMapping => $composableBuilder(
    column: $table.verseMapping,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$HizbsTableOrderingComposer
    extends Composer<_$AppDatabase, $HizbsTable> {
  $$HizbsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get hizbNumber => $composableBuilder(
    column: $table.hizbNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstVerseKey => $composableBuilder(
    column: $table.firstVerseKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastVerseKey => $composableBuilder(
    column: $table.lastVerseKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verseMapping => $composableBuilder(
    column: $table.verseMapping,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HizbsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HizbsTable> {
  $$HizbsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get hizbNumber => $composableBuilder(
    column: $table.hizbNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<VerseKey, String> get firstVerseKey =>
      $composableBuilder(
        column: $table.firstVerseKey,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<VerseKey, String> get lastVerseKey =>
      $composableBuilder(
        column: $table.lastVerseKey,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<SurahRanges, String> get verseMapping =>
      $composableBuilder(
        column: $table.verseMapping,
        builder: (column) => column,
      );
}

class $$HizbsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HizbsTable,
          HizbRow,
          $$HizbsTableFilterComposer,
          $$HizbsTableOrderingComposer,
          $$HizbsTableAnnotationComposer,
          $$HizbsTableCreateCompanionBuilder,
          $$HizbsTableUpdateCompanionBuilder,
          (HizbRow, BaseReferences<_$AppDatabase, $HizbsTable, HizbRow>),
          HizbRow,
          PrefetchHooks Function()
        > {
  $$HizbsTableTableManager(_$AppDatabase db, $HizbsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HizbsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HizbsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HizbsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> hizbNumber = const Value.absent(),
                Value<int> versesCount = const Value.absent(),
                Value<VerseKey> firstVerseKey = const Value.absent(),
                Value<VerseKey> lastVerseKey = const Value.absent(),
                Value<SurahRanges> verseMapping = const Value.absent(),
              }) => HizbsCompanion(
                hizbNumber: hizbNumber,
                versesCount: versesCount,
                firstVerseKey: firstVerseKey,
                lastVerseKey: lastVerseKey,
                verseMapping: verseMapping,
              ),
          createCompanionCallback:
              ({
                Value<int> hizbNumber = const Value.absent(),
                required int versesCount,
                required VerseKey firstVerseKey,
                required VerseKey lastVerseKey,
                required SurahRanges verseMapping,
              }) => HizbsCompanion.insert(
                hizbNumber: hizbNumber,
                versesCount: versesCount,
                firstVerseKey: firstVerseKey,
                lastVerseKey: lastVerseKey,
                verseMapping: verseMapping,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HizbsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HizbsTable,
      HizbRow,
      $$HizbsTableFilterComposer,
      $$HizbsTableOrderingComposer,
      $$HizbsTableAnnotationComposer,
      $$HizbsTableCreateCompanionBuilder,
      $$HizbsTableUpdateCompanionBuilder,
      (HizbRow, BaseReferences<_$AppDatabase, $HizbsTable, HizbRow>),
      HizbRow,
      PrefetchHooks Function()
    >;
typedef $$JuzsTableCreateCompanionBuilder =
    JuzsCompanion Function({
      Value<int> juzNumber,
      required int versesCount,
      required VerseKey firstVerseKey,
      required VerseKey lastVerseKey,
      required SurahRanges verseMapping,
    });
typedef $$JuzsTableUpdateCompanionBuilder =
    JuzsCompanion Function({
      Value<int> juzNumber,
      Value<int> versesCount,
      Value<VerseKey> firstVerseKey,
      Value<VerseKey> lastVerseKey,
      Value<SurahRanges> verseMapping,
    });

class $$JuzsTableFilterComposer extends Composer<_$AppDatabase, $JuzsTable> {
  $$JuzsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get juzNumber => $composableBuilder(
    column: $table.juzNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VerseKey, VerseKey, String>
  get firstVerseKey => $composableBuilder(
    column: $table.firstVerseKey,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<VerseKey, VerseKey, String> get lastVerseKey =>
      $composableBuilder(
        column: $table.lastVerseKey,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<SurahRanges, SurahRanges, String>
  get verseMapping => $composableBuilder(
    column: $table.verseMapping,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$JuzsTableOrderingComposer extends Composer<_$AppDatabase, $JuzsTable> {
  $$JuzsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get juzNumber => $composableBuilder(
    column: $table.juzNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstVerseKey => $composableBuilder(
    column: $table.firstVerseKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastVerseKey => $composableBuilder(
    column: $table.lastVerseKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verseMapping => $composableBuilder(
    column: $table.verseMapping,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JuzsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JuzsTable> {
  $$JuzsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get juzNumber =>
      $composableBuilder(column: $table.juzNumber, builder: (column) => column);

  GeneratedColumn<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<VerseKey, String> get firstVerseKey =>
      $composableBuilder(
        column: $table.firstVerseKey,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<VerseKey, String> get lastVerseKey =>
      $composableBuilder(
        column: $table.lastVerseKey,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<SurahRanges, String> get verseMapping =>
      $composableBuilder(
        column: $table.verseMapping,
        builder: (column) => column,
      );
}

class $$JuzsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JuzsTable,
          JuzRow,
          $$JuzsTableFilterComposer,
          $$JuzsTableOrderingComposer,
          $$JuzsTableAnnotationComposer,
          $$JuzsTableCreateCompanionBuilder,
          $$JuzsTableUpdateCompanionBuilder,
          (JuzRow, BaseReferences<_$AppDatabase, $JuzsTable, JuzRow>),
          JuzRow,
          PrefetchHooks Function()
        > {
  $$JuzsTableTableManager(_$AppDatabase db, $JuzsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JuzsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JuzsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JuzsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> juzNumber = const Value.absent(),
                Value<int> versesCount = const Value.absent(),
                Value<VerseKey> firstVerseKey = const Value.absent(),
                Value<VerseKey> lastVerseKey = const Value.absent(),
                Value<SurahRanges> verseMapping = const Value.absent(),
              }) => JuzsCompanion(
                juzNumber: juzNumber,
                versesCount: versesCount,
                firstVerseKey: firstVerseKey,
                lastVerseKey: lastVerseKey,
                verseMapping: verseMapping,
              ),
          createCompanionCallback:
              ({
                Value<int> juzNumber = const Value.absent(),
                required int versesCount,
                required VerseKey firstVerseKey,
                required VerseKey lastVerseKey,
                required SurahRanges verseMapping,
              }) => JuzsCompanion.insert(
                juzNumber: juzNumber,
                versesCount: versesCount,
                firstVerseKey: firstVerseKey,
                lastVerseKey: lastVerseKey,
                verseMapping: verseMapping,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JuzsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JuzsTable,
      JuzRow,
      $$JuzsTableFilterComposer,
      $$JuzsTableOrderingComposer,
      $$JuzsTableAnnotationComposer,
      $$JuzsTableCreateCompanionBuilder,
      $$JuzsTableUpdateCompanionBuilder,
      (JuzRow, BaseReferences<_$AppDatabase, $JuzsTable, JuzRow>),
      JuzRow,
      PrefetchHooks Function()
    >;
typedef $$RukusTableCreateCompanionBuilder =
    RukusCompanion Function({
      Value<int> rukuNumber,
      required int surahRukuNumber,
      required int versesCount,
      required VerseKey firstVerseKey,
      required VerseKey lastVerseKey,
      required SurahRanges verseMapping,
    });
typedef $$RukusTableUpdateCompanionBuilder =
    RukusCompanion Function({
      Value<int> rukuNumber,
      Value<int> surahRukuNumber,
      Value<int> versesCount,
      Value<VerseKey> firstVerseKey,
      Value<VerseKey> lastVerseKey,
      Value<SurahRanges> verseMapping,
    });

class $$RukusTableFilterComposer extends Composer<_$AppDatabase, $RukusTable> {
  $$RukusTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rukuNumber => $composableBuilder(
    column: $table.rukuNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahRukuNumber => $composableBuilder(
    column: $table.surahRukuNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VerseKey, VerseKey, String>
  get firstVerseKey => $composableBuilder(
    column: $table.firstVerseKey,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<VerseKey, VerseKey, String> get lastVerseKey =>
      $composableBuilder(
        column: $table.lastVerseKey,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<SurahRanges, SurahRanges, String>
  get verseMapping => $composableBuilder(
    column: $table.verseMapping,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$RukusTableOrderingComposer
    extends Composer<_$AppDatabase, $RukusTable> {
  $$RukusTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rukuNumber => $composableBuilder(
    column: $table.rukuNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahRukuNumber => $composableBuilder(
    column: $table.surahRukuNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstVerseKey => $composableBuilder(
    column: $table.firstVerseKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastVerseKey => $composableBuilder(
    column: $table.lastVerseKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verseMapping => $composableBuilder(
    column: $table.verseMapping,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RukusTableAnnotationComposer
    extends Composer<_$AppDatabase, $RukusTable> {
  $$RukusTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rukuNumber => $composableBuilder(
    column: $table.rukuNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get surahRukuNumber => $composableBuilder(
    column: $table.surahRukuNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<VerseKey, String> get firstVerseKey =>
      $composableBuilder(
        column: $table.firstVerseKey,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<VerseKey, String> get lastVerseKey =>
      $composableBuilder(
        column: $table.lastVerseKey,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<SurahRanges, String> get verseMapping =>
      $composableBuilder(
        column: $table.verseMapping,
        builder: (column) => column,
      );
}

class $$RukusTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RukusTable,
          RukuRow,
          $$RukusTableFilterComposer,
          $$RukusTableOrderingComposer,
          $$RukusTableAnnotationComposer,
          $$RukusTableCreateCompanionBuilder,
          $$RukusTableUpdateCompanionBuilder,
          (RukuRow, BaseReferences<_$AppDatabase, $RukusTable, RukuRow>),
          RukuRow,
          PrefetchHooks Function()
        > {
  $$RukusTableTableManager(_$AppDatabase db, $RukusTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RukusTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RukusTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RukusTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rukuNumber = const Value.absent(),
                Value<int> surahRukuNumber = const Value.absent(),
                Value<int> versesCount = const Value.absent(),
                Value<VerseKey> firstVerseKey = const Value.absent(),
                Value<VerseKey> lastVerseKey = const Value.absent(),
                Value<SurahRanges> verseMapping = const Value.absent(),
              }) => RukusCompanion(
                rukuNumber: rukuNumber,
                surahRukuNumber: surahRukuNumber,
                versesCount: versesCount,
                firstVerseKey: firstVerseKey,
                lastVerseKey: lastVerseKey,
                verseMapping: verseMapping,
              ),
          createCompanionCallback:
              ({
                Value<int> rukuNumber = const Value.absent(),
                required int surahRukuNumber,
                required int versesCount,
                required VerseKey firstVerseKey,
                required VerseKey lastVerseKey,
                required SurahRanges verseMapping,
              }) => RukusCompanion.insert(
                rukuNumber: rukuNumber,
                surahRukuNumber: surahRukuNumber,
                versesCount: versesCount,
                firstVerseKey: firstVerseKey,
                lastVerseKey: lastVerseKey,
                verseMapping: verseMapping,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RukusTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RukusTable,
      RukuRow,
      $$RukusTableFilterComposer,
      $$RukusTableOrderingComposer,
      $$RukusTableAnnotationComposer,
      $$RukusTableCreateCompanionBuilder,
      $$RukusTableUpdateCompanionBuilder,
      (RukuRow, BaseReferences<_$AppDatabase, $RukusTable, RukuRow>),
      RukuRow,
      PrefetchHooks Function()
    >;
typedef $$SajdahsTableCreateCompanionBuilder =
    SajdahsCompanion Function({
      Value<int> sajdahNumber,
      required VerseKey verseKey,
      required SajdahType sajdahType,
    });
typedef $$SajdahsTableUpdateCompanionBuilder =
    SajdahsCompanion Function({
      Value<int> sajdahNumber,
      Value<VerseKey> verseKey,
      Value<SajdahType> sajdahType,
    });

class $$SajdahsTableFilterComposer
    extends Composer<_$AppDatabase, $SajdahsTable> {
  $$SajdahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get sajdahNumber => $composableBuilder(
    column: $table.sajdahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VerseKey, VerseKey, String> get verseKey =>
      $composableBuilder(
        column: $table.verseKey,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<SajdahType, SajdahType, String>
  get sajdahType => $composableBuilder(
    column: $table.sajdahType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$SajdahsTableOrderingComposer
    extends Composer<_$AppDatabase, $SajdahsTable> {
  $$SajdahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get sajdahNumber => $composableBuilder(
    column: $table.sajdahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verseKey => $composableBuilder(
    column: $table.verseKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sajdahType => $composableBuilder(
    column: $table.sajdahType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SajdahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SajdahsTable> {
  $$SajdahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get sajdahNumber => $composableBuilder(
    column: $table.sajdahNumber,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<VerseKey, String> get verseKey =>
      $composableBuilder(column: $table.verseKey, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SajdahType, String> get sajdahType =>
      $composableBuilder(
        column: $table.sajdahType,
        builder: (column) => column,
      );
}

class $$SajdahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SajdahsTable,
          SajdahRow,
          $$SajdahsTableFilterComposer,
          $$SajdahsTableOrderingComposer,
          $$SajdahsTableAnnotationComposer,
          $$SajdahsTableCreateCompanionBuilder,
          $$SajdahsTableUpdateCompanionBuilder,
          (SajdahRow, BaseReferences<_$AppDatabase, $SajdahsTable, SajdahRow>),
          SajdahRow,
          PrefetchHooks Function()
        > {
  $$SajdahsTableTableManager(_$AppDatabase db, $SajdahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SajdahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SajdahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SajdahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> sajdahNumber = const Value.absent(),
                Value<VerseKey> verseKey = const Value.absent(),
                Value<SajdahType> sajdahType = const Value.absent(),
              }) => SajdahsCompanion(
                sajdahNumber: sajdahNumber,
                verseKey: verseKey,
                sajdahType: sajdahType,
              ),
          createCompanionCallback:
              ({
                Value<int> sajdahNumber = const Value.absent(),
                required VerseKey verseKey,
                required SajdahType sajdahType,
              }) => SajdahsCompanion.insert(
                sajdahNumber: sajdahNumber,
                verseKey: verseKey,
                sajdahType: sajdahType,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SajdahsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SajdahsTable,
      SajdahRow,
      $$SajdahsTableFilterComposer,
      $$SajdahsTableOrderingComposer,
      $$SajdahsTableAnnotationComposer,
      $$SajdahsTableCreateCompanionBuilder,
      $$SajdahsTableUpdateCompanionBuilder,
      (SajdahRow, BaseReferences<_$AppDatabase, $SajdahsTable, SajdahRow>),
      SajdahRow,
      PrefetchHooks Function()
    >;
typedef $$AyahMetasTableCreateCompanionBuilder =
    AyahMetasCompanion Function({
      Value<int> id,
      required int surah,
      required int ayah,
      required int globalIndex,
      required int pageNo,
      required int juzNo,
      required int hizbNo,
      required int rukuNo,
      required HizbFraction hizbFraction,
    });
typedef $$AyahMetasTableUpdateCompanionBuilder =
    AyahMetasCompanion Function({
      Value<int> id,
      Value<int> surah,
      Value<int> ayah,
      Value<int> globalIndex,
      Value<int> pageNo,
      Value<int> juzNo,
      Value<int> hizbNo,
      Value<int> rukuNo,
      Value<HizbFraction> hizbFraction,
    });

class $$AyahMetasTableFilterComposer
    extends Composer<_$AppDatabase, $AyahMetasTable> {
  $$AyahMetasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surah => $composableBuilder(
    column: $table.surah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayah => $composableBuilder(
    column: $table.ayah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get globalIndex => $composableBuilder(
    column: $table.globalIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageNo => $composableBuilder(
    column: $table.pageNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get juzNo => $composableBuilder(
    column: $table.juzNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hizbNo => $composableBuilder(
    column: $table.hizbNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rukuNo => $composableBuilder(
    column: $table.rukuNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HizbFraction, HizbFraction, int>
  get hizbFraction => $composableBuilder(
    column: $table.hizbFraction,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$AyahMetasTableOrderingComposer
    extends Composer<_$AppDatabase, $AyahMetasTable> {
  $$AyahMetasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surah => $composableBuilder(
    column: $table.surah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayah => $composableBuilder(
    column: $table.ayah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get globalIndex => $composableBuilder(
    column: $table.globalIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageNo => $composableBuilder(
    column: $table.pageNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get juzNo => $composableBuilder(
    column: $table.juzNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hizbNo => $composableBuilder(
    column: $table.hizbNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rukuNo => $composableBuilder(
    column: $table.rukuNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hizbFraction => $composableBuilder(
    column: $table.hizbFraction,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AyahMetasTableAnnotationComposer
    extends Composer<_$AppDatabase, $AyahMetasTable> {
  $$AyahMetasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surah =>
      $composableBuilder(column: $table.surah, builder: (column) => column);

  GeneratedColumn<int> get ayah =>
      $composableBuilder(column: $table.ayah, builder: (column) => column);

  GeneratedColumn<int> get globalIndex => $composableBuilder(
    column: $table.globalIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pageNo =>
      $composableBuilder(column: $table.pageNo, builder: (column) => column);

  GeneratedColumn<int> get juzNo =>
      $composableBuilder(column: $table.juzNo, builder: (column) => column);

  GeneratedColumn<int> get hizbNo =>
      $composableBuilder(column: $table.hizbNo, builder: (column) => column);

  GeneratedColumn<int> get rukuNo =>
      $composableBuilder(column: $table.rukuNo, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HizbFraction, int> get hizbFraction =>
      $composableBuilder(
        column: $table.hizbFraction,
        builder: (column) => column,
      );
}

class $$AyahMetasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AyahMetasTable,
          AyahMetaRow,
          $$AyahMetasTableFilterComposer,
          $$AyahMetasTableOrderingComposer,
          $$AyahMetasTableAnnotationComposer,
          $$AyahMetasTableCreateCompanionBuilder,
          $$AyahMetasTableUpdateCompanionBuilder,
          (
            AyahMetaRow,
            BaseReferences<_$AppDatabase, $AyahMetasTable, AyahMetaRow>,
          ),
          AyahMetaRow,
          PrefetchHooks Function()
        > {
  $$AyahMetasTableTableManager(_$AppDatabase db, $AyahMetasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AyahMetasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AyahMetasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AyahMetasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surah = const Value.absent(),
                Value<int> ayah = const Value.absent(),
                Value<int> globalIndex = const Value.absent(),
                Value<int> pageNo = const Value.absent(),
                Value<int> juzNo = const Value.absent(),
                Value<int> hizbNo = const Value.absent(),
                Value<int> rukuNo = const Value.absent(),
                Value<HizbFraction> hizbFraction = const Value.absent(),
              }) => AyahMetasCompanion(
                id: id,
                surah: surah,
                ayah: ayah,
                globalIndex: globalIndex,
                pageNo: pageNo,
                juzNo: juzNo,
                hizbNo: hizbNo,
                rukuNo: rukuNo,
                hizbFraction: hizbFraction,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surah,
                required int ayah,
                required int globalIndex,
                required int pageNo,
                required int juzNo,
                required int hizbNo,
                required int rukuNo,
                required HizbFraction hizbFraction,
              }) => AyahMetasCompanion.insert(
                id: id,
                surah: surah,
                ayah: ayah,
                globalIndex: globalIndex,
                pageNo: pageNo,
                juzNo: juzNo,
                hizbNo: hizbNo,
                rukuNo: rukuNo,
                hizbFraction: hizbFraction,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AyahMetasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AyahMetasTable,
      AyahMetaRow,
      $$AyahMetasTableFilterComposer,
      $$AyahMetasTableOrderingComposer,
      $$AyahMetasTableAnnotationComposer,
      $$AyahMetasTableCreateCompanionBuilder,
      $$AyahMetasTableUpdateCompanionBuilder,
      (
        AyahMetaRow,
        BaseReferences<_$AppDatabase, $AyahMetasTable, AyahMetaRow>,
      ),
      AyahMetaRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WordsTableTableManager get words =>
      $$WordsTableTableManager(_db, _db.words);
  $$ChaptersTableTableManager get chapters =>
      $$ChaptersTableTableManager(_db, _db.chapters);
  $$HizbsTableTableManager get hizbs =>
      $$HizbsTableTableManager(_db, _db.hizbs);
  $$JuzsTableTableManager get juzs => $$JuzsTableTableManager(_db, _db.juzs);
  $$RukusTableTableManager get rukus =>
      $$RukusTableTableManager(_db, _db.rukus);
  $$SajdahsTableTableManager get sajdahs =>
      $$SajdahsTableTableManager(_db, _db.sajdahs);
  $$AyahMetasTableTableManager get ayahMetas =>
      $$AyahMetasTableTableManager(_db, _db.ayahMetas);
}
