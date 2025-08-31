import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/binding/quran_deps.dart';
import 'package:tajweed_ai/src/features/home/quran/screen/router/quran_page_router.dart';
import 'package:tajweed_ai/src/features/home/quran/screen/widgets/quran_page_body.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_page/quran_page_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_page/quran_page_state.dart';

final class QuranPageScreen extends Feature<QuranPageBloc, QuranPageState> {
  final QuranPageArgs args;
  QuranPageScreen({super.key, required this.args})
    : super(
        // TODO: separate dependencies
        dependencies: QuranDependencies().inject,
        onUpdate: (context, state) => switch (state) {
          _ => null,
        },
      );

  @override
  Widget build(BuildContext context, QuranPageState state) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: QuranPageBody(state),
    );
  }
}
