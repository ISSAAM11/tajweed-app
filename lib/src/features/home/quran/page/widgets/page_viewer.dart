import 'package:cg_core_defs/helpers/debugging_printer.dart';
import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';

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
              return Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                height: 35,
                width: double.infinity,
                alignment: Alignment.center,
                color: const Color.fromARGB(19, 0, 0, 0),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Juz ${block.juz}, Hizb ${block.hizb} ,Page ${page.pageNo}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              );
            } else if (block is SurahHeaderBlockDto) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  spacing: 8,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        block.chapter.id.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      block.chapter.nameArabic,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 28,
                        color: Colors.blueGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else if (block is AyahBlockDto) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  block.ayah.ayah.toString(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.right,
                ),
              );
            } else if (block is BasmalahBlockDto) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "بِسْمِ اللَّهِ الرَّحْمٰنِ الرَّحِيمِ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (block is PageMetaBlockDto) {
              return SizedBox.shrink(); // Already shown above
            } else {
              return SizedBox.shrink(); // Unknown block type
            }
          }),
        ],
      ),
    );
  }
}
