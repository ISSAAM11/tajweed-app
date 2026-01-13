import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/widgets/surah_name_card.dart';
import 'package:tajweed_ai/src/helpers/quran_text_parser.dart';

class QuranListView extends StatelessWidget {
  final int itemCount;
  final List<PartitionItem> items;
  final PartitionMode selectedViewMode;
  final Widget? header; // new optional header
  void Function({required VerseKey verseKey, required PartitionMode mode})
  onTap;
  QuranListView({
    super.key,
    required this.itemCount,
    required this.items,
    required this.selectedViewMode,
    required this.onTap,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header outside ListView
        if (header != null) header!,

        // ListView without header
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
                child: Divider(thickness: 1, color: Colors.grey.shade300),
              );
            },
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final item = items[index];

              if (item is ChapterItem) return _buildSurahItem(item, index);

              return _buildPartitionItem(item, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSurahItem(ChapterItem chapterItem, int index) {
    return SurahNameCard(
      name: chapterItem.nameArabic,
      nameEnglish: chapterItem.nameSimple,
      glyph: chapterItem.nameGlyph,
      versesCount: chapterItem.versesCount,
      revelationPlace: chapterItem.revelationPlace,
      orderNumber: chapterItem.id,
      onTap: () => onTap(
        verseKey: VerseKey(chapterItem.id, 1),
        mode: PartitionMode.page,
      ),
    );
  }

  Widget _buildPartitionItem(PartitionItem item, int index) {
    final String label = _getPartitionLabel(item);

    // Process ayah words
    final parsedWords = QuranTextParser.stripRulesList(item.ayahWords);
    final noNumbers = QuranTextParser.removeAyahNumbersList(parsedWords);
    final itemWordList = QuranTextParser.cutWordsAtFirstWaqf(noNumbers);
    final previewText = itemWordList.join('\u00A0');

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      leading: Text(
        label,
        style: AppFonts.uthmanicHafsFont.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.primary,
        ),
      ),

      subtitle: Text(
        previewText,
        style: AppFonts.uthmanicHafsFont
            .withColor(AppColors.greyDark)
            .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
        textDirection: TextDirection.rtl,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      onTap: () => _handlePartitionTap(item),
    );
  }

  String _getPartitionLabel(PartitionItem item) {
    if (item is JuzItem) return 'Juz. ${item.juzNumber}';
    if (item is PageItem) return 'Page. ${item.pageNumber}';
    if (item is RukuItem) return 'Ruku. ${item.rukuNumber}';
    if (item is HizbItem)
      return '${item.fraction.label} Hizb. ${item.juzNumber}';
    return 'Partition';
  }

  void _handlePartitionTap(PartitionItem item) {
    if (item is PageItem)
      onTap(mode: PartitionMode.page, verseKey: item.verseKey);
    if (item is JuzItem)
      onTap(mode: PartitionMode.page, verseKey: item.verseKey);
    if (item is RukuItem)
      onTap(mode: PartitionMode.page, verseKey: item.verseKey);
    if (item is HizbItem)
      onTap(mode: PartitionMode.page, verseKey: item.verseKey);
  }
}
