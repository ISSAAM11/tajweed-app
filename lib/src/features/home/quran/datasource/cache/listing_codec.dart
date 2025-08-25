import 'dart:convert';

import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/listing/quran_listing_datasource.dart';

class ListingCodec {
  static String toJson(ListingDataDto dto) {
    return jsonEncode({
      'chapters': dto.chapters
          .map(
            (c) => {
              'id': c.id,
              'name': c.name,
              'nameSimple': c.nameSimple,
              'nameArabic': c.nameArabic,
              'revelationOrder': c.revelationOrder,
              'nameGlyph': c.nameGlyph,
              'bismillahPre': c.bismillahPre,
              'revelationPlace': c.revelationPlace.name,
              'versesCount': c.versesCount,
            },
          )
          .toList(),
      'pages': dto.pages
          ?.map(
            (p) => {
              'pageNumber': p.pageNumber,
              'verseKey': p.verseKey.toString(),
              'ayahText': p.ayahText,
            },
          )
          .toList(),
      'juzs': dto.juzs
          ?.map(
            (j) => {
              'juzNumber': j.juzNumber,
              'verseKey': j.verseKey.toString(),
              'ayahText': j.ayahText,
            },
          )
          .toList(),
      'rukus': dto.rukus
          ?.map(
            (r) => {
              'rukuNumber': r.rukuNumber,
              'verseKey': r.verseKey.toString(),
              'ayahText': r.ayahText,
            },
          )
          .toList(),
      'hizbs': dto.hizbs
          ?.map(
            (h) => {
              'juzNumber': h.juzNumber,
              'fraction': h.fraction.index,
              'verseKey': h.verseKey.toString(),
              'ayahText': h.ayahText,
            },
          )
          .toList(),
    });
  }

  static ListingDataDto fromJson(String raw) {
    Debugger.blue('running ListingCodec.fromJson');
    try {
      final m = jsonDecode(raw) as Map<String, dynamic>;
      // Debugger.red('json decoded in listingDataDto $m');

      Debugger.blue('decoded Json from Raw cache');

      List<ChapterRow> chaptersResult = (m['chapters'] as List)
          .map(
            (c) => ChapterRow(
              id: c['id'],
              name: c['name'],
              nameSimple: c['nameSimple'],
              nameArabic: c['nameArabic'],
              revelationOrder: c['revelationOrder'],
              nameGlyph: c['nameGlyph'],
              bismillahPre: c['bismillahPre'],
              revelationPlace: c['revelationPlace'] == 'makkah'
                  ? RevelationPlace.makkah
                  : RevelationPlace.madinah,
              versesCount: c['versesCount'],
            ),
          )
          .toList();
      // pages ************************************************
      List<({String ayahText, int pageNumber, VerseKey verseKey})>?
      pagesResult = (m['pages'] as List?)
          ?.map(
            (p) => (
              pageNumber: p['pageNumber'] as int,
              verseKey: VerseKey.parse(p['verseKey'] as String),
              ayahText: p['ayahText'] as String,
            ),
          )
          .toList();
      Debugger.green('pages decoded ListingCodec.fromJson');
      // Juzs ************************************************

      List<({String ayahText, int juzNumber, VerseKey verseKey})>? juzsResult =
          (m['juzs'] as List?)
              ?.map(
                (j) => (
                  juzNumber: j['juzNumber'] as int,
                  verseKey: VerseKey.parse(j['verseKey'] as String),
                  ayahText: j['ayahText'] as String,
                ),
              )
              .toList();
      Debugger.green('Juzs decoded ListingCodec.fromJson');
      // Rukus ************************************************

      List<({String ayahText, int rukuNumber, VerseKey verseKey})>?
      rukusResult = (m['rukus'] as List?)
          ?.map(
            (r) => (
              rukuNumber: r['rukuNumber'] as int,
              verseKey: VerseKey.parse(r['verseKey'] as String),
              ayahText: r['ayahText'] as String,
            ),
          )
          .toList();
      Debugger.green('Rukus decoded ListingCodec.fromJson');
      // Hizbs ************************************************
      List<
        ({
          String ayahText,
          HizbFraction fraction,
          int juzNumber,
          VerseKey verseKey,
        })
      >?
      hizbsResult = (m['hizbs'] as List?)
          ?.map(
            (h) => (
              juzNumber: h['juzNumber'] as int,
              fraction: HizbFraction.values[h['fraction']],
              verseKey: VerseKey.parse(h['verseKey'] as String),
              ayahText: h['ayahText'] as String,
            ),
          )
          .toList();
      Debugger.green('Hizbs decoded ListingCodec.fromJson');
      //

      final result = ListingDataDto(
        chapters: chaptersResult,
        pages: pagesResult,
        juzs: juzsResult,
        rukus: rukusResult,
        hizbs: hizbsResult,
      );
      Debugger.green('Successfully decoded listing cache');
      return result;
    } on Exception catch (e) {
      Debugger.red('Error decoding listing cache: $e');
      rethrow;
    }
  }
}
