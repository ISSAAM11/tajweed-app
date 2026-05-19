import 'package:flutter/material.dart';
import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/design/colors/app_colors.dart';
import 'package:tajweed_ai/src/app/design/metrics/app_metrics.dart';
import 'package:tajweed_ai/src/app/design/styles/app_fonts.dart';
import 'package:tajweed_ai/src/app/design/styles/app_styles.dart';
import 'package:tajweed_ai/src/app/design/styles/font_sizes.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/tajweed_text.dart';

class PageViewer extends StatefulWidget {
  final PageContentDto page;
  const PageViewer({super.key, required this.page});

  @override
  State<PageViewer> createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
  int? selectedAyah;
  Offset? _popupPosition;
  final GlobalKey _stackKey = GlobalKey();

  void _removePopup() {
    setState(() {
      selectedAyah = null;
      _popupPosition = null;
    });
  }

  List<Widget> _buildPageWidgets() {
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
          onAyahTap: _handleAyahTap,
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
    // Debugger.blue('should render Page ${widget.page.pageNo}');

    final allWidgets = _buildPageWidgets();
    final pageMetaBar = allWidgets.firstWhere(
      (w) => w is PageMetaBar,
      orElse: () => SizedBox.shrink(),
    );
    final contentWidgets = allWidgets.where((w) => w is! PageMetaBar).toList();
    final screenHeight = MediaQuery.of(context).size.height;
    final responsiveVerticalPadding = screenHeight * 0.015;
    return Stack(
      key: _stackKey,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ResizeImage(
                AssetImage(
                  widget.page.pageNo % 2 == 0
                      ? "assets/images/background/left_background2.jpg"
                      : "assets/images/background/right_background2.jpg",
                ),
                height: AppMetrics.quranPageViewer.backgroundResizeHeight.toInt(),
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
        if (selectedAyah != null && _popupPosition != null)
          _buildPopup(),
      ],
    );
  }

  Widget _buildPopup() {
    final stackBox =
        _stackKey.currentContext?.findRenderObject() as RenderBox?;
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
            color: AppColors.scaffold,
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
                onPressed: null, // TODO: copy ayah text
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                iconSize: AppMetrics.quranPageViewer.popupIconSize,
                onPressed: null, // TODO: bookmark ayah
              ),
              IconButton(
                icon: const Icon(Icons.translate),
                iconSize: AppMetrics.quranPageViewer.popupIconSize,
                onPressed: null, // TODO: show translation
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: AppMetrics.quranPageViewer.popupIconSize,
                onPressed: null, // TODO: play audio
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAyahTap(int ayahNumber, Offset globalPosition) {
    setState(() {
      if (selectedAyah == ayahNumber) {
        _removePopup();
      } else {
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

    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppMetrics.quranPageViewer.contentHorizontalMargin),
      width: double.infinity,
      height: AppMetrics.quranPageViewer.surahHeaderHeight,
      padding: EdgeInsets.only(bottom: AppMetrics.quranPageViewer.surahHeaderBottomPadding),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/background/surah-header-background1.png',
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
            .withColor(AppColors.surahGlyphColor)
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
                .withColor(AppColors.accent)
                .semiBold(),
          ),
          Text(
            '${l10n.partitionPage} $pageNo',
            style: AppFonts.lato
                .withSize(FontSizes.subtitle)
                .withColor(AppColors.accent)
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

    return Text(
      "ﱁ ﱂ ﱃ ﱄ",
      style: TextStyle(
        fontFamily: 'QPC-V2-Font-p1',
        fontSize: responsivefontSize,
        color: AppColors.surahGlyphColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}

