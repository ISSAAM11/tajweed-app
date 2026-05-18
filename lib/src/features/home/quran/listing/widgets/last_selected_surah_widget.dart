import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/app/index.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';

class LastSelectedSurahWidget extends StatelessWidget {
  final LastSelectedPage? lastSurah;
  final VoidCallback? onContinue;

  const LastSelectedSurahWidget({
    super.key,
    required this.lastSurah,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    if (lastSurah == null) return const SizedBox.shrink();

    final metrics = AppMetrics.lastSelectedSurahWidget;

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
                        "Last read",
                        style: AppFonts.lato
                            .withSize(FontSizes.indication)
                            .withColor(AppColors.greyDarkest)
                            .medium(),
                      ),
                    ],
                  ),
                  SizedBox(height: metrics.columnSpacing),
                  Text(
                    lastSurah!.name,
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
                        TextSpan(text: "Page No: "),
                        TextSpan(text: "${lastSurah!.pageNumber}"),
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
                      backgroundColor: Colors.white,
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
                          "Continue",
                          style: AppFonts.lato
                              .withSize(FontSizes.caption)
                              .withColor(AppColors.greyDarkest)
                              .regular(),
                        ),
                        SizedBox(width: metrics.buttonIconSpacing),
                        Icon(
                          Icons.arrow_forward,
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
