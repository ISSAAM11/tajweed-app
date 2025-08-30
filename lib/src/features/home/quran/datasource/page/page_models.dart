import 'package:tajweed_ai/src/database/app_database.dart'
    show WordRow, AyahMetaRow;
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

class ChapterHeaderDto {
  final int id;
  final String nameArabic;
  final String nameGlyph;
  final bool bismillahPre;
  final RevelationPlace revelationPlace;
  ChapterHeaderDto({
    required this.id,
    required this.nameArabic,
    required this.nameGlyph,
    required this.bismillahPre,
    required this.revelationPlace,
  });
}

abstract class PageBlockDto {}

class SurahHeaderBlockDto extends PageBlockDto {
  final ChapterHeaderDto chapter;
  SurahHeaderBlockDto({required this.chapter});
}

class BasmalahBlockDto extends PageBlockDto {
  final int surahId;
  BasmalahBlockDto({required this.surahId});
}

class PageMetaBlockDto extends PageBlockDto {
  final int? juz;
  final int? hizb;
  final int? ruku;
  final HizbFraction? hizbFraction;
  PageMetaBlockDto({this.juz, this.hizb, this.ruku, this.hizbFraction});
}

class AyahBlockDto extends PageBlockDto {
  final AyahMetaRow ayah;
  final List<WordRow> words;

  AyahBlockDto({required this.ayah, required this.words});
}

class PartitionMarkerBlockDto extends PageBlockDto {
  final PartitionMode mode;
  final int partitionId;
  PartitionMarkerBlockDto({required this.mode, required this.partitionId});
}

class PageContentDto {
  final int pageNo;
  final List<PageBlockDto> blocks;
  PageContentDto({required this.pageNo, required this.blocks});
}
