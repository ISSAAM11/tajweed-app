import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tajweed_ai/src/base/datasource/exports.dart';
import 'package:tajweed_ai/src/base/extensions/index.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_events.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_state.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/page_viewer.dart';

class PartitionView extends StatefulWidget {
  final PartitionMode partitionMode;
  final int partitionIndex;

  final int initialIndex;
  const PartitionView({
    required this.partitionMode,
    required this.partitionIndex,
    required this.initialIndex,
    super.key,
  });

  @override
  State<PartitionView> createState() => _PartitionListWidgetState();
}

class _PartitionListWidgetState extends State<PartitionView>
    with AutomaticKeepAliveClientMixin {
  late final ItemPositionsListener positionsListener;

  @override
  void initState() {
    super.initState();
    positionsListener = ItemPositionsListener.create();

    context.read<QuranPageBloc>().fetchPartitionContent(
      widget.partitionIndex,
      widget.partitionMode,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final blocState = context.watch<QuranPageBloc>().state;
    final pageNos = blocState.currentPartitionPages;
    if (blocState is QuranPageInitial || blocState.pages[pageNos[0]] == null)
      return const CircularProgressIndicator().center();

    return PageViewer(
      page: blocState.pages[pageNos[0]]!,
      pageLines: blocState.pageLines,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
