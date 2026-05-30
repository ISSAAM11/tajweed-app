import '../../../../base/datasource/exports.dart';
import '../data/models/sign_in_model.dart';

part 'mock/sign_in_mock.dart';

abstract interface class SignInDataSource {
  static const String endpoint = "sign-in";

  /// Calls the Sign In API endpoints.
  FutureRequestResult<SignInModel> signInWithEmailAndPassword(
    String email,
    String password,
  );

  /// Calls the Sign In API endpoints.
  FutureRequestResult<SignInModel> signInWithGoogle();

  /// Calls the Sign In API endpoints.
  FutureRequestResult<SignInModel> signInWithFacebook();
}

final class SignInDataSourceImpl extends DataSource
    implements SignInDataSource {
  SignInDataSourceImpl({
    required super.client,
    required super.cacheManager,
    required super.connectivityMonitor,
  });

  // final responseMock = ResponseMock.success;

  @override
  FutureRequestResult<SignInModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (!connectivityMonitor.isConnected)
      return Left(Exception('No internet connection'));

    return await performDecodingRequest(
      decodableModel: SignInModel.empty(),
      method: RestfulMethods.post,
      body: {"language": "en", "email": email, "password": password},
      path: SignInDataSource.endpoint,
      mockingData: _mockSignInWithEmailAndPassword(),
      mockIt: true,
    );
  }

  @override
  FutureRequestResult<SignInModel> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  FutureRequestResult<SignInModel> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }
}

// enum ResponseMock { noInternet, noData, success, failure }
