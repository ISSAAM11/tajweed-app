import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/quran_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

abstract interface class QuranMetaDatasource {
  Stream<AyahMetaRow?> watchPageMeta(int pageNo);
  Future<int?> getPartitionForAyah(PartitionMode mode, VerseKey key);
}

final class QuranMetaDatasourceImpl implements QuranMetaDatasource {
  final QuranDao dao;

  QuranMetaDatasourceImpl({required this.dao});

  @override
  Future<int?> getPartitionForAyah(PartitionMode mode, VerseKey key) =>
      dao.getPartitionForAyah(mode, key);

  @override
  Stream<AyahMetaRow?> watchPageMeta(int pageNo) => dao.watchPageMeta(pageNo);
}
