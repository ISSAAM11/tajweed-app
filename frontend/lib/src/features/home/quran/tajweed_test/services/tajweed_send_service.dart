import 'package:generic_requester/generic_requester.dart' show Dio;

import 'package:tajweed_ai/src/base/datasource/exports.dart'
    show AppEnvironment;

/// Simple service that sends a test "pong" string to the backend.
final class TajweedSendService {
  final Dio _dio;

  TajweedSendService(this._dio);

  static const String endpoint = "apiendpoint/sendfile/";

  Future<void> sendTestPong() async {
    final baseUrl = AppEnvironment.current.baseUrl;
    print(endpoint);
    //  await _dio.post("$baseUrl$endpoint", data: {"text": "pong"});
  }
}
