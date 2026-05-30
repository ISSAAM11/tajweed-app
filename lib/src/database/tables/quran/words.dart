import 'package:drift/drift.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart'
    show WordLocationConverter;

@DataClassName('WordRow')
class Words extends Table {
  IntColumn get id => integer().named('id')();
  TextColumn get location =>
      text().named('location').map(const WordLocationConverter())();
  IntColumn get surah => integer().named('surah')();
  IntColumn get ayah => integer().named('ayah')();
  IntColumn get word => integer().named('word')();

  /// QPC V2 glyph codes (Arabic Presentation Forms), rendered with the
  /// per-page `QPC-V2-Font-p<page>` fonts. NOT plain Arabic.
  TextColumn get text_ => text().named('glyph_text')();

  /// Plain Arabic spelling of the word (with tashkeel). Used for recitation
  /// matching against speech-to-text, which can't read the glyph codes.
  TextColumn get plainText => text().named('text')();

  @override
  Set<Column> get primaryKey => {id};
}
