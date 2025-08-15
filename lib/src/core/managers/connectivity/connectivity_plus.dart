import 'package:cg_core_defs/cg_core_defs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import '../../../app/binding/app_bindings.dart';

class ConnectivityPlus extends ConnectivityMonitor {
  final Connectivity _connectivity;

  ConnectivityPlus(this._connectivity);

  @visibleForTesting
  ConnectivityPlus.mock(this._connectivity);

  @override
  void startMonitoring() {
    super.startMonitoring();

    _connectivity.onConnectivityChanged.listen(
      (result) => isConnectedObs.updateIfDifferent(!result.contains(ConnectivityResult.none)),
    );
  }

  static void init() => get<ConnectivityMonitor>().startMonitoring();
}
