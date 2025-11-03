import 'package:cg_core_defs/helpers/debugging_printer.dart';
import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/tajweed_text.dart';

class PageViewer extends StatelessWidget {
  final PageContentDto page;
  const PageViewer({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    Debugger.blue('should render Page ${page.pageNo}');
    return Container(
      padding: const EdgeInsets.only(bottom: 35),
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        children: [
          ...page.blocks.map((block) {
            if (block is PageMetaBlockDto) {
              return PageMetaBar(pageMetaBlock: block, pageNo: page.pageNo);
            } else if (block is SurahHeaderBlockDto) {
              return SurahHeader(headerBlock: block);
            } else if (block is PageAyatsBlockDto) {
              return QuranParagraph(ayahs: block.pageAyahs);
            } else if (block is BasmalahBlockDto) {
              return BasmalahWidget();
            } else if (block is PageMetaBlockDto) {
              return SizedBox.shrink();
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}

class SurahHeader extends StatelessWidget {
  final SurahHeaderBlockDto headerBlock;

  const SurahHeader({super.key, required this.headerBlock});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(3.0),
            decoration: const BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              headerBlock.chapter.id.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            headerBlock.chapter.nameArabic,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 28,
              color: Colors.blueGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
      color: const Color.fromARGB(220, 240, 233, 207),
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
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "بِسْمِ اللَّهِ الرَّحْمٰنِ الرَّحِيمِ",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          fontFamily: "SurahNameV4",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
