import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/binding/app_bindings.dart' show get;
import 'package:tajweed_ai/src/app/design/colors/app_colors.dart';
import 'package:tajweed_ai/src/app/design/metrics/app_metrics.dart';
import 'package:tajweed_ai/src/app/design/styles/app_fonts.dart';
import 'package:tajweed_ai/src/app/design/styles/app_styles.dart';
import 'package:tajweed_ai/src/app/design/styles/font_sizes.dart';
import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/audio_player_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/recitation/quran_recitation_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/recitation/recitation_words.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/play_options_sheet.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/tajweed_text.dart';

class PageViewer extends StatefulWidget {
  final PageContentDto page;
  const PageViewer({super.key, required this.page});

  @override
  State<PageViewer> createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
  int? selectedAyah;
  int? selectedSurah;
  Offset? _popupPosition;
  final GlobalKey _stackKey = GlobalKey();

  void _removePopup() {
    setState(() {
      selectedAyah = null;
      selectedSurah = null;
      _popupPosition = null;
    });
  }

  /// Returns distinct (surah, ayah) pairs from the current page in order.
  List<VerseKey> _getPageAyahs() {
    final seen = <String>{};
    final ayahs = <VerseKey>[];
    for (final block in widget.page.blocks) {
      if (block is LineWordsBlockDto) {
        for (final word in block.lineWords) {
          final key = '${word.surah}:${word.ayah}';
          if (seen.add(key)) {
            ayahs.add(VerseKey(word.surah, word.ayah));
          }
        }
      }
    }
    return ayahs;
  }

  /// Plain Arabic text of a single verse, assembled from its words' `plainText`
  /// (the `text` column) in word order and joined with spaces.
  ///
  /// Loads the verse from the database rather than from `widget.page.blocks`,
  /// so verses that span a page boundary are copied in full instead of only
  /// the portion visible on the current page.
  Future<String> _getAyahText(int surah, int ayah) async {
    final words = await get<QuranPageDao>().getAyahPlainWords(surah, ayah);
    final text = words
        .map((w) => w.trim())
        .where((t) => t.isNotEmpty && !_isVerseMarker(t))
        .join(' ');
    debugPrint('[copy] ayah $surah:$ayah -> "$text"');
    return text;
  }

  /// Verse-end markers store their number ornament as Private-Use-Area glyph
  /// codes (U+E000–U+F8FF) in the `text` column. Those are font glyphs, not
  /// readable Arabic, so any word containing one is dropped from copied text.
  bool _isVerseMarker(String word) =>
      word.runes.any((r) => r >= 0xE000 && r <= 0xF8FF);

