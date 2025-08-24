// ************ helper caching codec
import 'package:generic_requester/generic_requester.dart';
import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/ayah_meta_helper_models.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/helpers/quran_page_datasource.dart';

class PageCodec {
  static String toJson(PageContentDto page) {
    final blocks = page.blocks.map((b) {
      if (b is PageMetaBlockDto) {
        return {
          't': 'meta',
          'juz': b.juz,
          'hizb': b.hizb,
          'ruku': b.ruku,
          'hf': b.hizbFraction?.index,
        };
      } else if (b is SurahHeaderBlockDto) {
        return {
          't': 'surahHeader',
          'chapter': {
            'id': b.chapter.id,
            'nameArabic': b.chapter.nameArabic,
            'nameGlyph': b.chapter.nameGlyph,
            'bismillahPre': b.chapter.bismillahPre,
          },
        };
      } else if (b is BasmalahBlockDto) {
        return {'t': 'basmalah', 'surahId': b.surahId};
      } else if (b is AyahBlockDto) {
        return {
          't': 'ayah',
          'ayah': {
            'g': b.ayah.globalIndex,
            's': b.ayah.surah,
            'a': b.ayah.ayah,
            'p': b.ayah.pageNo,
            'j': b.ayah.juzNo,
            'h': b.ayah.hizbNo,
            'r': b.ayah.rukuNo,
            'hf': b.ayah.hizbFraction.index,
            'sj': b.ayah.hasSajdah,
          },
          'words': b.words
              .map(
                (w) => {
                  'id': w.id,
                  's': w.surah,
                  'a': w.ayah,
                  'w': w.word,
                  't': w.text_,
                },
              )
              .toList(),
        };
      } else if (b is PartitionMarkerBlockDto) {
        return {'t': 'marker', 'mode': b.mode.index, 'pid': b.partitionId};
      }
      throw UnsupportedError('Unknown PageBlock $b');
    }).toList();

    return jsonEncode({'page': page.pageNo, 'blocks': blocks});
  }

  static PageContentDto fromJson(String raw) {
    final m = jsonDecode(raw) as Map<String, dynamic>;
    final pageNo = m['page'] as int;
    final blocks = <PageBlockDto>[];

    for (final o in (m['blocks'] as List)) {
      final t = o['t'] as String;
      switch (t) {
        case 'meta':
          blocks.add(
            PageMetaBlockDto(
              juz: o['juz'] as int?,
              hizb: o['hizb'] as int?,
              ruku: o['ruku'] as int?,
              hizbFraction: (o['hf'] == null)
                  ? null
                  : HizbFraction.values[o['hf'] as int],
            ),
          );
          break;
        case 'surahHeader':
          final c = o['chapter'];
          blocks.add(
            SurahHeaderBlockDto(
              chapter: ChapterHeaderDto(
                id: c['id'],
                nameArabic: c['nameArabic'],
                nameGlyph: c['nameGlyph'],
                bismillahPre: c['bismillahPre'],
              ),
            ),
          );
          break;
        case 'basmalah':
          blocks.add(BasmalahBlockDto(surahId: o['surahId']));
          break;
        case 'ayah':
          final a = o['ayah'];
          final ayah = AyahMetaRow(
            globalIndex: a['g'],
            surah: a['s'],
            ayah: a['a'],
            pageNo: a['p'],
            juzNo: a['j'],
            hizbNo: a['h'],
            rukuNo: a['r'],
            hizbFraction: HizbFraction.values[a['hf']],
            hasSajdah: a['sj'],
          );
          final words = (o['words'] as List)
              .map(
                (w) => WordRow(
                  id: w['id'],
                  location: WordLocation(w['s'], w['a'], w['w']),
                  surah: w['s'],
                  ayah: w['a'],
                  word: w['w'],
                  text_: w['t'],
                ),
              )
              .toList();

          blocks.add(AyahBlockDto(ayah: ayah, words: words));
          break;
        case 'marker':
          blocks.add(
            PartitionMarkerBlockDto(
              mode: PartitionMode.values[o['mode']],
              partitionId: o['pid'],
            ),
          );
          break;
        default:
          throw UnsupportedError('Unknown block type $t');
      }
    }

    return PageContentDto(pageNo: pageNo, blocks: blocks);
  }
}
