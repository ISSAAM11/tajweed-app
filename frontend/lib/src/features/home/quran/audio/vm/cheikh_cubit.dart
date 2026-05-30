import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/cheikh_reciter.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/services/cheikh_preference_service.dart';

class CheikhCubit extends Cubit<CheikhReciter> {
  final CheikhPreferenceService _prefs;
  final List<CheikhReciter> availableCheikhs;

  CheikhCubit(
    this._prefs,
    this.availableCheikhs,
    String savedId,
  ) : super(
          availableCheikhs.firstWhere(
            (c) => c.id == savedId,
            orElse: () => availableCheikhs.first,
          ),
        );

  Future<void> select(CheikhReciter cheikh) async {
    if (state == cheikh) return;
    await _prefs.set(cheikh.id);
    emit(cheikh);
  }
}
