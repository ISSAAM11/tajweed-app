import 'package:cg_core_defs/cg_core_defs.dart'
    show CacheManager, ConnectivityMonitor;
import 'package:generic_requester/generic_requester.dart'
    show RequestPerformer, Dio;
import 'package:shared_preferences/shared_preferences.dart';

class DataSource extends RequestPerformer {
  final ConnectivityMonitor connectivityMonitor;
  final CacheManager<SharedPreferences> cacheManager;

  DataSource({
    required Dio client,
    required this.cacheManager,
    required this.connectivityMonitor,
  }) : super(client);
}
