import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/app/index.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

class SurahNameCard extends StatelessWidget {
  final String name;
  final String? nameEnglish;
  final String glyph;
  final RevelationPlace revelationPlace;
  final int orderNumber;
  final int versesCount;
  void Function() onTap;

  final Color? prefixIconColor;

  SurahNameCard({
    super.key,
    required this.name,
    this.nameEnglish,
    required this.glyph,
    required this.revelationPlace,
    required this.orderNumber,
    required this.versesCount,
    required this.onTap,
    this.prefixIconColor = AppColors.primaryLight,
    another,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.surahNameCard;

    return Card(
      color: AppColors.transparent,
      shadowColor: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: metrics.cardPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: metrics.numberContainerSize,
                    width: metrics.numberContainerSize,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.surahNumberBackground),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Text(
                      "$orderNumber",
                      style: AppFonts.poppins
                          .withSize(metrics.numberFontSize)
                          .withColor(AppColors.greyDarkest)
                          .bold(),
                    ),
                  ),
                  SizedBox(width: metrics.numberTextSpacing),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$nameEnglish",
                        style: AppFonts.poppins
                            .withSize(metrics.englishNameFontSize)
                            .withColor(AppColors.black)
                            .semiBold(),
                      ),
                      Text(
                        "${revelationPlace.name}, ayah $versesCount",
                        style: AppFonts.poppins
                            .withSize(metrics.metadataFontSize)
                            .withColor(AppColors.greyMedium)
                            .medium(),
                      ),
                    ],
                  ),
                ],
              ),
              // Right side: Arabic name (RTL)
              Text(
                String.fromCharCode(int.parse(glyph, radix: 16)),
                style: AppFonts.surahNamesFont
                    .bold()
                    .withSize(metrics.arabicNameFontSize)
                    .withColor(AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
