import '../../../../base/datasource/exports.dart';
import '../data/models/sign_up_model.dart';

part 'mock/sign_up_mock.dart';

abstract interface class SignUpDataSource {
  static const String endpoint = "sign-up";

  /// Calls the Sign In API endpoints.
  FutureRequestResult<void> signUpWithEmailAndPassword(
    String email,
    String password,
  );

  /// Calls the Forgot Password API endpoints.
  FutureRequestResult<String> signUpWithGoogle(String email, String password);

  /// Calls the Forgot Password API endpoints.
  FutureRequestResult<String> signUpWithFacebook(String email, String password);
}

final class SignUpDataSourceImpl extends DataSource
    implements SignUpDataSource {
  SignUpDataSourceImpl({
    required super.client,
    required super.cacheManager,
    required super.connectivityMonitor,
  });

  // final responseMock = ResponseMock.success;

  @override
  FutureRequestResult<void> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (!connectivityMonitor.isConnected)
      return Left(Exception('No internet connection'));

    return await performDecodingRequest(
      decodableModel: SignUpModel.empty(),
      method: RestfulMethods.post,
      body: {"language": "en", "email": email, "password": password},
      path: SignUpDataSource.endpoint,
      mockingData: _mockSignUpWithEmailAndPassword(),
      mockIt: true,
    );
  }

  @override
  FutureRequestResult<String> signUpWithGoogle(
    String email,
    String password,
  ) async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => Right('Success'),
    );
  }

  @override
  FutureRequestResult<String> signUpWithFacebook(
    String email,
    String password,
  ) async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => Right('Success'),
    );
  }
}

// enum ResponseMock { noInternet, noData, success, failure }
