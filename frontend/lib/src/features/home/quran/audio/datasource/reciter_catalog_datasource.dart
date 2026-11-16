import 'package:tajweed_ai/src/base/datasource/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/datasource/reciter_catalog_model.dart';

abstract interface class ReciterCatalogDataSource {
  static const String endpoint = "reciters";

  /// The full reciter list, with a download URL for each one's timing
  /// database. Used to keep the bundled `cheikh_registry.db` in sync without
  /// shipping every reciter's (multi-MB) timing database as an app asset.
  FutureRequestResult<ReciterCatalogModel> getReciters();
}

final class ReciterCatalogDataSourceImpl extends DataSource
    implements ReciterCatalogDataSource {
  ReciterCatalogDataSourceImpl({
    required super.client,
    required super.cacheManager,
    required super.connectivityMonitor,
  });

  @override
  FutureRequestResult<ReciterCatalogModel> getReciters() async {
    if (!connectivityMonitor.isConnected) {
      return Left(Exception('No internet connection'));
    }

    return await performDecodingRequest(
      decodableModel: ReciterCatalogModel.empty(),
      method: RestfulMethods.get,
      path: "${ReciterCatalogDataSource.endpoint}/",
      mockingData: null,
      mockIt: false,
    );
  }
}
