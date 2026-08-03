import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';

/// Gold gradient card at the top of the hifth screen: surah name, Arabic
/// name, and revelation place / verse count.
class HifthSurahHeader extends StatelessWidget {
  final ChapterHeaderDto header;

  const HifthSurahHeader({required this.header, super.key});

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.hifthScreen;
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final displayName = isArabic ? header.nameArabic : header.nameSimple;
    final placeLabel = switch (header.revelationPlace) {
      RevelationPlace.makkah => l10n.revelationMakkah,
      RevelationPlace.madinah => l10n.revelationMadinah,
    };

    return Container(
      width: double.infinity,
      margin: metrics.headerMargin,
      padding: metrics.headerPadding,
      decoration: BoxDecoration(
        gradient: AppColors.hifthHeaderGradient,
        borderRadius: BorderRadius.circular(metrics.headerRadius),
      ),
      child: Column(
        children: [
          Text(
            displayName,
            textAlign: TextAlign.center,
            style: AppFonts.poppins
                .withSize(FontSizes.headline1)
                .withColor(AppColors.scaffold),
          ),
          if (!isArabic) ...[
            SizedBox(height: metrics.headerNameSpacing),
            Text(
              header.nameArabic,
              textAlign: TextAlign.center,
              style: AppFonts.uthmanicHafsFont
                  .withSize(FontSizes.title)
                  .withColor(AppColors.scaffold),
            ),
          ],
          SizedBox(height: metrics.headerDividerSpacing),
          const Divider(color: AppColors.hifthHeaderDivider, height: 1),
          SizedBox(height: metrics.headerDividerSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                placeLabel.toUpperCase(),
                style: AppFonts.poppins
                    .withSize(FontSizes.subtitle)
                    .withColor(AppColors.scaffold),
              ),
              SizedBox(width: metrics.headerMetaGap),
              Container(
                width: metrics.headerMetaDotSize,
                height: metrics.headerMetaDotSize,
                decoration: const BoxDecoration(
                  color: AppColors.hifthHeaderDivider,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: metrics.headerMetaGap),
              Text(
                l10n.versesCount(header.versesCount).toUpperCase(),
                style: AppFonts.poppins
                    .withSize(FontSizes.subtitle)
                    .withColor(AppColors.scaffold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
