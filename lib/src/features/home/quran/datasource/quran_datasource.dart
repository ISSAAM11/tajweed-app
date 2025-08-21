import 'package:tajweed_ai/src/base/datasource/exports.dart';
import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/quran_dao.dart';

// part 'quran_datasource_mock.dart';

abstract interface class QuranDatasource {
  Future<List<ChapterRow>> getChapters();
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
  Future<List<ChapterRow>> getChapters() {
    return dao.getAllChapters();
  }

  // final responseMock = ResponseMock.success;

  // @override
  // FutureRequestResult<Bookmarks> getUserBookmarks() {
  //   // TODO: implement getUserBookmarks
  //   throw UnimplementedError();
  // }
}

// enum ResponseMock { noInternet, noData, success, failure }
