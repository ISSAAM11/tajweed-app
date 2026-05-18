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
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "$orderNumber",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$nameEnglish",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "${revelationPlace.name}, ayah $versesCount",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              // Right side: Arabic name (RTL)
              Text(
                String.fromCharCode(int.parse(glyph, radix: 16)),
                style: AppFonts.surahNamesFont.bold().copyWith(
                  fontSize: 20,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
