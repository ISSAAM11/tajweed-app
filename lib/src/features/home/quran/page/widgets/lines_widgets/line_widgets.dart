import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/app/design/styles/app_fonts.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';

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
