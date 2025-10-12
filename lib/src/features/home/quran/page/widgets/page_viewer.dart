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
      height: MediaQuery.of(context).size.height, // full screen height
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Page ${page.pageNo}",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Text(
            "Blocks: ${page.blocks.length}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
