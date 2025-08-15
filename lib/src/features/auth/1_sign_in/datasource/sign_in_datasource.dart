import '../../../../base/datasource/exports.dart';
import '../data/models/user.dart';

part 'mock/sign_in_mock.dart';

abstract interface class SignInDataSource {
  static const String endpoint = "sign-in";

  /// Calls the Sign In API endpoints.
  FutureRequestResult<User> signInWithEmailAndPassword(String email, String password);

  /// Calls the Forgot Password API endpoints.
  FutureRequestResult<String> forgotPassword(String email);
}

final class SignInDataSourceImpl extends DataSource implements SignInDataSource {
  SignInDataSourceImpl({    
    required super.client,
    required super.cacheManager,
    required super.connectivityMonitor,
  });

  final responseMock = ResponseMock.failure;

  @override
  FutureRequestResult<User> signInWithEmailAndPassword(String email, String password) async =>
      switch (responseMock) {
        //! Failure
        ResponseMock.failure => Future.delayed(
          const Duration(milliseconds: 500),
          () => Left(Exception('Failure')),
        ),
        //$ No internet
        ResponseMock.noInternet => Future.delayed(
          const Duration(milliseconds: 500),
          () => Left(Exception('No internet connection')),
        ),
        //? No data
        ResponseMock.noData => Future.delayed(
          const Duration(milliseconds: 500),
          () => Right(User.empty()),
        ),
        //+ Success
        ResponseMock.success => await performDecodingRequest(
          decodableModel: User.empty(),
          method: RestfulMethods.post,
          body: {
            "email": email,
            "password": password,
          },
          path: SignInDataSource.endpoint,
          mockingData: _mockSignIn(),
          mockIt: true,
        ),
      };

  @override
  FutureRequestResult<String> forgotPassword(String email) async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => Right('Success'),
    );
  }


}

enum ResponseMock { noInternet, noData, success, failure }
