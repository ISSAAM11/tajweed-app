import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/ayah_meta_helper_models.dart'
    show PartitionMode;
import 'package:tajweed_ai/src/database/daos/quran_dao.dart';

abstract interface class QuranMetaDatasource {
  Stream<AyahMetaRow?> watchPageMeta(int pageNo);
  Future<int?> getPartitionForAyah(PartitionMode mode, int globalIndex);
}

final class QuranMetaDatasourceImpl implements QuranMetaDatasource {
  final QuranDao dao;

  QuranMetaDatasourceImpl({required this.dao});

  @override
  Future<int?> getPartitionForAyah(PartitionMode mode, int globalIndex) =>
      dao.getPartitionForAyah(mode, globalIndex);

  @override
  Stream<AyahMetaRow?> watchPageMeta(int pageNo) => dao.watchPageMeta(pageNo);
}
