// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
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
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<int> word = GeneratedColumn<int>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
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
    textContent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
    Insertable<Word> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
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
        _textContentMeta,
        textContent.isAcceptableOrUnknown(data['text']!, _textContentMeta),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Word map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Word(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
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
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

class Word extends DataClass implements Insertable<Word> {
  final int id;
  final String location;
  final int surah;
  final int ayah;
  final int word;
  final String textContent;
  const Word({
    required this.id,
    required this.location,
    required this.surah,
    required this.ayah,
    required this.word,
    required this.textContent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['location'] = Variable<String>(location);
    map['surah'] = Variable<int>(surah);
    map['ayah'] = Variable<int>(ayah);
    map['word'] = Variable<int>(word);
    map['text'] = Variable<String>(textContent);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      location: Value(location),
      surah: Value(surah),
      ayah: Value(ayah),
      word: Value(word),
      textContent: Value(textContent),
    );
  }

  factory Word.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Word(
      id: serializer.fromJson<int>(json['id']),
      location: serializer.fromJson<String>(json['location']),
      surah: serializer.fromJson<int>(json['surah']),
      ayah: serializer.fromJson<int>(json['ayah']),
      word: serializer.fromJson<int>(json['word']),
      textContent: serializer.fromJson<String>(json['textContent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'location': serializer.toJson<String>(location),
      'surah': serializer.toJson<int>(surah),
      'ayah': serializer.toJson<int>(ayah),
      'word': serializer.toJson<int>(word),
      'textContent': serializer.toJson<String>(textContent),
    };
  }

  Word copyWith({
    int? id,
    String? location,
    int? surah,
    int? ayah,
    int? word,
    String? textContent,
  }) => Word(
    id: id ?? this.id,
    location: location ?? this.location,
    surah: surah ?? this.surah,
    ayah: ayah ?? this.ayah,
    word: word ?? this.word,
    textContent: textContent ?? this.textContent,
  );
  Word copyWithCompanion(WordsCompanion data) {
    return Word(
      id: data.id.present ? data.id.value : this.id,
      location: data.location.present ? data.location.value : this.location,
      surah: data.surah.present ? data.surah.value : this.surah,
      ayah: data.ayah.present ? data.ayah.value : this.ayah,
      word: data.word.present ? data.word.value : this.word,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('id: $id, ')
          ..write('location: $location, ')
          ..write('surah: $surah, ')
          ..write('ayah: $ayah, ')
          ..write('word: $word, ')
          ..write('textContent: $textContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, location, surah, ayah, word, textContent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Word &&
          other.id == this.id &&
          other.location == this.location &&
          other.surah == this.surah &&
          other.ayah == this.ayah &&
          other.word == this.word &&
          other.textContent == this.textContent);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<int> id;
  final Value<String> location;
  final Value<int> surah;
  final Value<int> ayah;
  final Value<int> word;
  final Value<String> textContent;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.location = const Value.absent(),
    this.surah = const Value.absent(),
    this.ayah = const Value.absent(),
    this.word = const Value.absent(),
    this.textContent = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required String location,
    required int surah,
    required int ayah,
    required int word,
    required String textContent,
  }) : location = Value(location),
       surah = Value(surah),
       ayah = Value(ayah),
       word = Value(word),
       textContent = Value(textContent);
  static Insertable<Word> custom({
    Expression<int>? id,
    Expression<String>? location,
    Expression<int>? surah,
    Expression<int>? ayah,
    Expression<int>? word,
    Expression<String>? textContent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (location != null) 'location': location,
      if (surah != null) 'surah': surah,
      if (ayah != null) 'ayah': ayah,
      if (word != null) 'word': word,
      if (textContent != null) 'text': textContent,
    });
  }

  WordsCompanion copyWith({
    Value<int>? id,
    Value<String>? location,
    Value<int>? surah,
    Value<int>? ayah,
    Value<int>? word,
    Value<String>? textContent,
  }) {
    return WordsCompanion(
      id: id ?? this.id,
      location: location ?? this.location,
      surah: surah ?? this.surah,
      ayah: ayah ?? this.ayah,
      word: word ?? this.word,
      textContent: textContent ?? this.textContent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
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
    if (textContent.present) {
      map['text'] = Variable<String>(textContent.value);
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
          ..write('textContent: $textContent')
          ..write(')'))
        .toString();
  }
}

class $ChaptersTable extends Chapters with TableInfo<$ChaptersTable, Chapter> {
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
  static const VerificationMeta _revelationPlaceMeta = const VerificationMeta(
    'revelationPlace',
  );
  @override
  late final GeneratedColumn<String> revelationPlace = GeneratedColumn<String>(
    'revelation_place',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _bismillahPreMeta = const VerificationMeta(
    'bismillahPre',
  );
  @override
  late final GeneratedColumn<int> bismillahPre = GeneratedColumn<int>(
    'bismillah_pre',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Chapter> instance, {
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
    if (data.containsKey('revelation_place')) {
      context.handle(
        _revelationPlaceMeta,
        revelationPlace.isAcceptableOrUnknown(
          data['revelation_place']!,
          _revelationPlaceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_revelationPlaceMeta);
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
    if (data.containsKey('bismillah_pre')) {
      context.handle(
        _bismillahPreMeta,
        bismillahPre.isAcceptableOrUnknown(
          data['bismillah_pre']!,
          _bismillahPreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bismillahPreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chapter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chapter(
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
      revelationPlace: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}revelation_place'],
      )!,
      versesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verses_count'],
      )!,
      bismillahPre: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bismillah_pre'],
      )!,
    );
  }

  @override
  $ChaptersTable createAlias(String alias) {
    return $ChaptersTable(attachedDatabase, alias);
  }
}

class Chapter extends DataClass implements Insertable<Chapter> {
  final int id;
  final String name;
  final String nameSimple;
  final String nameArabic;
  final int revelationOrder;
  final String revelationPlace;
  final int versesCount;
  final int bismillahPre;
  const Chapter({
    required this.id,
    required this.name,
    required this.nameSimple,
    required this.nameArabic,
    required this.revelationOrder,
    required this.revelationPlace,
    required this.versesCount,
    required this.bismillahPre,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['name_simple'] = Variable<String>(nameSimple);
    map['name_arabic'] = Variable<String>(nameArabic);
    map['revelation_order'] = Variable<int>(revelationOrder);
    map['revelation_place'] = Variable<String>(revelationPlace);
    map['verses_count'] = Variable<int>(versesCount);
    map['bismillah_pre'] = Variable<int>(bismillahPre);
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
    );
  }

  factory Chapter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chapter(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameSimple: serializer.fromJson<String>(json['nameSimple']),
      nameArabic: serializer.fromJson<String>(json['nameArabic']),
      revelationOrder: serializer.fromJson<int>(json['revelationOrder']),
      revelationPlace: serializer.fromJson<String>(json['revelationPlace']),
      versesCount: serializer.fromJson<int>(json['versesCount']),
      bismillahPre: serializer.fromJson<int>(json['bismillahPre']),
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
      'revelationPlace': serializer.toJson<String>(revelationPlace),
      'versesCount': serializer.toJson<int>(versesCount),
      'bismillahPre': serializer.toJson<int>(bismillahPre),
    };
  }

  Chapter copyWith({
    int? id,
    String? name,
    String? nameSimple,
    String? nameArabic,
    int? revelationOrder,
    String? revelationPlace,
    int? versesCount,
    int? bismillahPre,
  }) => Chapter(
    id: id ?? this.id,
    name: name ?? this.name,
    nameSimple: nameSimple ?? this.nameSimple,
    nameArabic: nameArabic ?? this.nameArabic,
    revelationOrder: revelationOrder ?? this.revelationOrder,
    revelationPlace: revelationPlace ?? this.revelationPlace,
    versesCount: versesCount ?? this.versesCount,
    bismillahPre: bismillahPre ?? this.bismillahPre,
  );
  Chapter copyWithCompanion(ChaptersCompanion data) {
    return Chapter(
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
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chapter(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameSimple: $nameSimple, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('revelationOrder: $revelationOrder, ')
          ..write('revelationPlace: $revelationPlace, ')
          ..write('versesCount: $versesCount, ')
          ..write('bismillahPre: $bismillahPre')
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
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chapter &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameSimple == this.nameSimple &&
          other.nameArabic == this.nameArabic &&
          other.revelationOrder == this.revelationOrder &&
          other.revelationPlace == this.revelationPlace &&
          other.versesCount == this.versesCount &&
          other.bismillahPre == this.bismillahPre);
}

class ChaptersCompanion extends UpdateCompanion<Chapter> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> nameSimple;
  final Value<String> nameArabic;
  final Value<int> revelationOrder;
  final Value<String> revelationPlace;
  final Value<int> versesCount;
  final Value<int> bismillahPre;
  const ChaptersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameSimple = const Value.absent(),
    this.nameArabic = const Value.absent(),
    this.revelationOrder = const Value.absent(),
    this.revelationPlace = const Value.absent(),
    this.versesCount = const Value.absent(),
    this.bismillahPre = const Value.absent(),
  });
  ChaptersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String nameSimple,
    required String nameArabic,
    required int revelationOrder,
    required String revelationPlace,
    required int versesCount,
    required int bismillahPre,
  }) : name = Value(name),
       nameSimple = Value(nameSimple),
       nameArabic = Value(nameArabic),
       revelationOrder = Value(revelationOrder),
       revelationPlace = Value(revelationPlace),
       versesCount = Value(versesCount),
       bismillahPre = Value(bismillahPre);
  static Insertable<Chapter> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameSimple,
    Expression<String>? nameArabic,
    Expression<int>? revelationOrder,
    Expression<String>? revelationPlace,
    Expression<int>? versesCount,
    Expression<int>? bismillahPre,
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
    });
  }

  ChaptersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? nameSimple,
    Value<String>? nameArabic,
    Value<int>? revelationOrder,
    Value<String>? revelationPlace,
    Value<int>? versesCount,
    Value<int>? bismillahPre,
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
      map['revelation_place'] = Variable<String>(revelationPlace.value);
    }
    if (versesCount.present) {
      map['verses_count'] = Variable<int>(versesCount.value);
    }
    if (bismillahPre.present) {
      map['bismillah_pre'] = Variable<int>(bismillahPre.value);
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
          ..write('bismillahPre: $bismillahPre')
          ..write(')'))
        .toString();
  }
}

