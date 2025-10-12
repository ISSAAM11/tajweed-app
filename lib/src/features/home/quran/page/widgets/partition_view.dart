import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tajweed_ai/src/base/datasource/exports.dart';
import 'package:tajweed_ai/src/base/extensions/index.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_events.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_state.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/page_viewer.dart';

class PartitionView extends StatefulWidget {
  final int partitionIndex;

  final int initialIndex; // add this
  const PartitionView({
    required this.partitionIndex,
    required this.initialIndex,
    super.key,
  });

  @override
  State<PartitionView> createState() => _PartitionListWidgetState();
}

class _PartitionListWidgetState extends State<PartitionView>
    with AutomaticKeepAliveClientMixin {
  late final ItemScrollController scrollController;
  late final ItemPositionsListener positionsListener;

  @override
  void initState() {
    super.initState();
    scrollController = ItemScrollController();
    positionsListener = ItemPositionsListener.create();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.isAttached) {
        scrollController.jumpTo(index: widget.initialIndex);
      }
    });

    positionsListener.itemPositions.addListener(_onScroll);
  }

  int? _lastIndex;

  void _onScroll() {
    final bloc = context.read<QuranPageBloc>();
    final visible = positionsListener.itemPositions.value;

    if (visible.isNotEmpty) {
      // pick the smallest visible index (top item) instead of center
      final minIndex = visible
          .map((e) => e.index)
          .reduce((a, b) => a < b ? a : b);

      if (_lastIndex != minIndex) {
        final direction = (_lastIndex == null || minIndex > _lastIndex!)
            ? ScrollDirection.down
            : ScrollDirection.up;

        bloc.partitionScrollUpdated(
          partitionId: widget.partitionIndex,
          pageIndex: minIndex,
          direction: direction,
        );

        Debugger.orange(
          'partition:${widget.partitionIndex} idx:$minIndex dir:$direction',
        );

        _lastIndex = minIndex;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final blocState = context.watch<QuranPageBloc>().state;
    final pageNos = blocState.currentPartitionPages;
    if (blocState is QuranPageInitial)
      return const CircularProgressIndicator().center();
    return ScrollablePositionedList.builder(
      itemCount: pageNos.length,
      itemScrollController: scrollController,
      itemPositionsListener: positionsListener,
      itemBuilder: (_, index) {
        final pageNo = pageNos[index];
        final page = blocState.pages[pageNo];
        if (page == null) {
          return const CircularProgressIndicator();
        }

        return PageViewer(page: page);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
