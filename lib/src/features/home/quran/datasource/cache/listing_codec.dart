import 'dart:convert';

import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/listing/quran_listing_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_model_helper.dart';

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
          .map(
            (p) => {
              'pageNumber': p.pageNumber,
              'verseKey': p.verseKey.toString(),
              'ayahText': p.ayahText,
            },
          )
          .toList(),
      'juzs': dto.juzs
          .map(
            (j) => {
              'juzNumber': j.juzNumber,
              'verseKey': j.verseKey.toString(),
              'ayahText': j.ayahText,
            },
          )
          .toList(),
      'rukus': dto.rukus
          .map(
            (r) => {
              'rukuNumber': r.rukuNumber,
              'verseKey': r.verseKey.toString(),
              'ayahText': r.ayahText,
            },
          )
          .toList(),
      'hizbs': dto.hizbs
          .map(
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
    final m = jsonDecode(raw) as Map<String, dynamic>;

    List<ChapterItem> chaptersResult = (m['chapters'] as List)
        .map(
          (c) => ChapterItem(
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
            verseKey: VerseKey(c['id'], 1),
            ayahText:
                '', // Placeholder, as chapters don't have a specific ayah text
          ),
        )
        .toList();
    // pages ************************************************
    List<PageItem> pagesResult = (m['pages'] as List)
        .map(
          (p) => PageItem(
            pageNumber: p['pageNumber'] as int,
            verseKey: VerseKey.parse(p['verseKey'] as String),
            ayahText: p['ayahText'] as String,
          ),
        )
        .toList();

    // Juzs ************************************************

    List<JuzItem>? juzsResult = (m['juzs'] as List)
        .map(
          (j) => JuzItem(
            juzNumber: j['juzNumber'] as int,
            verseKey: VerseKey.parse(j['verseKey'] as String),
            ayahText: j['ayahText'] as String,
          ),
        )
        .toList();

    // Rukus ************************************************

    List<RukuItem>? rukusResult = (m['rukus'] as List)
        .map(
          (r) => RukuItem(
            rukuNumber: r['rukuNumber'] as int,
            verseKey: VerseKey.parse(r['verseKey'] as String),
            ayahText: r['ayahText'] as String,
          ),
        )
        .toList();

    List<HizbItem>? hizbsResult = (m['hizbs'] as List)
        .map(
          (h) => HizbItem(
            juzNumber: h['juzNumber'] as int,
            fraction: HizbFraction.values[h['fraction']],
            verseKey: VerseKey.parse(h['verseKey'] as String),
            ayahText: h['ayahText'] as String,
          ),
        )
        .toList();

    final result = ListingDataDto(
      chapters: chaptersResult,
      pages: pagesResult,
      juzs: juzsResult,
      rukus: rukusResult,
      hizbs: hizbsResult,
    );

    return result;
  }
}
