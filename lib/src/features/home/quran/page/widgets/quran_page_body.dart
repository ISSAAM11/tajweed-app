import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajweed_ai/src/base/screens/sub_widget.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_state.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/partition_view.dart';

class QuranPageBody extends SubWidget<QuranPageBloc> {
  final QuranPageState state;
  const QuranPageBody(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return const _QuranReaderInternal();
  }
}

/// Internal stateful host that owns the PageController (keeps it alive)
class _QuranReaderInternal extends StatefulWidget {
  const _QuranReaderInternal({super.key});

  @override
  State<_QuranReaderInternal> createState() => _QuranReaderInternalState();
}

class _QuranReaderInternalState extends State<_QuranReaderInternal> {
  late PageController _pageController;
  List<int> _orderedPartitionIds = [];
  bool _ignoreNextPageChange = false;
  int _lastUiIndex = 0;

  @override
  void initState() {
    super.initState();
    // temporary initial page; we'll jump to the correct one after first build
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _maybeJumpToUiIndex(int uiIndex) {
    if (!_pageController.hasClients) return;
    final clamped = uiIndex.clamp(0, (_orderedPartitionIds.length - 1));
    if (clamped != _lastUiIndex) {
      _ignoreNextPageChange =
          true; // prevent loop when jump triggers onPageChanged
      _pageController.jumpToPage(clamped);
      _lastUiIndex = clamped;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<QuranPageBloc>();

    return BlocSelector<QuranPageBloc, QuranPageState, _PartitionViewData?>(
      selector: (state) {
        if (state is QuranPageLoaded) {
          final snapshot = bloc.snapshotService.snapshot;
          final orderedIds = snapshot.uiKeysByMode(state.partitionMode);
          final desiredUiIndex = orderedIds
              .indexOf(state.partitionId)
              .clamp(0, (orderedIds.length - 1));

          return _PartitionViewData(
            partitionMode: state.partitionMode,
            partitionId: state.partitionId,
            totalPartitions: state.totalPartitions,
            orderedPartitionIds: orderedIds,
            desiredUiIndex: desiredUiIndex,
          );
        }
        return null;
      },
      builder: (context, data) {
        if (data == null) return const SizedBox.shrink();

        _orderedPartitionIds = data.orderedPartitionIds;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _maybeJumpToUiIndex(data.desiredUiIndex);
        });

        return PageView.builder(
          controller: _pageController,
          itemCount: _orderedPartitionIds.length,
          onPageChanged: (uiIndex) {
            if (_ignoreNextPageChange) {
              _ignoreNextPageChange = false;
              _lastUiIndex = uiIndex;
              return;
            }
            _lastUiIndex = uiIndex;
            final newPartitionId =
                (uiIndex >= 0 && uiIndex < _orderedPartitionIds.length)
                ? _orderedPartitionIds[uiIndex]
                : _orderedPartitionIds.first;
            bloc.partitionChanged(newPartitionId);
          },
          itemBuilder: (context, uiIndex) {
            final partitionId =
                (uiIndex >= 0 && uiIndex < _orderedPartitionIds.length)
                ? _orderedPartitionIds[uiIndex]
                : _orderedPartitionIds.first;

            // only build near the current partition to reduce rebuilds
            if ((partitionId < data.partitionId - 1) ||
                (partitionId > data.partitionId + 1)) {
              return const SizedBox.shrink();
            }
            // TODO: update initialIndex impl
            return PartitionView(partitionIndex: partitionId, initialIndex: 0);
          },
        );
      },
    );
  }
}

/// Minimal data holder used with BlocSelector
class _PartitionViewData extends Equatable {
  final PartitionMode partitionMode;
  final int partitionId;
  final int totalPartitions;
  final List<int> orderedPartitionIds;
  final int desiredUiIndex;

  const _PartitionViewData({
    required this.partitionMode,
    required this.partitionId,
    required this.totalPartitions,
    required this.orderedPartitionIds,
    required this.desiredUiIndex,
  });

  @override
  List<Object?> get props => [
    partitionMode,
    partitionId,
    totalPartitions,
    orderedPartitionIds,
    desiredUiIndex,
  ];
}
