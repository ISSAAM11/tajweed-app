import 'package:equatable/equatable.dart';
import 'package:tajweed_ai/src/base/bloc/exports.dart';
import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/cache/listing_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/recitation/recitation_words.dart'
    show arabicLetter;
import 'package:tajweed_ai/src/helpers/quran_text_parser.dart';

part 'hifth_events.dart';
part 'hifth_states.dart';
part 'usecases/hifth_uc.dart';

class HifthBloc extends BaseBloc<HifthEvent, HifthState> {
  //! Data Sources
  final QuranPageDao _dao;
  final LastSelectedSurahService _lastRead;

  HifthBloc(this._dao, this._lastRead) : super(const HifthLoading()) {
    on<LoadSurah>(_onLoadSurah);
    on<AyahRead>(_onAyahRead);
  }
}
