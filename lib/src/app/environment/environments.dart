enum Environment {
  mock(),
  dev(
    baseUrl: "http://10.220.251.168:8000/api/",
    // Physical device on the same Wi-Fi → this machine's LAN IP. Run the backend
    // with `runserver 0.0.0.0:8000` and allow port 8000 through the firewall.
    // (Android emulator instead uses ws://10.0.2.2:8000.)
    wsBaseUrl: "ws://192.168.1.4:8000",
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
