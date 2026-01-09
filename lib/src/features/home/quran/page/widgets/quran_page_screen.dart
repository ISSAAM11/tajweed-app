import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/page/binding/quran_page_deps.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_state.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/quran_page_body.dart';

final class QuranPageScreen extends Feature<QuranPageBloc, QuranPageState> {
  final QuranPageArgs args;
  QuranPageScreen({super.key, required this.args})
    : super(
        dependencies: QuranPageDependencies().inject,
        onInit: (context, bloc) {
          bloc.initToVerse(args.verseKey);
        },
        onUpdate: (context, state) => switch (state) {
          _ => null,
        },
      );

  @override
  Widget build(BuildContext context, QuranPageState state) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<QuranPageBloc, QuranPageState>(
          builder: (context, state) {
            return Column(
              children: [
                Text(
                  state.surahName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ],
            );
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.scaffold,
      body: QuranPageBody(state),
    );
  }
}
