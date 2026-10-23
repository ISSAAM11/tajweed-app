import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/app/design/colors/app_colors.dart';
import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

class QuranLineText extends StatelessWidget {
  final int pageNo;
  final List<WordRow> lineWords;
  final bool isCentered;
  final Function(int surah, int ayahNumber, Offset position)? onAyahTap;
  final int? selectedAyah;
  final int? selectedSurah;
  final VerseKey? playingVerse;

  const QuranLineText({
    super.key,
    required this.lineWords,
    this.pageNo = 1,
    this.isCentered = false,
    this.onAyahTap,
    this.selectedAyah,
    this.selectedSurah,
    this.playingVerse,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveHorizentalPadding = screenWidth * 0.03;
    final responsivefontSize = screenWidth * 0.050;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    TextStyle baseTextStyle = TextStyle(
      fontSize: responsivefontSize,
      fontFamily: 'QPC-V2-Font-p$pageNo',
      color: isDark ? AppColors.darkTextPrimary : AppColors.black,
    );

    if (lineWords.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: responsiveHorizentalPadding),
      child: _buildLineWithSpacing(lineWords, baseTextStyle),
    );
  }

  Widget _buildLineWithSpacing(List<WordRow> words, TextStyle baseStyle) {
    final wordWidgets = <Widget>[];

    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      final isSelected =
          selectedAyah == word.ayah && selectedSurah == word.surah;
      final isPlaying =
          playingVerse != null &&
          playingVerse!.surah == word.surah &&
          playingVerse!.ayah == word.ayah;
      final highlightColor = isPlaying
          ? AppColors.primary.withValues(alpha: 0.18)
          : isSelected
          ? AppColors.ayahHighlight
          : AppColors.transparent;

      wordWidgets.add(
        GestureDetector(
          onTapDown: (details) {
            if (onAyahTap != null) {
              onAyahTap!(word.surah, word.ayah, details.globalPosition);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: highlightColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(word.text_, style: baseStyle),
          ),
        ),
      );

      if (isCentered) {
        if (i < words.length - 1) {
          wordWidgets.add(const Text(' '));
        }
      }
    }

    return Row(
      mainAxisAlignment: isCentered
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: wordWidgets,
    );
  }
}
