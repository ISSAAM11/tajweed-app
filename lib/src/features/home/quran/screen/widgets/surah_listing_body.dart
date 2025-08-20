//? Base needed imports

import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/screen/widgets/surah_name_card.dart';

import '../../../../../database/app_database.dart';
import '../../vm/quran_state.dart';

class SurahListingBody extends SubWidget<QuranBloc> {
  final QuranState state;

  const SurahListingBody(this.state, {super.key});

  @override
  Widget build(BuildContext context) => switch (state) {
    QuranLoadedState() => _QuranScreen(
      itemCount: (state as QuranLoadedState).chapters.length,
      quran: (state as QuranLoadedState).chapters,
      onTap: () => bloc.selectSurah,
    ),
    QuranErrorState() => Center(
      child: Text("Error: ${(state as QuranErrorState).message}"),
    ),
    _ => CircularProgressIndicator(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
    ).resize(height: 20, width: 20).center(),
  };
}

class _QuranScreen extends StatelessWidget {
  final int itemCount;
  final List<Chapter> quran;
  void Function() onTap;
  _QuranScreen({
    required this.itemCount,
    required this.quran,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
    opacity: 1.0,
    duration: const Duration(milliseconds: 500),
    child: ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final c = quran[index];
        return SurahNameCard(
          name: c.nameArabic,
          nameEnglish: c.name,
          glyph: c.nameGlyph,
          revelationPlace: c.revelationPlace == 'makkah'
              ? RevelationPlace.makkah
              : RevelationPlace.madinah,
          orderNumber: c.id,
          onTap: onTap,
        );
      },
    ),
  );
}
