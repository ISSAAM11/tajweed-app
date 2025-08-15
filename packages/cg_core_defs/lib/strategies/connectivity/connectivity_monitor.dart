import 'package:flutter/widgets.dart';

import '../../core/components/observable.dart';
import '../../helpers/debugging_printer.dart';

export '../../core/components/observable.dart';

/// Represents different types of network connections
enum ConnectionType { wifi, mobile, ethernet, vpn, none }

/// Interface for monitoring connectivity status.
abstract class ConnectivityMonitor {
  /// Observable that tracks connectivity status changes.
  final isConnectedObs = Observable(true);

  /// Observable that tracks connection type changes.
  final connectionTypeObs = Observable<ConnectionType>(ConnectionType.none);

  /// Starts monitoring connectivity changes.
  @mustCallSuper
  void startMonitoring() {
    Debugger.magenta("$ConnectivityMonitor has started");
  }

  /// Stops monitoring connectivity changes.
  @mustCallSuper
  void stopMonitoring() {
    Debugger.magenta("$ConnectivityMonitor has stopped");
  }

  /// Current connectivity status.
  bool get isConnected => isConnectedObs.value;

  /// Current connection type.
  ConnectionType get connectionType => connectionTypeObs.value;

  /// Check if the current connection type is WiFi
  bool get isWifi => connectionType == ConnectionType.wifi;

  /// Check if the current connection type is mobile data
  bool get isMobile => connectionType == ConnectionType.mobile;

  /// Check if the current connection type is ethernet
  bool get isEthernet => connectionType == ConnectionType.ethernet;

  /// Check if the current connection type is VPN
  bool get isVpn => connectionType == ConnectionType.vpn;

  /// Check if the current connection type is none
  bool get isNone => connectionType == ConnectionType.none;
}
