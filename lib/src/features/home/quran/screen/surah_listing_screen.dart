import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/binding/quran_deps.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_state.dart';

import 'widgets/surah_listing_body.dart';

final class SurahListingScreen extends Feature<QuranBloc, QuranState> {
  SurahListingScreen({super.key})
    : super(
        dependencies: QuranDependencies().inject,
        onUpdate: (context, state) => switch (state) {
          _ => null,
        },
      );

  @override
  Widget build(BuildContext context, QuranState state) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SurahListingBody(state),
    );
  }
}
