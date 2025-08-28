//? Base needed imports

import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/screen/widgets/list_header.dart';
import 'package:tajweed_ai/src/features/home/quran/screen/widgets/quran_list_view.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_model_helper.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_state.dart';

class SurahListingBody extends SubWidget<QuranListingBloc> {
  final QuranListingState state;

  const SurahListingBody(this.state, {super.key});

  @override
  Widget build(BuildContext context) => switch (state) {
    QuranListingLoadedState() => _QuranScreen(
      itemCount: (state as QuranListingLoadedState).items.length,
      items: (state as QuranListingLoadedState).items,
      onTap: bloc.selectPartition,
      selectedViewMode: (state as QuranListingLoadedState).currentListingMode,
      onSelectMode: (mode) => bloc.changeListingMode(mode),
    ),
    QuranListingErrorState() => Center(
      child: Text("Error: ${(state as QuranListingErrorState).message}"),
    ),
    _ => CircularProgressIndicator(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
    ).resize(height: 20, width: 20).center(),
  };
}

class _QuranScreen extends StatelessWidget {
  final int itemCount;
  final List<PartitionItem> items;
  final PartitionMode selectedViewMode;
  final Function(PartitionMode) onSelectMode;
  void Function({
    required int partitionId,
    required PartitionMode mode,
    HizbFraction? fraction,
  })
  onTap;
  _QuranScreen({
    required this.itemCount,
    required this.items,
    required this.onTap,
    required this.selectedViewMode,
    required this.onSelectMode,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 500),
        child: ListHeader(
          selectedViewMode: selectedViewMode,
          onSelectMode: onSelectMode,
        ),
      ),
      QuranListView(
        itemCount: itemCount,
        items: items,
        selectedViewMode: selectedViewMode,
        onTap: onTap,
      ).expanded(),
    ],
  ).safeArea();
}
