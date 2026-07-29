import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/app/design/colors/app_colors.dart';
import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/recitation/quran_recitation_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/recitation_test/data/models/word_verdict_model.dart';

class QuranLineText extends StatelessWidget {
  final int pageNo;
  final List<WordRow> lineWords;
  final bool isCentered;
  final Function(int surah, int ayahNumber, Offset position)? onAyahTap;
  final int? selectedAyah;
  final int? selectedSurah;
  final VerseKey? playingVerse;

  /// Ayahs the user marked, as `"surah:ayah"` keys (see `MarkedAyahService`).
  final Set<String> markedAyahs;

  const QuranLineText({
    super.key,
    required this.lineWords,
    this.pageNo = 1,
    this.isCentered = false,
    this.onAyahTap,
    this.selectedAyah,
    this.selectedSurah,
    this.playingVerse,
    this.markedAyahs = const {},
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveHorizentalPadding = screenWidth * 0.03;
    final responsivefontSize = screenWidth * 0.048;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    TextStyle baseTextStyle = TextStyle(
      fontSize: responsivefontSize,
      fontFamily: 'QPC-V2-Font-p$pageNo',
      color: isDark ? AppColors.darkTextPrimary : AppColors.black,
      height: isCentered ? 2 : 1,
    );

    if (lineWords.isEmpty) {
      return const SizedBox.shrink();
    }

    // Live recitation verdicts (null-safe if the recitation bloc isn't in the
    // tree, e.g. when this widget is reused outside the Quran page).
    QuranRecitationState? recitation;
    try {
      recitation = context.watch<QuranRecitationBloc>().state;
    } catch (_) {
      recitation = null;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: responsiveHorizentalPadding),
      child: _buildLineWithSpacing(
        lineWords,
        baseTextStyle,
        recitation,
        isDark,
      ),
    );
  }

  Widget _buildLineWithSpacing(
    List<WordRow> words,
    TextStyle baseStyle,
    QuranRecitationState? recitation,
    bool isDark,
  ) {
    final children = <Widget>[];
    // Memorization aid: hide the page text, revealing each word only once it
    // has a verdict (then in its verdict color).
    final hideActive =
        recitation != null && recitation.modeActive && recitation.hideText;

    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      final isRunStart = i == 0 || !_sameAyah(words[i - 1], word);
      final isRunEnd = i == words.length - 1 || !_sameAyah(words[i + 1], word);

      children.add(
        _buildWord(
          word,
          baseStyle,
          recitation,
          isDark,
          hideActive,
          isRunStart: isRunStart,
          isRunEnd: isRunEnd,
        ),
      );

      // Gap after this word (none after the last word). The gap is a live,
      // highlighted widget tied to an ayah so the space between words is both
      // tappable and painted as part of the ayah's continuous highlight bar.
      if (i == words.length - 1) continue;
      final next = words[i + 1];
      final sameGap = _sameAyah(word, next);

      if (isCentered) {
        // Centered lines keep their natural (centered) width; spacers are a
        // fixed glyph-space wide but still live + highlighted for continuity.
        children.add(
          _centeredSpacer(word, baseStyle, recitation, isDark, hideActive),
        );
        if (!sameGap) {
          children.add(
            _centeredSpacer(next, baseStyle, recitation, isDark, hideActive),
          );
        }
      } else {
        // Full-width lines: Expanded spacers reproduce spaceBetween's even
        // distribution while owning the gap. Same-ayah gap -> one flex-2
        // spacer; ayah boundary -> two flex-1 halves, one per side.
        if (sameGap) {
          children.add(
            _flexSpacer(
              word,
              baseStyle,
              recitation,
              isDark,
              hideActive,
              flex: 2,
            ),
          );
        } else {
          children.add(
            _flexSpacer(
              word,
              baseStyle,
              recitation,
              isDark,
              hideActive,
              flex: 1,
            ),
          );
          children.add(
            _flexSpacer(
              next,
              baseStyle,
              recitation,
              isDark,
              hideActive,
              flex: 1,
            ),
          );
        }
      }
    }

