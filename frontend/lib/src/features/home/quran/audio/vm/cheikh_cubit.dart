import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/cheikh_reciter.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/services/cheikh_preference_service.dart';

class CheikhCubit extends Cubit<CheikhReciter> {
  final CheikhPreferenceService _prefs;
  List<CheikhReciter> availableCheikhs;

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

  /// Called once the backend reciter catalog has synced into
  /// `cheikh_registry.db`, so newly added reciters show up without an app
  /// restart. Keeps the current selection (matched by id) if it still exists.
  void refreshAvailable(List<CheikhReciter> updated) {
    if (updated.isEmpty) return;
    availableCheikhs = updated;
    final current = updated.firstWhere(
      (c) => c.id == state.id,
      orElse: () => updated.first,
    );
    if (current != state) emit(current);
  }
}
