enum Environment {
  mock(),
  dev(baseUrl: "https://tajeewd-ai.dev.com/api/"),
  preprod(baseUrl: "https://tajeewd-ai.preprod.com/api/"),
  prod(baseUrl: "https://tajeewd-ai.prod.com/api/"),
  test(baseUrl: "https://testing.com/api/");

  final String baseUrl;
  final int connectTimeout;
  final int sendTimeout;
  final int receiveTimeout;

  const Environment({
    this.baseUrl = "",
    this.connectTimeout = 20000,
    this.sendTimeout = 30000,
    this.receiveTimeout = 25000,
  });
}
