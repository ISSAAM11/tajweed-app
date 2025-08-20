import '../../../../base/datasource/exports.dart';
import '../data/models/sign_up_model.dart';

part 'mock/sign_up_mock.dart';

abstract interface class SignUpDataSource {
  static const String endpoint = "auth/register/";

  /// Calls the Sign In API endpoints.
  FutureRequestResult<SignUpModelResponse> signUpWithEmailAndPassword({
    required String firstNmae,
    required String lasttNmae,
    required String birthDate,
    required String email,
    required String password,
    required String gender,
    required String country,
  });

  /// Calls the Forgot Password API endpoints.
  FutureRequestResult<String> verifyEmail(String email);
}

final class SignUpDataSourceImpl extends DataSource
    implements SignUpDataSource {
  SignUpDataSourceImpl({
    required super.client,
    required super.cacheManager,
    required super.connectivityMonitor,
  });

  @override
  FutureRequestResult<SignUpModelResponse> signUpWithEmailAndPassword({
    required String firstNmae,
    required String lasttNmae,
    required String birthDate,
    required String gender,
    required String country,
    required String email,
    required String password,
  }) async {
    if (!connectivityMonitor.isConnected)
      return Left(Exception('No internet connection'));
    try {
      return await performDecodingRequest(
        decodableModel: SignUpModelResponse.empty(),
        method: RestfulMethods.post,
        body: {
          "email": "innocent21@powerscrews.com",
          "password": "password",
          "first_name": "aaa",
          "last_name": "bbb",
          "country_code": "TN",
          "birthday": "2000-01-01",
          "gender": "M",
        },
        path: SignUpDataSource.endpoint,
        mockingData: _mockSignUpSuccess(),
        mockIt: false,
      );
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  FutureRequestResult<String> verifyEmail(String emai) async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => Right('Success'),
    );
  }
}