class $HizbsTable extends Hizbs with TableInfo<$HizbsTable, Hizb> {
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
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _firstVerseKeyMeta = const VerificationMeta(
    'firstVerseKey',
  );
  @override
  late final GeneratedColumn<String> firstVerseKey = GeneratedColumn<String>(
    'first_verse_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastVerseKeyMeta = const VerificationMeta(
    'lastVerseKey',
  );
  @override
  late final GeneratedColumn<String> lastVerseKey = GeneratedColumn<String>(
    'last_verse_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _verseMappingMeta = const VerificationMeta(
    'verseMapping',
  );
  @override
  late final GeneratedColumn<String> verseMapping = GeneratedColumn<String>(
    'verse_mapping',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
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
    Insertable<Hizb> instance, {
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
    }
    if (data.containsKey('first_verse_key')) {
      context.handle(
        _firstVerseKeyMeta,
        firstVerseKey.isAcceptableOrUnknown(
          data['first_verse_key']!,
          _firstVerseKeyMeta,
        ),
      );
    }
    if (data.containsKey('last_verse_key')) {
      context.handle(
        _lastVerseKeyMeta,
        lastVerseKey.isAcceptableOrUnknown(
          data['last_verse_key']!,
          _lastVerseKeyMeta,
        ),
      );
    }
    if (data.containsKey('verse_mapping')) {
      context.handle(
        _verseMappingMeta,
        verseMapping.isAcceptableOrUnknown(
          data['verse_mapping']!,
          _verseMappingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {hizbNumber};
  @override
  Hizb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Hizb(
      hizbNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hizb_number'],
      )!,
      versesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verses_count'],
      ),
      firstVerseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_verse_key'],
      ),
      lastVerseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_verse_key'],
      ),
      verseMapping: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verse_mapping'],
      ),
    );
  }

  @override
  $HizbsTable createAlias(String alias) {
    return $HizbsTable(attachedDatabase, alias);
  }
}

