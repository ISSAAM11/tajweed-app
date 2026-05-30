import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/page/binding/quran_page_deps.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_state.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/quran_page_body.dart';
import 'package:tajweed_ai/src/features/home/quran/tajweed_test/vm/tajweed_send_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/tajweed_test/services/tajweed_send_service.dart';

final class TajweedScreen extends Feature<QuranPageBloc, QuranPageState> {
  final QuranPageArgs args;
  TajweedScreen({super.key, required this.args})
    : super(
        // Reuse the existing QuranPageDependencies for page data/bloc.
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
    return BlocProvider<TajweedSendBloc>(
      // Create the send bloc locally, using the shared Dio from DI.
      create: (_) => TajweedSendBloc(TajweedSendService(get())),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: AppBar(
                  title: BlocBuilder<QuranPageBloc, QuranPageState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Text(
                            "This is a test screen ",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
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
                ),
              ),
            ),
            floatingActionButton: IconButton(
              onPressed: () {
                context.read<TajweedSendBloc>().sendTestPong();
              },
              icon: const Icon(Icons.send),
              color: AppColors.greyDarkest,
              iconSize: 32,
              style: IconButton.styleFrom(
                backgroundColor: AppColors.greyDarkest,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
              ),
            ),
            backgroundColor: const Color(0xfff5e9b9),
            body: QuranPageBody(state),
          );
        },
      ),
    );
  }
}
