import 'dart:convert';

import 'package:drift/drift.dart';

/// --- Enums ---
enum RevelationPlace { makkah, madinah }

enum SajdahType { recommended, obligatory }

enum HizbFraction {
  full(''),
  quarter('1/4'),
  half('1/2'),
  threeQuarter('3/4');

  final String label;
  const HizbFraction(this.label);
}

enum PartitionMode {
  surah('Surah'),
  page('Page'),
  juz('Juz'),
  hizb('Hizb'),
  ruku("Ruku");

  final String label;
  const PartitionMode(this.label);
}

/// --- Converters ---
class BoolIntConverter extends TypeConverter<bool, int> {
  const BoolIntConverter();
  @override
  bool fromSql(int fromDb) => fromDb == 1;
  @override
  int toSql(bool value) => value ? 1 : 0;
}

class RevelationPlaceConverter extends TypeConverter<RevelationPlace, String> {
  const RevelationPlaceConverter();
  @override
  RevelationPlace fromSql(String fromDb) =>
      RevelationPlace.values.firstWhere((e) => e.name == fromDb);
  @override
  String toSql(RevelationPlace value) => value.name;
}

class SajdahTypeConverter extends TypeConverter<SajdahType, String> {
  const SajdahTypeConverter();
  @override
  SajdahType fromSql(String fromDb) =>
      SajdahType.values.firstWhere((e) => e.name == fromDb);
  @override
  String toSql(SajdahType value) => value.name;
}

/// --- Value objects ---
class VerseKey {
  final int surah;
  final int ayah;
  VerseKey(this.surah, this.ayah);
  factory VerseKey.parse(String key) {
    final parts = key.split(':');
    return VerseKey(int.parse(parts[0]), int.parse(parts[1]));
  }
  @override
  String toString() => '$surah:$ayah';
}

class VerseRange {
  final int start;
  final int end;
  VerseRange(this.start, this.end);
  factory VerseRange.parse(String raw) {
    final parts = raw.split('-');
    return VerseRange(int.parse(parts[0]), int.parse(parts[1]));
  }
}

class SurahRanges {
  final Map<int, VerseRange> ranges;
  SurahRanges(this.ranges);
  factory SurahRanges.parse(Map<String, dynamic> json) {
    return SurahRanges({
      for (final entry in json.entries)
        int.parse(entry.key): VerseRange.parse(entry.value as String),
    });
  }
}

class SurahRangesConverter extends TypeConverter<SurahRanges, String> {
  const SurahRangesConverter();
  @override
  SurahRanges fromSql(String fromDb) =>
      SurahRanges.parse(jsonDecode(fromDb) as Map<String, dynamic>);
  @override
  String toSql(SurahRanges value) => jsonEncode({
    for (final e in value.ranges.entries)
      e.key.toString(): '${e.value.start}-${e.value.end}',
  });
}

class VerseKeyConverter extends TypeConverter<VerseKey, String> {
  const VerseKeyConverter();
  @override
  VerseKey fromSql(String fromDb) => VerseKey.parse(fromDb);
  @override
  String toSql(VerseKey value) => value.toString();
}

class WordLocation {
  final int surah;
  final int ayah;
  final int wordIndex;
  WordLocation(this.surah, this.ayah, this.wordIndex);
  factory WordLocation.parse(String raw) {
    final parts = raw.split(':');
    return WordLocation(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }
}

class WordLocationConverter extends TypeConverter<WordLocation, String> {
  const WordLocationConverter();
  @override
  WordLocation fromSql(String fromDb) => WordLocation.parse(fromDb);
  @override
  String toSql(WordLocation value) =>
      '${value.surah}:${value.ayah}:${value.wordIndex}';
}

const hizbFractionValues = {
  HizbFraction.full: 0,
  HizbFraction.quarter: 1,
  HizbFraction.half: 2,
  HizbFraction.threeQuarter: 3,
};

class HizbFractionConverter extends TypeConverter<HizbFraction, int> {
  const HizbFractionConverter();

  @override
  HizbFraction fromSql(int fromDb) {
    return hizbFractionValues.entries.firstWhere((e) => e.value == fromDb).key;
  }

  @override
  int toSql(HizbFraction value) => hizbFractionValues[value]!;
}
