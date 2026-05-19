import 'package:flutter/material.dart';
import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/index.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';

class LastReadingCard extends StatelessWidget {
  final LastSelectedPage lastSelected;
  final VoidCallback onContinue;

  const LastReadingCard({
    super.key,
    required this.lastSelected,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.lastSelectedSurahWidget;
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final surahName = isArabic ? lastSelected.nameArabic : lastSelected.name;

    return Container(
      height: metrics.height,
      padding: metrics.containerPadding,
      margin: metrics.margin,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        image: DecorationImage(
          image: AssetImage(AppImages.backgroundLastRead),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(metrics.borderRadius),
      ),
      child: Padding(
        padding: metrics.contentPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.lastReadIcon,
                        width: metrics.lastReadIconSize,
                        height: metrics.lastReadIconSize,
                      ),
                      SizedBox(width: metrics.iconTextSpacing),
                      Text(
                        l10n.lastReadingLabel,
                        style: AppFonts.lato
                            .withSize(FontSizes.indication)
                            .withColor(AppColors.greyDarkest)
                            .medium(),
                      ),
                    ],
                  ),
                  SizedBox(height: metrics.columnSpacing),
                  Text(
                    surahName,
                    style: AppFonts.lato
                        .withSize(FontSizes.headline4)
                        .withColor(AppColors.greyDarkest)
                        .semiBold(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: metrics.columnSpacing),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: '${l10n.verseNumberLabel}: '),
                        TextSpan(text: '${lastSelected.verseKey.ayah}'),
                      ],
                    ),
                    style: AppFonts.lato
                        .withSize(FontSizes.subtitle)
                        .withColor(AppColors.greyDarkest)
                        .regular(),
                  ),
                  SizedBox(height: metrics.columnSpacing),
                  ElevatedButton(
                    onPressed: onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.scaffold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          metrics.buttonBorderRadius,
                        ),
                      ),
                      padding: metrics.buttonPadding,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.continueReadingLabel,
                          style: AppFonts.lato
                              .withSize(FontSizes.caption)
                              .withColor(AppColors.greyDarkest)
                              .regular(),
                        ),
                        SizedBox(width: metrics.buttonIconSpacing),
                        Icon(
                          isArabic ? Icons.arrow_back : Icons.arrow_forward,
                          color: AppColors.greyDarkest,
                          size: metrics.continueButtonIconSize,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: metrics.iconTextSpacing),
            SizedBox(
              width: metrics.quranImageSize,
              child: Image.asset(AppImages.quranImage, fit: BoxFit.contain),
            ),
          ],
        ),
      ),
    );
  }
}
