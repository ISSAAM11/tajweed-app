/// Host the `dev` environment talks to. For the Android emulator, this must be
/// 10.0.2.2 (the emulator-accessible alias for the host machine). For a physical
/// device, override per-run with `flutter run --dart-define=DEV_HOST=<lan-ip>`.
const String _devHost = String.fromEnvironment(
  'DEV_HOST',
  defaultValue: '10.0.2.2',
);

enum Environment {
  mock(),
  dev(
    // This machine's LAN IP — reachable from BOTH a physical device on the same
    // Wi-Fi and the Android emulator. The backend must be bound to 0.0.0.0
    // (`runserver 0.0.0.0:8000`, as docker-compose does); the default
    // `runserver` binds 127.0.0.1 only, which no physical device can reach.
    // Override without editing this file:
    //   flutter run --dart-define=DEV_HOST=192.168.1.42
    baseUrl: "http://$_devHost:8000/api/",
    wsBaseUrl: "ws://$_devHost:8000",
  ),
  preprod(
    baseUrl: "https://tajeewd-ai.preprod.com/api/",
    wsBaseUrl: "wss://tajeewd-ai.preprod.com",
  ),
  prod(
    baseUrl: "https://tajeewd-ai.prod.com/api/",
    wsBaseUrl: "wss://tajeewd-ai.prod.com",
  ),
  test(baseUrl: "https://testing.com/api/");

  final String baseUrl;

  /// Base URL of the Django Channels (ASGI) WebSocket server, scheme included
  /// and no trailing slash (e.g. clients append `/ws/recitation/`).
  final String wsBaseUrl;
  final int connectTimeout;
  final int sendTimeout;
  final int receiveTimeout;

  const Environment({
    this.baseUrl = "",
    this.wsBaseUrl = "",
    this.connectTimeout = 20000,
    this.sendTimeout = 30000,
    this.receiveTimeout = 25000,
  });
}
