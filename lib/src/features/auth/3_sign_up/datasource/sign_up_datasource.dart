import '../../../../base/datasource/exports.dart';
import '../data/models/sign_up_model.dart';

part 'mock/sign_up_mock.dart';

abstract interface class SignUpDataSource {
  static const String endpoint = "sign-up";

  /// Calls the Sign In API endpoints.
  FutureRequestResult<SignUpModel> signUpWithEmailAndPassword({
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
  FutureRequestResult<SignUpModel> signUpWithEmailAndPassword({
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
        decodableModel: SignUpModel.empty(),
        method: RestfulMethods.post,
        body: {
          "first_name": firstNmae,
          "last_name": lasttNmae,
          "birthday": birthDate,
          "gender": gender,
          "country": country,
          "email": email,
          "password": password,
        },
        path: SignUpDataSource.endpoint,
        mockingData: _mockSignUpWithEmailAndPassword(),
        mockIt: true,
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
