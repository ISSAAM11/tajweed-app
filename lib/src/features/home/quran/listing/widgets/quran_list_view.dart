import 'package:tajweed_ai/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final dividerColor = Theme.of(context).colorScheme.outlineVariant;
    return Column(
      children: [
        if (header != null) header!,

        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
                child: Divider(thickness: 1, color: dividerColor),
              );
            },
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final item = items[index];

              if (item is ChapterItem) return _buildSurahItem(item, index);

              return _buildPartitionItem(context, item, index, l10n);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSurahItem(ChapterItem chapterItem, int index) {
    return SurahNameCard(
      nameArabic: chapterItem.nameArabic,
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

  Widget _buildPartitionItem(
    BuildContext context,
    PartitionItem item,
    int index,
    AppLocalizations l10n,
  ) {
    final String label = _getPartitionLabel(item, l10n);
    final int pageNumber = _getPartitionPageNumber(item);

    // Process ayah words
    final parsedWords = QuranTextParser.stripRulesList(item.ayahWords);
    final noNumbers = QuranTextParser.removeAyahNumbersList(parsedWords);
    final itemWordList = QuranTextParser.cutWordsAtFirstWaqf(noNumbers);
    final previewText = itemWordList.join('\u00A0');

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      leading: Text(
        label,
        style: AppFonts.poppins.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: AppColors.primary,
        ),
      ),

      subtitle: Text(
        previewText,
        style: TextStyle(
          fontFamily: 'QPC-V2-Font-p$pageNumber',
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        textDirection: TextDirection.rtl,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      onTap: () => _handlePartitionTap(item),
    );
  }

  String _getPartitionLabel(PartitionItem item, AppLocalizations l10n) {
    if (item is JuzItem) return '${l10n.partitionJuz} ${item.juzNumber}';
    if (item is PageItem) return '${l10n.partitionPage} ${item.pageNumber}';
    if (item is RukuItem) return '${l10n.partitionRuku} ${item.rukuNumber}';
    if (item is HizbItem) {
      return '${item.fraction.label} ${l10n.partitionHizb} ${item.juzNumber}';
    }
    return '';
  }

  int _getPartitionPageNumber(PartitionItem item) {
    if (item is PageItem) return item.pageNumber;
    if (item is JuzItem) return item.pageNumber;
    if (item is HizbItem) return item.pageNumber;
    if (item is RukuItem) return item.pageNumber;
    return 1;
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
