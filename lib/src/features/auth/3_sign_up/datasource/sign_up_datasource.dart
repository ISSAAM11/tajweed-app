import '../../../../base/datasource/exports.dart';
import '../data/models/activate_account_response.dart';
import '../data/models/sign_up_model.dart';

part 'mock/sign_up_mock.dart';

abstract interface class SignUpDataSource {
  static const String registerEndpoint = "auth/register/";
  static const String resendEndpoint = "auth/resend-activation-code/";
  static const String activationEndPoint = "auth/activate-account/";

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

  FutureRequestResult<ActivateAccountResponse> activateAccount({
    required String email,
    required String code,
  });

  /// Calls the Resend Activation Code endpoint
  FutureRequestResult<SignUpModelResponse> resendActivationCode({
    required String email,
  });

  /// Save user tokens and data
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });
}

final class SignUpDataSourceImpl extends DataSource
    implements SignUpDataSource {
  SignUpDataSourceImpl({
    required super.client,
    required super.cacheManager,
    required super.connectivityMonitor,
  });

  final bool mockIt = false;

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
          "email": email,
          "password": password,
          "first_name": firstNmae,
          "last_name": lasttNmae,
          "country_code": country,
          "birthday": birthDate,
          "gender": gender,
        },
        path: SignUpDataSource.registerEndpoint,
        mockingData: _mockSignUpSuccess(),
        mockIt: mockIt,
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final errorMessage = responseData is Map<String, dynamic>
          ? (responseData['info'] ?? "Unknown server error")
          : e.message ?? "Unknown Dio error";
      if (errorMessage == "EMAIL_ALREADY_EXISTS") {
        return Left(Exception("Email already in use"));
      }
      return Left(Exception(errorMessage));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  FutureRequestResult<ActivateAccountResponse> activateAccount({
    required String email,
    required String code,
  }) async {
    if (!connectivityMonitor.isConnected)
      return Left(Exception('No internet connection'));

    try {
      return await performDecodingRequest(
        decodableModel: ActivateAccountResponse.empty(),
        method: RestfulMethods.post,
        body: {"email": email, "code": code},
        path: SignUpDataSource.activationEndPoint,
        mockingData: _mockActivateAccountSuccess(),
        mockIt: mockIt,
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final errorMessage = responseData is Map<String, dynamic>
          ? (responseData['info'] ?? "Unknown server error")
          : e.message ?? "Unknown Dio error";
      if (errorMessage == "INVALID_CODE") {
        return Left(Exception("Code is invalid"));
      } else if (errorMessage == "EXPIRED_CODE") {
        return Left(Exception("Code is expired"));
      }
      return Left(Exception(errorMessage));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  FutureRequestResult<SignUpModelResponse> resendActivationCode({
    required String email,
  }) async {
    if (!connectivityMonitor.isConnected)
      return Left(Exception('No internet connection'));

    try {
      return await performDecodingRequest(
        decodableModel: SignUpModelResponse.empty(),
        method: RestfulMethods.post,
        body: {"email": email},
        path: SignUpDataSource.resendEndpoint,
        mockingData: _mockResendPinSuccess(),
        mockIt: mockIt,
      );
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final secureCache = cacheManager as CacheManagerImpl;
    await secureCache.setSecureString('access_token', accessToken);
    Debugger.red(accessToken);
    await secureCache.setSecureString('refresh_token', refreshToken);
    Debugger.green(accessToken);
  }
}
