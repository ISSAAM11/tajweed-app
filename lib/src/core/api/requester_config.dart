import 'package:generic_requester/generic_requester.dart' hide Debugger;

import '../../app/environment/app_environment.dart';

abstract interface class RequesterConfig {
  static void configure() => RequestPerformer.configure(
    BaseOptions(
      baseUrl: AppEnvironment.current.baseUrl,
      connectTimeout: Duration(milliseconds: AppEnvironment.current.connectTimeout),
      sendTimeout: kIsWeb ? null : Duration(milliseconds: AppEnvironment.current.sendTimeout),
      receiveTimeout: Duration(milliseconds: AppEnvironment.current.receiveTimeout),
    ),
    interceptor: QueuedInterceptorsWrapper(
      onRequest: (options, handler) => handler.next(options),
      onResponse: (response, handler) => handler.next(response),
      onError: (error, handler) => handler.next(error),
    ),
    debuggingEnabled: true,
    mockingEnabled: false,
    mockingDurationInMs: 300,
  );
}
