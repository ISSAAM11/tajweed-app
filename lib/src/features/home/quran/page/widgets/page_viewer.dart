import 'package:cg_core_defs/helpers/debugging_printer.dart';
import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/app/design/styles/app_fonts.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/tajweed_text.dart';

class PageViewer extends StatelessWidget {
  final PageContentDto page;
  final List<PageLinesDto> pageLines;
  const PageViewer({super.key, required this.page, required this.pageLines});

  List<Widget> _buildPageWidgets() {
    final widgets = <Widget>[];

    for (final block in page.blocks) {
      final widget = switch (block) {
        PageMetaBlockDto() => PageMetaBar(
          pageMetaBlock: block,
          pageNo: page.pageNo,
        ),
        SurahHeaderBlockDto() => SurahHeader(headerBlock: block),
        LineWordsBlockDto() => QuranLineText(
          lineWords: block.lineWords,
          isCentered: block.isCentered,
        ),
        BasmalahBlockDto() => BasmalahWidget(),
        _ => SizedBox.shrink(),
      };
      widgets.add(widget);
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    Debugger.blue('should render Page ${page.pageNo}');

    final allWidgets = _buildPageWidgets();

    // Separate PageMetaBar from other widgets
    final pageMetaBar = allWidgets.firstWhere(
      (widget) => widget is PageMetaBar,
      orElse: () => SizedBox.shrink(),
    );

    final contentWidgets = allWidgets
        .where((widget) => widget is! PageMetaBar)
        .toList();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ResizeImage(
            AssetImage(
              page.pageNo % 2 == 0
                  ? 'assets/images/background/left_background.jpg'
                  : 'assets/images/background/right_background.jpg',
            ),
            height: 110,
          ),
          fit: BoxFit.cover,
        ),
      ),

      padding: const EdgeInsets.only(bottom: 60),
      child: Column(
        children: [
          pageMetaBar,
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [...contentWidgets, TajweedRulesWidget()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TajweedRulesWidget extends StatelessWidget {
  const TajweedRulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 5, top: 13),
      child: Image.asset('assets/images/background/tajweed-rules.png'),
    );
  }
}

class SurahHeader extends StatelessWidget {
  final SurahHeaderBlockDto headerBlock;

  const SurahHeader({super.key, required this.headerBlock});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: double.infinity + 10,
      height: 42,
      padding: const EdgeInsets.only(bottom: 4.0),
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
          color: Colors.black,
          fontSize: 20,
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
      margin: const EdgeInsets.only(bottom: 10.0),
      height: 35,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Juz ${pageMetaBlock.juz}, Hizb ${pageMetaBlock.hizb}, Page $pageNo",
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

class BasmalahWidget extends StatelessWidget {
  const BasmalahWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      child: Text(
        "بِسْمِ اللَّهِ الرَّحْمٰنِ الرَّحِيمِ",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 19,
          fontFamily: "UthmanicHafsV18",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