    return Row(
      // With Expanded children consuming the slack, alignment is irrelevant on
      // full-width lines; `start` is the honest declaration. Centered lines
      // have no Expanded, so `center` still applies.
      mainAxisAlignment: isCentered
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: children,
    );
  }

  bool _sameAyah(WordRow a, WordRow b) =>
      a.surah == b.surah && a.ayah == b.ayah;

  /// Highlight (box) color for [word]: hide-mode grey > playing > selected >
  /// marked > transparent. Shared by word boxes and the gap spacers so a
  /// selected / playing / hidden / marked ayah paints as one continuous bar.
  Color _highlightColorFor(
    WordRow word,
    QuranRecitationState? recitation,
    bool isDark,
    bool hideActive,
  ) {
    final isSelected = selectedAyah == word.ayah && selectedSurah == word.surah;
    final isPlaying =
        playingVerse != null &&
        playingVerse!.surah == word.surah &&
        playingVerse!.ayah == word.ayah;
    final hidden = hideActive && recitation?.verdictForWordId(word.id) == null;
    final isMarked = markedAyahs.contains('${word.surah}:${word.ayah}');

    return hidden
        ? (isDark ? AppColors.darkSurface : AppColors.greyLight)
        : isPlaying
        ? AppColors.primary.withValues(alpha: 0.18)
        : isSelected
        ? AppColors.ayahHighlight
        : isMarked
        ? (isDark ? AppColors.ayahMarkedDark : AppColors.ayahMarked)
        : AppColors.transparent;
  }

  Widget _buildWord(
    WordRow word,
    TextStyle baseStyle,
    QuranRecitationState? recitation,
    bool isDark,
    bool hideActive, {
    required bool isRunStart,
    required bool isRunEnd,
  }) {
    // Recitation feedback recolors the glyph itself: green = correct,
    // red = wrong; interim verdicts use a lighter tint until finalized.
    final verdict = recitation?.verdictForWordId(word.id);
    final hidden = hideActive && verdict == null;

    final glyphColor = hidden
        ? AppColors.transparent
        : verdict != null
        ? _verdictColor(verdict)
        : baseStyle.color;
    final wordStyle = baseStyle.copyWith(color: glyphColor);

    // Round only the outer ends of a contiguous same-ayah run; square the inner
    // joints so the word boxes and same-ayah spacers fuse into one bar. In the
    // RTL row the run starts on the physical right.
    const r = Radius.circular(4);
    final borderRadius = BorderRadius.horizontal(
      right: isRunStart ? r : Radius.zero,
      left: isRunEnd ? r : Radius.zero,
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (details) {
        if (onAyahTap != null) {
          onAyahTap!(word.surah, word.ayah, details.globalPosition);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: _highlightColorFor(word, recitation, isDark, hideActive),
          borderRadius: borderRadius,
        ),
        child: Text(word.text_, style: wordStyle),
      ),
    );
  }

  /// Live, highlighted spacer that fills slack on full-width lines. [flex] is 2
  /// for a single same-ayah gap, 1 for each half of an ayah-boundary gap.
  Widget _flexSpacer(
    WordRow owner,
    TextStyle baseStyle,
    QuranRecitationState? recitation,
    bool isDark,
    bool hideActive, {
    required int flex,
  }) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (details) {
          if (onAyahTap != null) {
            onAyahTap!(owner.surah, owner.ayah, details.globalPosition);
          }
        },
        // A space-sized Text matches the word box height exactly, so the
        // highlight bar is full-height with no vertical gap.
        child: Container(
          color: _highlightColorFor(owner, recitation, isDark, hideActive),
          child: Text(' ', style: baseStyle),
        ),
      ),
    );
  }

  /// Fixed glyph-space-wide live spacer for centered lines (keeps centering).
  Widget _centeredSpacer(
    WordRow owner,
    TextStyle baseStyle,
    QuranRecitationState? recitation,
    bool isDark,
    bool hideActive,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (details) {
        if (onAyahTap != null) {
          onAyahTap!(owner.surah, owner.ayah, details.globalPosition);
        }
      },
      child: Container(
        color: _highlightColorFor(owner, recitation, isDark, hideActive),
        child: Text(' ', style: baseStyle),
      ),
    );
  }

  Color _verdictColor(WordVerdictModel verdict) {
    final base = verdict.isCorrect ? AppColors.success : AppColors.error;
    return verdict.isFinal ? base : base.withAlpha(120);
  }
}
