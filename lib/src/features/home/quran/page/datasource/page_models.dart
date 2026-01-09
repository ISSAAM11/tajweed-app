import 'package:generic_requester/generic_requester.dart';
import 'package:tajweed_ai/src/database/app_database.dart'
    show WordRow, AyahMetaRow, ChapterRow, PageLineRow;
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
  ChapterHeaderDto.fromChapterRow(ChapterRow row)
    : id = row.id,
      nameArabic = row.nameArabic,
      nameGlyph = row.nameGlyph,
      bismillahPre = row.bismillahPre,
      revelationPlace = row.revelationPlace;
}

class PageLinesDto {
  final int pageNumber;
  final int lineNumber;
  final String lineType;
  final bool isCentered;
  final int? firstWordId;
  final int? lastWordId;
  final int? surahNumber;

  PageLinesDto({
    required this.pageNumber,
    required this.lineNumber,
    required this.lineType,
    required this.isCentered,
    this.firstWordId,
    this.lastWordId,
    this.surahNumber,
  });

  PageLinesDto.fromPageLineRow(PageLineRow row)
    : pageNumber = row.pageNumber,
      lineNumber = row.lineNumber,
      lineType = row.lineType,
      isCentered = row.isCentered,
      firstWordId = row.firstWordId,
      lastWordId = row.lastWordId,
      surahNumber = row.surahNumber;
}

abstract class PageBlockDto {}

class SurahHeaderBlockDto extends PageBlockDto {
  final ChapterHeaderDto chapter;
  SurahHeaderBlockDto({required this.chapter});
}

class LineWordsBlockDto extends PageBlockDto {
  final List<WordRow> lineWords;
  final bool isCentered;
  LineWordsBlockDto({required this.lineWords, required this.isCentered});
}

class PageAyatsBlockDto extends PageBlockDto {
  final List<List<WordRow>> pageAyahs;
  PageAyatsBlockDto({required this.pageAyahs});
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
  // Getter for pageNo
  int get getPageNo => pageNo;

  // Getter for blocks
  List<PageBlockDto> get getBlocks => blocks;
}

class PartitionSnapshot {
  final int totalSurahs;

  final int totalPage;

  // Partition → page list
  final Map<int, List<int>> pagesBySurah;

  // Page → partition (reverse map)
  final Map<int, int> pageToSurah;

  PartitionSnapshot({
    required this.totalSurahs,

    required this.totalPage,
    required this.pagesBySurah,

    required this.pageToSurah,
  });

  /// Factory constructor to generate snapshot from pagesBy* maps
  /// Get partitionId for a given page in the given mode
  int pageToPartition(int pageNo) {
    return pageNo; // identity: partition == page
  }

  /// Get all pages belonging to a partition in the given mode
  int pageByMode(int partitionId) {
    return partitionId; // a single page
  }

  List<int> uiKeysByMode(PartitionMode mode) {
    switch (mode) {
      case PartitionMode.page:
        return List<int>.generate(totalPage, (i) => i + 1);
      case PartitionMode.juz:
        return [];
      case PartitionMode.hizb:
        return [];
      case PartitionMode.ruku:
        return [];
      case PartitionMode.surah:
        return pagesBySurah.keys.toList();
    }
  }
}

/// Model for API response containing page title
final class PageTitleModel extends ModelingProtocol {
  final String title;

  PageTitleModel({required this.title});

  factory PageTitleModel.empty() => PageTitleModel(title: '');

  @override
  PageTitleModel fromJson(json) {
    return PageTitleModel(title: json?['title'] as String? ?? '');
  }

  @override
  List<Object?> get props => [title];
}
