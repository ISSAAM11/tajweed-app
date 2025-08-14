import '../../../../../core/api/requester_config.dart';
// import '../enums/note_type.dart';
// import '../models/shift_report_do.dart';

part '../mock/sign_in_mock.dart';

abstract interface class SignInDataSource {
  static const String signInEndpoint = "sign-in";
  static const String forgotPasswordEndpoint = "forgot-password";

  /// Calls the sign in API endpoints.
  void signIn(String email, String password);

  /// Calls the forgot password API endpoints.
  void forgotPassword(String email);
}

final class SignInDataSourceImpl extends RequestPerformer
    implements SignInDataSource {
  final ConnectivityMonitor _connectivityMonitor;

  SignInDataSourceImpl({
    required Dio client,
    required CacheManager cacheManager,
    required ConnectivityMonitor connectivityMonitor,
  }) : _connectivityMonitor = connectivityMonitor,
       super(client);

  @override
  void signIn(String email, String password) {
    _connectivityMonitor.startMonitoring();
    //TODO: implement signIn
  }

  @override
  void forgotPassword(String email) {
    _connectivityMonitor.startMonitoring();
    //TODO: implement forgotPassword
  }
}
