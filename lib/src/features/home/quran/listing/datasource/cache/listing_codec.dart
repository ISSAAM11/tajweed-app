import 'dart:convert';

import 'package:tajweed_ai/src/features/home/quran/listing/datasource/quran_listing_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';

class ListingCodec {
  static String toJson(ListingDataDto dto) {
    return jsonEncode({
      'chapters': dto.chapters.map((c) => c.toMap()).toList(),
      'pages': dto.pages.map((p) => p.toMap()).toList(),
      'juzs': dto.juzs.map((j) => j.toMap()).toList(),
      'rukus': dto.rukus.map((r) => r.toMap()).toList(),
      'hizbs': dto.hizbs.map((h) => h.toMap()).toList(),
    });
  }

  static ListingDataDto fromJson(String raw) {
    final m = jsonDecode(raw) as Map<String, dynamic>;

    final chaptersResult = (m['chapters'] as List)
        .map((c) => ChapterItem.fromMap(c as Map<String, dynamic>))
        .toList();

    final pagesResult = (m['pages'] as List)
        .map((p) => PageItem.fromMap(p as Map<String, dynamic>))
        .toList();

    final juzsResult = (m['juzs'] as List)
        .map((j) => JuzItem.fromMap(j as Map<String, dynamic>))
        .toList();

    final rukusResult = (m['rukus'] as List)
        .map((r) => RukuItem.fromMap(r as Map<String, dynamic>))
        .toList();

    final hizbsResult = (m['hizbs'] as List)
        .map((h) => HizbItem.fromMap(h as Map<String, dynamic>))
        .toList();

    return ListingDataDto(
      chapters: chaptersResult,
      pages: pagesResult,
      juzs: juzsResult,
      rukus: rukusResult,
      hizbs: hizbsResult,
    );
  }
}
