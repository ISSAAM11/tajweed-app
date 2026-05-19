import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/page/binding/quran_page_deps.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_state.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/quran_page_body.dart';

String _displaySurahName(BuildContext context, QuranPageState state) {
  final isArabic = Localizations.localeOf(context).languageCode == 'ar';
  if (isArabic) return state.surahName;
  return state.surahNameSimple.isNotEmpty
      ? state.surahNameSimple
      : state.surahName;
}

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
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
                      _displaySurahName(context, state),
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
          ),
        ),
      ),
      backgroundColor: Color(0xfff5e9b9),
      body: SafeArea(top: false, child: QuranPageBody(state)),
    );
  }
}