  List<Widget> _buildPageWidgets(VerseKey? playingVerse) {
    final widgets = <Widget>[];
    for (final block in widget.page.blocks) {
      final builtWidget = switch (block) {
        PageMetaBlockDto() => PageMetaBar(
          pageMetaBlock: block,
          pageNo: widget.page.pageNo,
        ),
        SurahHeaderBlockDto() => SurahHeader(
          headerBlock: block,
          pageNo: widget.page.pageNo,
        ),
        LineWordsBlockDto() => QuranLineText(
          pageNo: widget.page.pageNo,
          lineWords: block.lineWords,
          isCentered: block.isCentered,
          selectedAyah: selectedAyah,
          selectedSurah: selectedSurah,
          onAyahTap: _handleAyahTap,
          playingVerse: playingVerse,
        ),
        BasmalahBlockDto() => BasmalahWidget(),
        _ => SizedBox.shrink(),
      };
      widgets.add(builtWidget);
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    // Derive currently playing verse for highlighting (null-safe if bloc absent)
    VerseKey? playingVerse;
    try {
      final audioState = context.watch<AudioPlayerBloc>().state;
      playingVerse = switch (audioState) {
        AudioPlaying(:final surah, :final currentAyah) => VerseKey(
          surah,
          currentAyah,
        ),
        AudioPaused(:final surah, :final currentAyah) => VerseKey(
          surah,
          currentAyah,
        ),
        _ => null,
      };
    } catch (_) {
      playingVerse = null;
    }

    final allWidgets = _buildPageWidgets(playingVerse);
    final pageMetaBar = allWidgets.firstWhere(
      (w) => w is PageMetaBar,
      orElse: () => SizedBox.shrink(),
    );
    final contentWidgets = allWidgets.where((w) => w is! PageMetaBar).toList();
    final screenHeight = MediaQuery.of(context).size.height;
    final responsiveVerticalPadding = screenHeight * 0.015;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLeftPage = widget.page.pageNo % 2 == 0;
    final backgroundAsset = isLeftPage
        ? (isDark
              ? "assets/images/background/left_background_dark.jpg"
              : "assets/images/background/left_background2.jpg")
        : (isDark
              ? "assets/images/background/right_background_dark.jpg"
              : "assets/images/background/right_background2.jpg");
    return Stack(
      key: _stackKey,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ResizeImage(
                AssetImage(backgroundAsset),
                height: AppMetrics.quranPageViewer.backgroundResizeHeight
                    .toInt(),
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              pageMetaBar,
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: responsiveVerticalPadding,
                  ),
                  child: Column(
                    mainAxisAlignment: widget.page.pageNo < 3
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,

                    children: contentWidgets,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (selectedAyah != null && _popupPosition != null) _buildPopup(),
        if (selectedAyah != null && selectedSurah != null)
          Positioned(
            left: AppMetrics.spacing.md,
            bottom: AppMetrics.spacing.md,
            child: FloatingActionButton.small(
              heroTag: 'recite-from-${widget.page.pageNo}',
              tooltip: AppLocalizations.of(context)!.recitationStartTooltip,
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.scaffold,
              onPressed: () => _startFromSelection(context),
              child: const Icon(Icons.mic),
            ),
          ),
      ],
    );
  }

  /// Page-scoped recitation starting at the selected verse (the FAB). Stops any
  /// playback, enters recitation mode, and streams from that position onward.
  void _startFromSelection(BuildContext context) {
    final surah = selectedSurah;
    final ayah = selectedAyah;
    if (surah == null || ayah == null) return;
    final words = recitableWordsFromPage(
      widget.page,
      fromSurah: surah,
      fromAyah: ayah,
    );
    if (words.isEmpty) return;
    _removePopup();
    context.read<AudioPlayerBloc>().add(const StopAudio());
    final rec = context.read<QuranRecitationBloc>();
    rec.enterMode();
    rec.startPage(widget.page.pageNo, words);
  }

  Widget _buildPopup() {
    final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (stackBox == null) return const SizedBox.shrink();

    final local = stackBox.globalToLocal(_popupPosition!);
    final stackSize = stackBox.size;
    final popupWidth = AppMetrics.quranPageViewer.popupWidth;
    final popupHeight = AppMetrics.quranPageViewer.popupHeight;
    const margin = 16.0;
    const offset = 10.0;

    double top = local.dy - popupHeight - offset;
    double left = local.dx - (popupWidth / 2);

    // Clamp horizontally
    if (left < margin) left = margin;
    if (left + popupWidth > stackSize.width - margin) {
      left = stackSize.width - popupWidth - margin;
    }

    // If popup goes above the stack, show it below the tap instead
    if (top < margin) top = local.dy + offset;

    // Final bottom clamp
    if (top + popupHeight > stackSize.height - margin) {
      top = stackSize.height - popupHeight - margin;
    }

    return Positioned(
      left: left,
      top: top,
      child: Material(
        elevation: AppMetrics.quranPageViewer.popupElevation,
        borderRadius: BorderRadius.circular(
          AppMetrics.quranPageViewer.popupRadius,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(
              AppMetrics.quranPageViewer.popupRadius,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.copy),
                iconSize: AppMetrics.quranPageViewer.popupIconSize,
                onPressed: (selectedAyah == null || selectedSurah == null)
                    ? null
                    : () async {
                        final surah = selectedSurah!;
                        final ayah = selectedAyah!;
                        final messenger = ScaffoldMessenger.of(context);
                        final copied = AppLocalizations.of(
                          context,
                        )!.verseCopied;
                        _removePopup();
                        final text = await _getAyahText(surah, ayah);
                        if (text.isEmpty) return;
                        await Clipboard.setData(ClipboardData(text: text));
                        messenger.showSnackBar(SnackBar(content: Text(copied)));
                      },
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                iconSize: AppMetrics.quranPageViewer.popupIconSize,
                onPressed: null, // TODO: bookmark ayah
              ),
              IconButton(
                icon: const Icon(Icons.mic),
                iconSize: AppMetrics.quranPageViewer.popupIconSize,
                tooltip: AppLocalizations.of(context)!.recitationStartTooltip,
                onPressed: (selectedAyah == null || selectedSurah == null)
                    ? null
                    : () {
                        final surah = selectedSurah!;
                        final ayah = selectedAyah!;
                        _removePopup();
                        // Mic and playback can't share the audio route — stop
                        // any active recitation audio before recording.
                        context.read<AudioPlayerBloc>().add(const StopAudio());
                        context.read<QuranRecitationBloc>().add(
                          StartRecitation(surah, ayah),
                        );
                      },
              ),
              // IconButton(
              //   icon: const Icon(Icons.translate),
              //   iconSize: AppMetrics.quranPageViewer.popupIconSize,
              //   onPressed: null, // TODO: show translation
              // ),
              IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: AppMetrics.quranPageViewer.popupIconSize,
                onPressed: (selectedAyah == null || selectedSurah == null)
                    ? null
                    : () {
                        final surah = selectedSurah!;
                        final ayah = selectedAyah!;
                        final pageAyahs = _getPageAyahs();
                        final surahName = _resolveSurahName(context, surah);
                        _removePopup();
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => PlayOptionsSheet(
                            ayahNumber: ayah,
                            pageNo: widget.page.pageNo,
                            surahName: surahName,
                            onPlayAyah: () => context
                                .read<AudioPlayerBloc>()
                                .add(RequestPlayAyah(surah, ayah)),
                            onPlayPage: () => context
                                .read<AudioPlayerBloc>()
                                .add(RequestPlayPage(pageAyahs)),
                            onPlaySurah: () => context
                                .read<AudioPlayerBloc>()
                                .add(RequestPlaySurah(surah, ayah)),
                          ),
                        );
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _resolveSurahName(BuildContext context, int surahNumber) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    for (final block in widget.page.blocks) {
      if (block is SurahHeaderBlockDto && block.chapter.id == surahNumber) {
        return isArabic ? block.chapter.nameArabic : block.chapter.nameSimple;
      }
    }
    return '${AppLocalizations.of(context)!.partitionSurah} $surahNumber';
  }

  void _handleAyahTap(int surah, int ayahNumber, Offset globalPosition) {
    setState(() {
      if (selectedAyah == ayahNumber && selectedSurah == surah) {
        _removePopup();
      } else {
        selectedSurah = surah;
        selectedAyah = ayahNumber;
        _popupPosition = globalPosition;
      }
    });
  }
}

class SurahHeader extends StatelessWidget {
  final SurahHeaderBlockDto headerBlock;
  final int pageNo;
  const SurahHeader({
    super.key,
    required this.headerBlock,
    required this.pageNo,
  });

  @override
  Widget build(BuildContext context) {
    if (pageNo < 3) {
      return SizedBox.shrink();
    }
    final screenWidth = MediaQuery.of(context).size.width;
    final responsivefontSize = screenWidth * 0.047;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppMetrics.quranPageViewer.contentHorizontalMargin,
      ),
      width: double.infinity,
      height: AppMetrics.quranPageViewer.surahHeaderHeight,
      padding: EdgeInsets.only(
        bottom: AppMetrics.quranPageViewer.surahHeaderBottomPadding,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            isDark
                ? 'assets/images/background/surah-header-background-dark.png'
                : 'assets/images/background/surah-header-background1.png',
          ),
          fit: BoxFit.contain,
        ),
      ),
      alignment: Alignment.center,

      child: Text(
        String.fromCharCode(
          int.parse(headerBlock.chapter.nameGlyph, radix: 16),
        ),
        style: AppFonts.surahNamesFont
            .withColor(
              isDark ? AppColors.darkPrimary : AppColors.surahGlyphColor,
            )
            .semiBold()
            .withSize(responsivefontSize),
      ),
    );
  }
}

class PageMetaBar extends StatelessWidget {
  final PageMetaBlockDto pageMetaBlock;
  final int pageNo;

  const PageMetaBar({
    super.key,
    required this.pageMetaBlock,
    required this.pageNo,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final metaColor = isDark ? AppColors.darkPrimary : AppColors.accent;
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${l10n.partitionJuz} ${pageMetaBlock.juz}, '
            '${l10n.partitionHizb} ${pageMetaBlock.hizb}',
            style: AppFonts.lato
                .withSize(FontSizes.subtitle)
                .withColor(metaColor)
                .semiBold(),
          ),
          Text(
            '${l10n.partitionPage} $pageNo',
            style: AppFonts.lato
                .withSize(FontSizes.subtitle)
                .withColor(metaColor)
                .semiBold(),
          ),
        ],
      ),
    );
  }
}

class BasmalahWidget extends StatelessWidget {
  const BasmalahWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsivefontSize = screenWidth * 0.05;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      "ﱁ ﱂ ﱃ ﱄ",
      style: TextStyle(
        fontFamily: 'QPC-V2-Font-p1',
        fontSize: responsivefontSize,
        color: isDark ? AppColors.darkPrimary : AppColors.surahGlyphColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}
