import 'package:cg_core_defs/helpers/debugging_printer.dart';
import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/app/design/styles/app_fonts.dart';
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
  GlobalKey? _selectedParentKey;

  void _removePopup() {
    setState(() {
      selectedAyah = null;
      _popupPosition = null;
      _selectedParentKey = null;
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
        SurahHeaderBlockDto() => SurahHeader(headerBlock: block),
        LineWordsBlockDto() => QuranLineText(
          lineWords: block.lineWords,
          isCentered: block.isCentered,
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
    Debugger.blue('should render Page ${widget.page.pageNo}');

    final allWidgets = _buildPageWidgets();
    final pageMetaBar = allWidgets.firstWhere(
      (w) => w is PageMetaBar,
      orElse: () => SizedBox.shrink(),
    );
    final contentWidgets = allWidgets.where((w) => w is! PageMetaBar).toList();

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: ResizeImage(
                AssetImage(
                  widget.page.pageNo % 2 == 0
                      ? "assets/images/background/left_background.jpg"
                      : "assets/images/background/right_background.jpg",
                ),
                height: 110,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              pageMetaBar,
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [...contentWidgets, TajweedRulesWidget()],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (selectedAyah != null &&
            _popupPosition != null &&
            _selectedParentKey != null)
          _buildPopup(),
      ],
    );
  }

  Widget _buildPopup() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get the RenderBox of the parent widget
        final renderBox =
            _selectedParentKey!.currentContext?.findRenderObject()
                as RenderBox?;
        if (renderBox == null) return SizedBox.shrink();

        final parentPosition = renderBox.localToGlobal(Offset.zero);
        final parentSize = renderBox.size;

        const popupWidth = 190.0;
        const popupHeight = 40.0;
        const margin = 16.0;

        double top = parentPosition.dy - popupHeight - 10;
        double left = _popupPosition!.dx - (popupWidth / 2);

        if (left < margin) left = margin;
        if (left + popupWidth > constraints.maxWidth - margin) {
          left = constraints.maxWidth - popupWidth - margin;
        }

        if (top < margin) {
          top = parentPosition.dy + parentSize.height + 10;
        }
        if (top + popupHeight > constraints.maxHeight - margin) {
          top = constraints.maxHeight - popupHeight - margin;
        }

        return Positioned(
          left: left,
          top: top,
          child: GestureDetector(
            onTap: _removePopup,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.copy),
                      iconSize: 22,
                      onPressed: _removePopup,
                    ),
                    IconButton(
                      icon: Icon(Icons.bookmark_border),
                      iconSize: 22,
                      onPressed: _removePopup,
                    ),
                    IconButton(
                      icon: Icon(Icons.translate),
                      iconSize: 22,
                      onPressed: _removePopup,
                    ),
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      iconSize: 22,
                      onPressed: _removePopup,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Update your onAyahTap callback:
  void _handleAyahTap(int ayahNumber, Offset position, GlobalKey parentKey) {
    setState(() {
      if (selectedAyah == ayahNumber) {
        _removePopup();
      } else {
        selectedAyah = ayahNumber;
        _popupPosition = position;
        _selectedParentKey = parentKey;
      }
    });
  }
}

class TajweedRulesWidget extends StatelessWidget {
  const TajweedRulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background/tajweed-rules.png'),
          fit: BoxFit.contain,
        ),
      ),
      alignment: Alignment.center,
    );
  }
}

class SurahHeader extends StatelessWidget {
  final SurahHeaderBlockDto headerBlock;

  const SurahHeader({super.key, required this.headerBlock});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsivefontSize = screenWidth * 0.047;

    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      width: double.infinity,
      height: 42,
      padding: const EdgeInsets.only(bottom: 3),
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
        style: AppFonts.surahNamesFont.copyWith(
          color: Color.fromARGB(183, 0, 0, 0),
          fontWeight: FontWeight.w600,
          fontSize: responsivefontSize,
        ),
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
    return Container(
      height: 25,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Juz ${pageMetaBlock.juz}, Hizb ${pageMetaBlock.hizb}",
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Text("Page $pageNo", style: Theme.of(context).textTheme.labelSmall),
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
    final screenHeight = MediaQuery.of(context).size.height;
    final responsivefontSize = screenWidth * 0.047;
    final responsiveTextHeight = screenHeight * 0.0021;

    return SizedBox(
      child: Text(
        "بِسْمِ اللَّهِ الرَّحْمٰنِ الرَّحِيمِ",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: responsivefontSize,
          color: Color.fromARGB(183, 0, 0, 0),
          height: responsiveTextHeight,

          fontWeight: FontWeight.w600,
          fontFamily: "UthmanicHafsV18",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
