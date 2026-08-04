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
        // The artwork carries its own gold gradient; the gradient underneath
        // stays as the fallback so the white text keeps its contrast if the
        // image ever fails to resolve.
        gradient: AppColors.hifthHeaderGradient,
        borderRadius: BorderRadius.circular(metrics.headerRadius),
        image: const DecorationImage(
          image: AssetImage(AppImages.hifthTitleBackground),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.hifthHeaderGlow,
            blurRadius: metrics.headerGlowBlur,
            spreadRadius: metrics.headerGlowSpread,
            offset: metrics.headerGlowOffset,
          ),
        ],
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
          // Every surah opens with the basmalah except At-Tawbah (9), and in
          // Al-Fatihah it is verse 1 already — printing it here too would
          // duplicate it.
          if (header.bismillahPre) ...[
            SizedBox(height: metrics.headerBismillahSpacing),
            Image.asset(
              AppImages.hifthBismillah,
              height: metrics.headerBismillahHeight,
              fit: BoxFit.contain,
            ),
          ],
        ],
      ),
    );
  }
}
