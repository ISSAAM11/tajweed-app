import 'package:equatable/equatable.dart';
import 'package:tajweed_ai/src/database/daos/ayah_meta_helper_models.dart';

sealed class QuranPageState extends Equatable {
  final PartitionMode partitionMode;
  const QuranPageState(this.partitionMode);

  @override
  List<Object?> get props => [partitionMode];
}

final class QuranPageLoadingState extends QuranPageState {
  const QuranPageLoadingState(super.partitionMode);
}

final class QuranPageLoadedState extends QuranPageState {
  final List<dynamic> ayat; // replace dynamic with your Ayah entity
  const QuranPageLoadedState(super.partitionMode, this.ayat);

  @override
  List<Object?> get props => [partitionMode, ayat];
}

final class QuranPageErrorState extends QuranPageState {
  final String message;
  const QuranPageErrorState(super.partitionMode, this.message);

  @override
  List<Object?> get props => [partitionMode, message];
}
