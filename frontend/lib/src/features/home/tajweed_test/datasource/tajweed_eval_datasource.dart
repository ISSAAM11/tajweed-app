import 'package:tajweed_ai/src/base/datasource/exports.dart';

/// Thrown when the hosted model is still loading (HF returns 503) — the
/// caller should surface a "try again shortly" message.
class ModelLoadingException implements Exception {
  const ModelLoadingException();
}

/// Transcribes a Quran recitation into fully vocalized Arabic text.
abstract interface class TajweedEvalDataSource {
  Future<String> transcribe(Uint8List wavBytes);
}

/// Hugging Face Inference API over a Quran-finetuned Whisper model.
///
/// Pass the token at build time: `flutter run --dart-define=HF_TOKEN=hf_xxx`.
final class HuggingFaceEvalDataSource implements TajweedEvalDataSource {
  static const String model = 'tarteel-ai/whisper-base-ar-quran';
  static const String _url =
      'https://router.huggingface.co/hf-inference/models/$model';

  // Dedicated client: the app's shared Dio carries the backend base URL and
  // auth interceptors, which must not leak to Hugging Face.
  final Dio _dio;
  final String _token;

  HuggingFaceEvalDataSource({
    Dio? dio,
    String token = const String.fromEnvironment('HF_TOKEN'),
  })  : _dio = dio ?? Dio(),
        _token = token;

  @override
  Future<String> transcribe(Uint8List wavBytes) async {
    final response = await _dio.post<Map<String, dynamic>>(
      _url,
      data: Stream<List<int>>.value(wavBytes),
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
          Headers.contentTypeHeader: 'audio/wav',
          Headers.contentLengthHeader: wavBytes.length,
        },
        responseType: ResponseType.json,
        validateStatus: (status) => status != null,
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    if (response.statusCode == 503) throw const ModelLoadingException();
    final text = response.data?['text'];
    if (response.statusCode != 200 || text is! String) {
      throw Exception('HF inference failed (${response.statusCode})');
    }
    return text;
  }
}