class Hizb extends DataClass implements Insertable<Hizb> {
  final int hizbNumber;
  final int? versesCount;
  final String? firstVerseKey;
  final String? lastVerseKey;
  final String? verseMapping;
  const Hizb({
    required this.hizbNumber,
    this.versesCount,
    this.firstVerseKey,
    this.lastVerseKey,
    this.verseMapping,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['hizb_number'] = Variable<int>(hizbNumber);
    if (!nullToAbsent || versesCount != null) {
      map['verses_count'] = Variable<int>(versesCount);
    }
    if (!nullToAbsent || firstVerseKey != null) {
      map['first_verse_key'] = Variable<String>(firstVerseKey);
    }
    if (!nullToAbsent || lastVerseKey != null) {
      map['last_verse_key'] = Variable<String>(lastVerseKey);
    }
    if (!nullToAbsent || verseMapping != null) {
      map['verse_mapping'] = Variable<String>(verseMapping);
    }
    return map;
  }

  HizbsCompanion toCompanion(bool nullToAbsent) {
    return HizbsCompanion(
      hizbNumber: Value(hizbNumber),
      versesCount: versesCount == null && nullToAbsent
          ? const Value.absent()
          : Value(versesCount),
      firstVerseKey: firstVerseKey == null && nullToAbsent
          ? const Value.absent()
          : Value(firstVerseKey),
      lastVerseKey: lastVerseKey == null && nullToAbsent
          ? const Value.absent()
          : Value(lastVerseKey),
      verseMapping: verseMapping == null && nullToAbsent
          ? const Value.absent()
          : Value(verseMapping),
    );
  }

  factory Hizb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Hizb(
      hizbNumber: serializer.fromJson<int>(json['hizbNumber']),
      versesCount: serializer.fromJson<int?>(json['versesCount']),
      firstVerseKey: serializer.fromJson<String?>(json['firstVerseKey']),
      lastVerseKey: serializer.fromJson<String?>(json['lastVerseKey']),
      verseMapping: serializer.fromJson<String?>(json['verseMapping']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'hizbNumber': serializer.toJson<int>(hizbNumber),
      'versesCount': serializer.toJson<int?>(versesCount),
      'firstVerseKey': serializer.toJson<String?>(firstVerseKey),
      'lastVerseKey': serializer.toJson<String?>(lastVerseKey),
      'verseMapping': serializer.toJson<String?>(verseMapping),
    };
  }

  Hizb copyWith({
    int? hizbNumber,
    Value<int?> versesCount = const Value.absent(),
    Value<String?> firstVerseKey = const Value.absent(),
    Value<String?> lastVerseKey = const Value.absent(),
    Value<String?> verseMapping = const Value.absent(),
  }) => Hizb(
    hizbNumber: hizbNumber ?? this.hizbNumber,
    versesCount: versesCount.present ? versesCount.value : this.versesCount,
    firstVerseKey: firstVerseKey.present
        ? firstVerseKey.value
        : this.firstVerseKey,
    lastVerseKey: lastVerseKey.present ? lastVerseKey.value : this.lastVerseKey,
    verseMapping: verseMapping.present ? verseMapping.value : this.verseMapping,
  );
  Hizb copyWithCompanion(HizbsCompanion data) {
    return Hizb(
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
    return (StringBuffer('Hizb(')
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
      (other is Hizb &&
          other.hizbNumber == this.hizbNumber &&
          other.versesCount == this.versesCount &&
          other.firstVerseKey == this.firstVerseKey &&
          other.lastVerseKey == this.lastVerseKey &&
          other.verseMapping == this.verseMapping);
}

class HizbsCompanion extends UpdateCompanion<Hizb> {
  final Value<int> hizbNumber;
  final Value<int?> versesCount;
  final Value<String?> firstVerseKey;
  final Value<String?> lastVerseKey;
  final Value<String?> verseMapping;
  const HizbsCompanion({
    this.hizbNumber = const Value.absent(),
    this.versesCount = const Value.absent(),
    this.firstVerseKey = const Value.absent(),
    this.lastVerseKey = const Value.absent(),
    this.verseMapping = const Value.absent(),
  });
  HizbsCompanion.insert({
    this.hizbNumber = const Value.absent(),
    this.versesCount = const Value.absent(),
    this.firstVerseKey = const Value.absent(),
    this.lastVerseKey = const Value.absent(),
    this.verseMapping = const Value.absent(),
  });
  static Insertable<Hizb> custom({
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
    Value<int?>? versesCount,
    Value<String?>? firstVerseKey,
    Value<String?>? lastVerseKey,
    Value<String?>? verseMapping,
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
      map['first_verse_key'] = Variable<String>(firstVerseKey.value);
    }
    if (lastVerseKey.present) {
      map['last_verse_key'] = Variable<String>(lastVerseKey.value);
    }
    if (verseMapping.present) {
      map['verse_mapping'] = Variable<String>(verseMapping.value);
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

class $JuzsTable extends Juzs with TableInfo<$JuzsTable, Juz> {
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
  static const VerificationMeta _firstVerseKeyMeta = const VerificationMeta(
    'firstVerseKey',
  );
  @override
  late final GeneratedColumn<String> firstVerseKey = GeneratedColumn<String>(
    'first_verse_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastVerseKeyMeta = const VerificationMeta(
    'lastVerseKey',
  );
  @override
  late final GeneratedColumn<String> lastVerseKey = GeneratedColumn<String>(
    'last_verse_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verseMappingMeta = const VerificationMeta(
    'verseMapping',
  );
  @override
  late final GeneratedColumn<String> verseMapping = GeneratedColumn<String>(
    'verse_mapping',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
    Insertable<Juz> instance, {
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
    if (data.containsKey('first_verse_key')) {
      context.handle(
        _firstVerseKeyMeta,
        firstVerseKey.isAcceptableOrUnknown(
          data['first_verse_key']!,
          _firstVerseKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstVerseKeyMeta);
    }
    if (data.containsKey('last_verse_key')) {
      context.handle(
        _lastVerseKeyMeta,
        lastVerseKey.isAcceptableOrUnknown(
          data['last_verse_key']!,
          _lastVerseKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastVerseKeyMeta);
    }
    if (data.containsKey('verse_mapping')) {
      context.handle(
        _verseMappingMeta,
        verseMapping.isAcceptableOrUnknown(
          data['verse_mapping']!,
          _verseMappingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_verseMappingMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {juzNumber};
  @override
  Juz map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Juz(
      juzNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}juz_number'],
      )!,
      versesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verses_count'],
      )!,
      firstVerseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_verse_key'],
      )!,
      lastVerseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_verse_key'],
      )!,
      verseMapping: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verse_mapping'],
      )!,
    );
  }

  @override
  $JuzsTable createAlias(String alias) {
    return $JuzsTable(attachedDatabase, alias);
  }
}

class Juz extends DataClass implements Insertable<Juz> {
  final int juzNumber;
  final int versesCount;
  final String firstVerseKey;
  final String lastVerseKey;
  final String verseMapping;
  const Juz({
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
    map['first_verse_key'] = Variable<String>(firstVerseKey);
    map['last_verse_key'] = Variable<String>(lastVerseKey);
    map['verse_mapping'] = Variable<String>(verseMapping);
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

  factory Juz.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Juz(
      juzNumber: serializer.fromJson<int>(json['juzNumber']),
      versesCount: serializer.fromJson<int>(json['versesCount']),
      firstVerseKey: serializer.fromJson<String>(json['firstVerseKey']),
      lastVerseKey: serializer.fromJson<String>(json['lastVerseKey']),
      verseMapping: serializer.fromJson<String>(json['verseMapping']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'juzNumber': serializer.toJson<int>(juzNumber),
      'versesCount': serializer.toJson<int>(versesCount),
      'firstVerseKey': serializer.toJson<String>(firstVerseKey),
      'lastVerseKey': serializer.toJson<String>(lastVerseKey),
      'verseMapping': serializer.toJson<String>(verseMapping),
    };
  }

  Juz copyWith({
    int? juzNumber,
    int? versesCount,
    String? firstVerseKey,
    String? lastVerseKey,
    String? verseMapping,
  }) => Juz(
    juzNumber: juzNumber ?? this.juzNumber,
    versesCount: versesCount ?? this.versesCount,
    firstVerseKey: firstVerseKey ?? this.firstVerseKey,
    lastVerseKey: lastVerseKey ?? this.lastVerseKey,
    verseMapping: verseMapping ?? this.verseMapping,
  );
  Juz copyWithCompanion(JuzsCompanion data) {
    return Juz(
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
    return (StringBuffer('Juz(')
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
      (other is Juz &&
          other.juzNumber == this.juzNumber &&
          other.versesCount == this.versesCount &&
          other.firstVerseKey == this.firstVerseKey &&
          other.lastVerseKey == this.lastVerseKey &&
          other.verseMapping == this.verseMapping);
}

class JuzsCompanion extends UpdateCompanion<Juz> {
  final Value<int> juzNumber;
  final Value<int> versesCount;
  final Value<String> firstVerseKey;
  final Value<String> lastVerseKey;
  final Value<String> verseMapping;
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
    required String firstVerseKey,
    required String lastVerseKey,
    required String verseMapping,
  }) : versesCount = Value(versesCount),
       firstVerseKey = Value(firstVerseKey),
       lastVerseKey = Value(lastVerseKey),
       verseMapping = Value(verseMapping);
  static Insertable<Juz> custom({
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
    Value<String>? firstVerseKey,
    Value<String>? lastVerseKey,
    Value<String>? verseMapping,
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
      map['first_verse_key'] = Variable<String>(firstVerseKey.value);
    }
    if (lastVerseKey.present) {
      map['last_verse_key'] = Variable<String>(lastVerseKey.value);
    }
    if (verseMapping.present) {
      map['verse_mapping'] = Variable<String>(verseMapping.value);
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

class $RukusTable extends Rukus with TableInfo<$RukusTable, Ruku> {
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
  static const VerificationMeta _firstVerseKeyMeta = const VerificationMeta(
    'firstVerseKey',
  );
  @override
  late final GeneratedColumn<String> firstVerseKey = GeneratedColumn<String>(
    'first_verse_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastVerseKeyMeta = const VerificationMeta(
    'lastVerseKey',
  );
  @override
  late final GeneratedColumn<String> lastVerseKey = GeneratedColumn<String>(
    'last_verse_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verseMappingMeta = const VerificationMeta(
    'verseMapping',
  );
  @override
  late final GeneratedColumn<String> verseMapping = GeneratedColumn<String>(
    'verse_mapping',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
    Insertable<Ruku> instance, {
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
    if (data.containsKey('first_verse_key')) {
      context.handle(
        _firstVerseKeyMeta,
        firstVerseKey.isAcceptableOrUnknown(
          data['first_verse_key']!,
          _firstVerseKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstVerseKeyMeta);
    }
    if (data.containsKey('last_verse_key')) {
      context.handle(
        _lastVerseKeyMeta,
        lastVerseKey.isAcceptableOrUnknown(
          data['last_verse_key']!,
          _lastVerseKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastVerseKeyMeta);
    }
    if (data.containsKey('verse_mapping')) {
      context.handle(
        _verseMappingMeta,
        verseMapping.isAcceptableOrUnknown(
          data['verse_mapping']!,
          _verseMappingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_verseMappingMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rukuNumber};
  @override
  Ruku map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ruku(
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
      firstVerseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_verse_key'],
      )!,
      lastVerseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_verse_key'],
      )!,
      verseMapping: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verse_mapping'],
      )!,
    );
  }

  @override
  $RukusTable createAlias(String alias) {
    return $RukusTable(attachedDatabase, alias);
  }
}

class Ruku extends DataClass implements Insertable<Ruku> {
  final int rukuNumber;
  final int surahRukuNumber;
  final int versesCount;
  final String firstVerseKey;
  final String lastVerseKey;
  final String verseMapping;
  const Ruku({
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
    map['first_verse_key'] = Variable<String>(firstVerseKey);
    map['last_verse_key'] = Variable<String>(lastVerseKey);
    map['verse_mapping'] = Variable<String>(verseMapping);
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

  factory Ruku.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ruku(
      rukuNumber: serializer.fromJson<int>(json['rukuNumber']),
      surahRukuNumber: serializer.fromJson<int>(json['surahRukuNumber']),
      versesCount: serializer.fromJson<int>(json['versesCount']),
      firstVerseKey: serializer.fromJson<String>(json['firstVerseKey']),
      lastVerseKey: serializer.fromJson<String>(json['lastVerseKey']),
      verseMapping: serializer.fromJson<String>(json['verseMapping']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rukuNumber': serializer.toJson<int>(rukuNumber),
      'surahRukuNumber': serializer.toJson<int>(surahRukuNumber),
      'versesCount': serializer.toJson<int>(versesCount),
      'firstVerseKey': serializer.toJson<String>(firstVerseKey),
      'lastVerseKey': serializer.toJson<String>(lastVerseKey),
      'verseMapping': serializer.toJson<String>(verseMapping),
    };
  }

  Ruku copyWith({
    int? rukuNumber,
    int? surahRukuNumber,
    int? versesCount,
    String? firstVerseKey,
    String? lastVerseKey,
    String? verseMapping,
  }) => Ruku(
    rukuNumber: rukuNumber ?? this.rukuNumber,
    surahRukuNumber: surahRukuNumber ?? this.surahRukuNumber,
    versesCount: versesCount ?? this.versesCount,
    firstVerseKey: firstVerseKey ?? this.firstVerseKey,
    lastVerseKey: lastVerseKey ?? this.lastVerseKey,
    verseMapping: verseMapping ?? this.verseMapping,
  );
  Ruku copyWithCompanion(RukusCompanion data) {
    return Ruku(
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
    return (StringBuffer('Ruku(')
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
      (other is Ruku &&
          other.rukuNumber == this.rukuNumber &&
          other.surahRukuNumber == this.surahRukuNumber &&
          other.versesCount == this.versesCount &&
          other.firstVerseKey == this.firstVerseKey &&
          other.lastVerseKey == this.lastVerseKey &&
          other.verseMapping == this.verseMapping);
}

class RukusCompanion extends UpdateCompanion<Ruku> {
  final Value<int> rukuNumber;
  final Value<int> surahRukuNumber;
  final Value<int> versesCount;
  final Value<String> firstVerseKey;
  final Value<String> lastVerseKey;
  final Value<String> verseMapping;
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
    required String firstVerseKey,
    required String lastVerseKey,
    required String verseMapping,
  }) : surahRukuNumber = Value(surahRukuNumber),
       versesCount = Value(versesCount),
       firstVerseKey = Value(firstVerseKey),
       lastVerseKey = Value(lastVerseKey),
       verseMapping = Value(verseMapping);
  static Insertable<Ruku> custom({
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
    Value<String>? firstVerseKey,
    Value<String>? lastVerseKey,
    Value<String>? verseMapping,
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
      map['first_verse_key'] = Variable<String>(firstVerseKey.value);
    }
    if (lastVerseKey.present) {
      map['last_verse_key'] = Variable<String>(lastVerseKey.value);
    }
    if (verseMapping.present) {
      map['verse_mapping'] = Variable<String>(verseMapping.value);
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

class $SajdahsTable extends Sajdahs with TableInfo<$SajdahsTable, Sajdah> {
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
  static const VerificationMeta _verseKeyMeta = const VerificationMeta(
    'verseKey',
  );
  @override
  late final GeneratedColumn<String> verseKey = GeneratedColumn<String>(
    'verse_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sajdahTypeMeta = const VerificationMeta(
    'sajdahType',
  );
  @override
  late final GeneratedColumn<String> sajdahType = GeneratedColumn<String>(
    'sajdah_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [sajdahNumber, verseKey, sajdahType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sajdahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sajdah> instance, {
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
    if (data.containsKey('verse_key')) {
      context.handle(
        _verseKeyMeta,
        verseKey.isAcceptableOrUnknown(data['verse_key']!, _verseKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_verseKeyMeta);
    }
    if (data.containsKey('sajdah_type')) {
      context.handle(
        _sajdahTypeMeta,
        sajdahType.isAcceptableOrUnknown(data['sajdah_type']!, _sajdahTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sajdahTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sajdahNumber};
  @override
  Sajdah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sajdah(
      sajdahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sajdah_number'],
      )!,
      verseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verse_key'],
      )!,
      sajdahType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sajdah_type'],
      )!,
    );
  }

  @override
  $SajdahsTable createAlias(String alias) {
    return $SajdahsTable(attachedDatabase, alias);
  }
}

class Sajdah extends DataClass implements Insertable<Sajdah> {
  final int sajdahNumber;
  final String verseKey;
  final String sajdahType;
  const Sajdah({
    required this.sajdahNumber,
    required this.verseKey,
    required this.sajdahType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sajdah_number'] = Variable<int>(sajdahNumber);
    map['verse_key'] = Variable<String>(verseKey);
    map['sajdah_type'] = Variable<String>(sajdahType);
    return map;
  }

  SajdahsCompanion toCompanion(bool nullToAbsent) {
    return SajdahsCompanion(
      sajdahNumber: Value(sajdahNumber),
      verseKey: Value(verseKey),
      sajdahType: Value(sajdahType),
    );
  }

  factory Sajdah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sajdah(
      sajdahNumber: serializer.fromJson<int>(json['sajdahNumber']),
      verseKey: serializer.fromJson<String>(json['verseKey']),
      sajdahType: serializer.fromJson<String>(json['sajdahType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sajdahNumber': serializer.toJson<int>(sajdahNumber),
      'verseKey': serializer.toJson<String>(verseKey),
      'sajdahType': serializer.toJson<String>(sajdahType),
    };
  }

  Sajdah copyWith({int? sajdahNumber, String? verseKey, String? sajdahType}) =>
      Sajdah(
        sajdahNumber: sajdahNumber ?? this.sajdahNumber,
        verseKey: verseKey ?? this.verseKey,
        sajdahType: sajdahType ?? this.sajdahType,
      );
  Sajdah copyWithCompanion(SajdahsCompanion data) {
    return Sajdah(
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
    return (StringBuffer('Sajdah(')
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
      (other is Sajdah &&
          other.sajdahNumber == this.sajdahNumber &&
          other.verseKey == this.verseKey &&
          other.sajdahType == this.sajdahType);
}

class SajdahsCompanion extends UpdateCompanion<Sajdah> {
  final Value<int> sajdahNumber;
  final Value<String> verseKey;
  final Value<String> sajdahType;
  const SajdahsCompanion({
    this.sajdahNumber = const Value.absent(),
    this.verseKey = const Value.absent(),
    this.sajdahType = const Value.absent(),
  });
  SajdahsCompanion.insert({
    this.sajdahNumber = const Value.absent(),
    required String verseKey,
    required String sajdahType,
  }) : verseKey = Value(verseKey),
       sajdahType = Value(sajdahType);
  static Insertable<Sajdah> custom({
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
    Value<String>? verseKey,
    Value<String>? sajdahType,
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
      map['verse_key'] = Variable<String>(verseKey.value);
    }
    if (sajdahType.present) {
      map['sajdah_type'] = Variable<String>(sajdahType.value);
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WordsTable words = $WordsTable(this);
  late final $ChaptersTable chapters = $ChaptersTable(this);
  late final $HizbsTable hizbs = $HizbsTable(this);
  late final $JuzsTable juzs = $JuzsTable(this);
  late final $RukusTable rukus = $RukusTable(this);
  late final $SajdahsTable sajdahs = $SajdahsTable(this);
  late final QuranDao quranDao = QuranDao(this as AppDatabase);
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
  ];
}

typedef $$WordsTableCreateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      required String location,
      required int surah,
      required int ayah,
      required int word,
      required String textContent,
    });
typedef $$WordsTableUpdateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      Value<String> location,
      Value<int> surah,
      Value<int> ayah,
      Value<int> word,
      Value<String> textContent,
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

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
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

  ColumnFilters<int> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
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

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
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

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<int> get surah =>
      $composableBuilder(column: $table.surah, builder: (column) => column);

  GeneratedColumn<int> get ayah =>
      $composableBuilder(column: $table.ayah, builder: (column) => column);

  GeneratedColumn<int> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );
}

class $$WordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordsTable,
          Word,
          $$WordsTableFilterComposer,
          $$WordsTableOrderingComposer,
          $$WordsTableAnnotationComposer,
          $$WordsTableCreateCompanionBuilder,
          $$WordsTableUpdateCompanionBuilder,
          (Word, BaseReferences<_$AppDatabase, $WordsTable, Word>),
          Word,
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
                Value<String> location = const Value.absent(),
                Value<int> surah = const Value.absent(),
                Value<int> ayah = const Value.absent(),
                Value<int> word = const Value.absent(),
                Value<String> textContent = const Value.absent(),
              }) => WordsCompanion(
                id: id,
                location: location,
                surah: surah,
                ayah: ayah,
                word: word,
                textContent: textContent,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String location,
                required int surah,
                required int ayah,
                required int word,
                required String textContent,
              }) => WordsCompanion.insert(
                id: id,
                location: location,
                surah: surah,
                ayah: ayah,
                word: word,
                textContent: textContent,
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
      Word,
      $$WordsTableFilterComposer,
      $$WordsTableOrderingComposer,
      $$WordsTableAnnotationComposer,
      $$WordsTableCreateCompanionBuilder,
      $$WordsTableUpdateCompanionBuilder,
      (Word, BaseReferences<_$AppDatabase, $WordsTable, Word>),
      Word,
      PrefetchHooks Function()
    >;
typedef $$ChaptersTableCreateCompanionBuilder =
    ChaptersCompanion Function({
      Value<int> id,
      required String name,
      required String nameSimple,
      required String nameArabic,
      required int revelationOrder,
      required String revelationPlace,
      required int versesCount,
      required int bismillahPre,
    });
typedef $$ChaptersTableUpdateCompanionBuilder =
    ChaptersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> nameSimple,
      Value<String> nameArabic,
      Value<int> revelationOrder,
      Value<String> revelationPlace,
      Value<int> versesCount,
      Value<int> bismillahPre,
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

  ColumnFilters<String> get revelationPlace => $composableBuilder(
    column: $table.revelationPlace,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bismillahPre => $composableBuilder(
    column: $table.bismillahPre,
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

  GeneratedColumn<String> get revelationPlace => $composableBuilder(
    column: $table.revelationPlace,
    builder: (column) => column,
  );

  GeneratedColumn<int> get versesCount => $composableBuilder(
    column: $table.versesCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bismillahPre => $composableBuilder(
    column: $table.bismillahPre,
    builder: (column) => column,
  );
}

class $$ChaptersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChaptersTable,
          Chapter,
          $$ChaptersTableFilterComposer,
          $$ChaptersTableOrderingComposer,
          $$ChaptersTableAnnotationComposer,
          $$ChaptersTableCreateCompanionBuilder,
          $$ChaptersTableUpdateCompanionBuilder,
          (Chapter, BaseReferences<_$AppDatabase, $ChaptersTable, Chapter>),
          Chapter,
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
                Value<String> revelationPlace = const Value.absent(),
                Value<int> versesCount = const Value.absent(),
                Value<int> bismillahPre = const Value.absent(),
              }) => ChaptersCompanion(
                id: id,
                name: name,
                nameSimple: nameSimple,
                nameArabic: nameArabic,
                revelationOrder: revelationOrder,
                revelationPlace: revelationPlace,
                versesCount: versesCount,
                bismillahPre: bismillahPre,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String nameSimple,
                required String nameArabic,
                required int revelationOrder,
                required String revelationPlace,
                required int versesCount,
                required int bismillahPre,
              }) => ChaptersCompanion.insert(
                id: id,
                name: name,
                nameSimple: nameSimple,
                nameArabic: nameArabic,
                revelationOrder: revelationOrder,
                revelationPlace: revelationPlace,
                versesCount: versesCount,
                bismillahPre: bismillahPre,
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
      Chapter,
      $$ChaptersTableFilterComposer,
      $$ChaptersTableOrderingComposer,
      $$ChaptersTableAnnotationComposer,
      $$ChaptersTableCreateCompanionBuilder,
      $$ChaptersTableUpdateCompanionBuilder,
      (Chapter, BaseReferences<_$AppDatabase, $ChaptersTable, Chapter>),
      Chapter,
      PrefetchHooks Function()
    >;
typedef $$HizbsTableCreateCompanionBuilder =
    HizbsCompanion Function({
      Value<int> hizbNumber,
      Value<int?> versesCount,
      Value<String?> firstVerseKey,
      Value<String?> lastVerseKey,
      Value<String?> verseMapping,
    });
typedef $$HizbsTableUpdateCompanionBuilder =
    HizbsCompanion Function({
      Value<int> hizbNumber,
      Value<int?> versesCount,
      Value<String?> firstVerseKey,
      Value<String?> lastVerseKey,
      Value<String?> verseMapping,
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

  ColumnFilters<String> get firstVerseKey => $composableBuilder(
    column: $table.firstVerseKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastVerseKey => $composableBuilder(
    column: $table.lastVerseKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verseMapping => $composableBuilder(
    column: $table.verseMapping,
    builder: (column) => ColumnFilters(column),
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

  GeneratedColumn<String> get firstVerseKey => $composableBuilder(
    column: $table.firstVerseKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastVerseKey => $composableBuilder(
    column: $table.lastVerseKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get verseMapping => $composableBuilder(
    column: $table.verseMapping,
    builder: (column) => column,
  );
}

class $$HizbsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HizbsTable,
          Hizb,
          $$HizbsTableFilterComposer,
          $$HizbsTableOrderingComposer,
          $$HizbsTableAnnotationComposer,
          $$HizbsTableCreateCompanionBuilder,
          $$HizbsTableUpdateCompanionBuilder,
          (Hizb, BaseReferences<_$AppDatabase, $HizbsTable, Hizb>),
          Hizb,
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
                Value<int?> versesCount = const Value.absent(),
                Value<String?> firstVerseKey = const Value.absent(),
                Value<String?> lastVerseKey = const Value.absent(),
                Value<String?> verseMapping = const Value.absent(),
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
                Value<int?> versesCount = const Value.absent(),
                Value<String?> firstVerseKey = const Value.absent(),
                Value<String?> lastVerseKey = const Value.absent(),
                Value<String?> verseMapping = const Value.absent(),
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
      Hizb,
      $$HizbsTableFilterComposer,
      $$HizbsTableOrderingComposer,
      $$HizbsTableAnnotationComposer,
      $$HizbsTableCreateCompanionBuilder,
      $$HizbsTableUpdateCompanionBuilder,
      (Hizb, BaseReferences<_$AppDatabase, $HizbsTable, Hizb>),
      Hizb,
      PrefetchHooks Function()
    >;
typedef $$JuzsTableCreateCompanionBuilder =
    JuzsCompanion Function({
      Value<int> juzNumber,
      required int versesCount,
      required String firstVerseKey,
      required String lastVerseKey,
      required String verseMapping,
    });
typedef $$JuzsTableUpdateCompanionBuilder =
    JuzsCompanion Function({
      Value<int> juzNumber,
      Value<int> versesCount,
      Value<String> firstVerseKey,
      Value<String> lastVerseKey,
      Value<String> verseMapping,
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

  ColumnFilters<String> get firstVerseKey => $composableBuilder(
    column: $table.firstVerseKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastVerseKey => $composableBuilder(
    column: $table.lastVerseKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verseMapping => $composableBuilder(
    column: $table.verseMapping,
    builder: (column) => ColumnFilters(column),
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

  GeneratedColumn<String> get firstVerseKey => $composableBuilder(
    column: $table.firstVerseKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastVerseKey => $composableBuilder(
    column: $table.lastVerseKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get verseMapping => $composableBuilder(
    column: $table.verseMapping,
    builder: (column) => column,
  );
}

class $$JuzsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JuzsTable,
          Juz,
          $$JuzsTableFilterComposer,
          $$JuzsTableOrderingComposer,
          $$JuzsTableAnnotationComposer,
          $$JuzsTableCreateCompanionBuilder,
          $$JuzsTableUpdateCompanionBuilder,
          (Juz, BaseReferences<_$AppDatabase, $JuzsTable, Juz>),
          Juz,
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
                Value<String> firstVerseKey = const Value.absent(),
                Value<String> lastVerseKey = const Value.absent(),
                Value<String> verseMapping = const Value.absent(),
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
                required String firstVerseKey,
                required String lastVerseKey,
                required String verseMapping,
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
      Juz,
      $$JuzsTableFilterComposer,
      $$JuzsTableOrderingComposer,
      $$JuzsTableAnnotationComposer,
      $$JuzsTableCreateCompanionBuilder,
      $$JuzsTableUpdateCompanionBuilder,
      (Juz, BaseReferences<_$AppDatabase, $JuzsTable, Juz>),
      Juz,
      PrefetchHooks Function()
    >;
typedef $$RukusTableCreateCompanionBuilder =
    RukusCompanion Function({
      Value<int> rukuNumber,
      required int surahRukuNumber,
      required int versesCount,
      required String firstVerseKey,
      required String lastVerseKey,
      required String verseMapping,
    });
typedef $$RukusTableUpdateCompanionBuilder =
    RukusCompanion Function({
      Value<int> rukuNumber,
      Value<int> surahRukuNumber,
      Value<int> versesCount,
      Value<String> firstVerseKey,
      Value<String> lastVerseKey,
      Value<String> verseMapping,
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

  ColumnFilters<String> get firstVerseKey => $composableBuilder(
    column: $table.firstVerseKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastVerseKey => $composableBuilder(
    column: $table.lastVerseKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verseMapping => $composableBuilder(
    column: $table.verseMapping,
    builder: (column) => ColumnFilters(column),
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

  GeneratedColumn<String> get firstVerseKey => $composableBuilder(
    column: $table.firstVerseKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastVerseKey => $composableBuilder(
    column: $table.lastVerseKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get verseMapping => $composableBuilder(
    column: $table.verseMapping,
    builder: (column) => column,
  );
}

class $$RukusTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RukusTable,
          Ruku,
          $$RukusTableFilterComposer,
          $$RukusTableOrderingComposer,
          $$RukusTableAnnotationComposer,
          $$RukusTableCreateCompanionBuilder,
          $$RukusTableUpdateCompanionBuilder,
          (Ruku, BaseReferences<_$AppDatabase, $RukusTable, Ruku>),
          Ruku,
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
                Value<String> firstVerseKey = const Value.absent(),
                Value<String> lastVerseKey = const Value.absent(),
                Value<String> verseMapping = const Value.absent(),
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
                required String firstVerseKey,
                required String lastVerseKey,
                required String verseMapping,
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
      Ruku,
      $$RukusTableFilterComposer,
      $$RukusTableOrderingComposer,
      $$RukusTableAnnotationComposer,
      $$RukusTableCreateCompanionBuilder,
      $$RukusTableUpdateCompanionBuilder,
      (Ruku, BaseReferences<_$AppDatabase, $RukusTable, Ruku>),
      Ruku,
      PrefetchHooks Function()
    >;
typedef $$SajdahsTableCreateCompanionBuilder =
    SajdahsCompanion Function({
      Value<int> sajdahNumber,
      required String verseKey,
      required String sajdahType,
    });
typedef $$SajdahsTableUpdateCompanionBuilder =
    SajdahsCompanion Function({
      Value<int> sajdahNumber,
      Value<String> verseKey,
      Value<String> sajdahType,
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

  ColumnFilters<String> get verseKey => $composableBuilder(
    column: $table.verseKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sajdahType => $composableBuilder(
    column: $table.sajdahType,
    builder: (column) => ColumnFilters(column),
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

  GeneratedColumn<String> get verseKey =>
      $composableBuilder(column: $table.verseKey, builder: (column) => column);

  GeneratedColumn<String> get sajdahType => $composableBuilder(
    column: $table.sajdahType,
    builder: (column) => column,
  );
}

class $$SajdahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SajdahsTable,
          Sajdah,
          $$SajdahsTableFilterComposer,
          $$SajdahsTableOrderingComposer,
          $$SajdahsTableAnnotationComposer,
          $$SajdahsTableCreateCompanionBuilder,
          $$SajdahsTableUpdateCompanionBuilder,
          (Sajdah, BaseReferences<_$AppDatabase, $SajdahsTable, Sajdah>),
          Sajdah,
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
                Value<String> verseKey = const Value.absent(),
                Value<String> sajdahType = const Value.absent(),
              }) => SajdahsCompanion(
                sajdahNumber: sajdahNumber,
                verseKey: verseKey,
                sajdahType: sajdahType,
              ),
          createCompanionCallback:
              ({
                Value<int> sajdahNumber = const Value.absent(),
                required String verseKey,
                required String sajdahType,
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
      Sajdah,
      $$SajdahsTableFilterComposer,
      $$SajdahsTableOrderingComposer,
      $$SajdahsTableAnnotationComposer,
      $$SajdahsTableCreateCompanionBuilder,
      $$SajdahsTableUpdateCompanionBuilder,
      (Sajdah, BaseReferences<_$AppDatabase, $SajdahsTable, Sajdah>),
      Sajdah,
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
}
