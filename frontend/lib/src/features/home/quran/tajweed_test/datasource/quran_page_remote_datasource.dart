import 'package:tajweed_ai/src/base/datasource/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';

abstract interface class QuranPageRemoteDataSource {
  static const String endpoint = "quran/page-title";

  /// Fetches the title for a specific page from the backend
  FutureRequestResult<PageTitleModel> getPageTitle(int pageNo);
}

final class QuranPageRemoteDataSourceImpl extends DataSource
    implements QuranPageRemoteDataSource {
  QuranPageRemoteDataSourceImpl({
    required super.client,
    required super.cacheManager,
    required super.connectivityMonitor,
  });

  @override
  FutureRequestResult<PageTitleModel> getPageTitle(int pageNo) async {
    if (!connectivityMonitor.isConnected) {
      return Left(Exception('No internet connection'));
    }

    return await performDecodingRequest(
      decodableModel: PageTitleModel.empty(),
      method: RestfulMethods.get,
      path: "${QuranPageRemoteDataSource.endpoint}/$pageNo",
      // Alternative: if your endpoint uses query parameters instead
      // path: QuranPageRemoteDataSource.endpoint,
      // queryParameters: {'pageNo': pageNo},
      mockingData: null,
      mockIt: false,
    );
  }
}
