import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/app/index.dart';

enum RevelationPlace { makkah, madinah }

class SurahNameCard extends StatelessWidget {
  final String name;
  final String? nameEnglish;

  final String glyph;
  final RevelationPlace revelationPlace;
  final int orderNumber;
  final VoidCallback onTap;

  final Color? prefixIconColor;

  const SurahNameCard({
    super.key,
    required this.name,
    this.nameEnglish,
    required this.glyph,
    required this.revelationPlace,
    required this.orderNumber,
    required this.onTap,
    this.prefixIconColor = AppColors.primaryLight,
    another,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text:
                "$orderNumber ${String.fromCharCode(int.parse(glyph, radix: 16))}",
            style: AppStyles.headline2.bold().copyWith(
              fontFamily: 'SurahNameV4',
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
