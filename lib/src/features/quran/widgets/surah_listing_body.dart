//? Base needed imports

import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/quran/vm/quran_bloc.dart';
import 'package:tajweed_ai/src/features/quran/vm/quran_events.dart';
import 'package:tajweed_ai/src/features/quran/widgets/surah_name_card.dart';

import '../vm/quran_state.dart';

class SurahListingBody extends SubWidget<QuranBloc> {
  final QuranState state;

  const SurahListingBody(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranBloc, QuranState>(
      builder: (context, state) {
        if (state is QuranLoadedState) {
          return AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 500),
            child: ListView(
              children: state.chapters
                  .map(
                    (c) => SurahNameCard(
                      name: c.nameArabic,
                      nameEnglish: c.name,
                      glyph: c.nameGlyph,
                      revelationPlace: c.revelationPlace == 'makkah'
                          ? RevelationPlace.makkah
                          : RevelationPlace.madinah,
                      orderNumber: c.id,
                      onTap: () {
                        context.read<QuranBloc>().add(
                          QuranSurahSelectedEvent(c.id),
                        );
                        Debugger.yellow('${c.name} tapped');
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        } else if (state is QuranErrorState) {
          return Center(child: Text("Error: ${state.message}"));
        }
        // QuranInitialState (very brief)
        return AnimatedOpacity(
          opacity: 0.0,
          duration: const Duration(milliseconds: 500),
          child: SizedBox.expand(), // placeholder
        );
      },
    );
  }
}
