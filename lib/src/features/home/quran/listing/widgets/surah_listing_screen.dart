import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/binding/quran_listing_deps.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_state.dart';

import 'quran_listing_body.dart';

final class SurahListingScreen
    extends Feature<QuranListingBloc, QuranListingState> {
  SurahListingScreen({super.key})
    : super(
        dependencies: QuranListingDependencies().inject,
        onUpdate: (context, state) => switch (state) {
          _ => null,
        },
      );

  @override
  Widget build(BuildContext context, QuranListingState state) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
        title: const Text(
          'Tajweed App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SurahListingBody(state),
    );
  }
}
