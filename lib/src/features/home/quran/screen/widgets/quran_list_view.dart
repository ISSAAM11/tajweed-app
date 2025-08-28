import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/common/widget/simple_parser.dart';
import 'package:tajweed_ai/src/features/home/quran/screen/widgets/surah_name_card.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_model_helper.dart';

class QuranListView extends StatelessWidget {
  final int itemCount;
  final List<PartitionItem> items;
  final PartitionMode selectedViewMode;
  void Function({
    required int partitionId,
    required PartitionMode mode,
    HizbFraction? fraction,
  })
  onTap;
  QuranListView({
    super.key,
    required this.itemCount,
    required this.items,
    required this.selectedViewMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final item = items[index];

        if (item is ChapterItem) {
          return _buildSurahItem(item, index);
        }
        return _buildPartitionItem(item, index);
      },
    );
  }

  Widget _buildSurahItem(ChapterItem chapterItem, int index) {
    return SurahNameCard(
      name: chapterItem.nameArabic,
      nameEnglish: chapterItem.name,
      glyph: chapterItem.nameGlyph,
      revelationPlace: chapterItem.revelationPlace,
      orderNumber: chapterItem.id,
      onTap: () =>
          onTap(mode: PartitionMode.surah, partitionId: chapterItem.id),
    );
  }

  Widget _buildPartitionItem(PartitionItem item, int index) {
    final String label = _getPartitionLabel(item);

    return ListTile(
      leading: Text(label),
      // title: Text(item.ayahText),
      title: SimpleParser(
        item.ayahText,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,

          fontFamily: 'UthmanicHafs',
        ),
      ),
      onTap: () => _handlePartitionTap(item),
    );
  }

  String _getPartitionLabel(PartitionItem item) {
    if (item is JuzItem) return 'Juz. ${item.juzNumber}';
    if (item is PageItem) return 'Page. ${item.pageNumber}';
    if (item is RukuItem) return 'Ruku. ${item.rukuNumber}';
    if (item is HizbItem)
      return 'Hizb. ${item.juzNumber} fraction ${item.fraction}';
    return 'Partition';
  }

  void _handlePartitionTap(PartitionItem item) {
    if (item is PageItem)
      onTap(mode: PartitionMode.page, partitionId: item.pageNumber);
    if (item is JuzItem)
      onTap(mode: PartitionMode.juz, partitionId: item.juzNumber);
    if (item is RukuItem)
      onTap(mode: PartitionMode.ruku, partitionId: item.rukuNumber);
    if (item is HizbItem)
      onTap(
        mode: PartitionMode.juz,
        partitionId: item.juzNumber,
        fraction: item.fraction,
      );
  }
}
