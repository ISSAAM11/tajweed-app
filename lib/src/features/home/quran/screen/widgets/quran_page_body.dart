import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/page_models.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_page/quran_page_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_page/quran_page_events.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_page/quran_page_state.dart';

class QuranPageBody extends SubWidget<QuranPageBloc> {
  final QuranPageState state;
  QuranPageBody(this.state, {super.key});

  final itemPositionsListener = ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      if (positions.isNotEmpty) {
        final firstVisible = positions
            .where((pos) => pos.itemLeadingEdge >= 0)
            .reduce((a, b) => a.index < b.index ? a : b);
        bloc.add(VerticalIndexChanged(firstVisible.index));
      }
    });

    return BlocListener<QuranPageBloc, QuranPageState>(
      listener: (context, state) {
        // Example: react to error or reload triggers
      },
      child: ScrollablePositionedList.builder(
        itemScrollController: bloc.state.verticalController,
        itemPositionsListener: itemPositionsListener,
        itemCount: bloc.state.currentPartitionPages.length,
        itemBuilder: (ctx, index) {
          final pageNo = bloc.state.currentPartitionPages[index];
          final page = bloc.state.pages[pageNo];
          return page != null
              ? PageRenderer(page: page)
              : const CircularProgressIndicator();
        },
      ),
    );
  }
}

class PageRenderer extends StatelessWidget {
  final PageContentDto page;
  const PageRenderer({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Text('should render page ${page.pageNo} ${page.blocks.first}'),
    );
  }
}
