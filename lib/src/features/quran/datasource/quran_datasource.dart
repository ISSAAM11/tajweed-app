// import 'package:tajweed_ai/src/base/datasource/exports.dart';
import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/quran_dao.dart';

import '../../../base/datasource/exports.dart';

part 'quran_datasource_mock.dart';

abstract interface class QuranDatasource {
  Future<List<Chapter>> getChapters();
}

final class QuranDatasourceImpl extends DataSource implements QuranDatasource {
  final QuranDao dao;

  QuranDatasourceImpl({
    required super.client,
    required super.cacheManager,
    required super.connectivityMonitor,
    required this.dao,
  });

  @override
  Future<List<Chapter>> getChapters() {
    return dao.getChapters();
  }

  // final responseMock = ResponseMock.success;

  // @override
  // FutureRequestResult<Bookmarks> getUserBookmarks() {
  //   // TODO: implement getUserBookmarks
  //   throw UnimplementedError();
  // }
}

// enum ResponseMock { noInternet, noData, success, failure }
