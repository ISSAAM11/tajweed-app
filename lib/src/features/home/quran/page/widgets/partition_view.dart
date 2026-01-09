import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tajweed_ai/src/base/extensions/index.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_state.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/page_viewer.dart';

class PartitionView extends StatefulWidget {
  final int partitionIndex;

  const PartitionView({required this.partitionIndex, super.key});

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

    context.read<QuranPageBloc>().fetchPartitionContent(widget.partitionIndex);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final blocState = context.watch<QuranPageBloc>().state;
    if (blocState is QuranPageInitial || blocState.page == null)
      return const CircularProgressIndicator().center();

    return PageViewer(page: blocState.page!);
  }

  @override
  bool get wantKeepAlive => true;
}
