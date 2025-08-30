import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/binding/quran_deps.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_state.dart';

import 'widgets/quran_listing_body.dart';

final class SurahListingScreen
    extends Feature<QuranListingBloc, QuranListingState> {
  SurahListingScreen({super.key})
    : super(
        dependencies: QuranDependencies().inject,
        onUpdate: (context, state) => switch (state) {
          _ => null,
        },
      );

  @override
  Widget build(BuildContext context, QuranListingState state) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SurahListingBody(state),
    );
  }
}
