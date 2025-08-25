//? Base needed imports

import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/screen/widgets/surah_name_card.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_state.dart';

class SurahListingBody extends SubWidget<QuranListingBloc> {
  final QuranListingState state;

  const SurahListingBody(this.state, {super.key});

  @override
  Widget build(BuildContext context) => switch (state) {
    QuranListingLoadedState() => _QuranScreen(
      itemCount: (state as QuranListingLoadedState).chapters.length,
      items: (state as QuranListingLoadedState).chapters,
      onTap: (index) => bloc.selectSurah(index),
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
  final List<dynamic> items;
  final PartitionMode selectedViewMode;
  final Function(PartitionMode) onSelectMode;
  void Function(int) onTap;
  _QuranScreen({
    required this.itemCount,
    required this.items,
    required this.onTap,
    required this.selectedViewMode,
    required this.onSelectMode,
  });
  @override
  @override
  Widget build(BuildContext context) => AnimatedOpacity(
    opacity: 1.0,
    duration: const Duration(milliseconds: 500),
    child: ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final c = items[index];
        return SurahNameCard(
          name: c.nameArabic,
          nameEnglish: c.name,
          glyph: c.nameGlyph,
          revelationPlace: c.revelationPlace,
          orderNumber: c.id,
          onTap: (index) => onTap(index),
        );
      },
    ),
  );
}
