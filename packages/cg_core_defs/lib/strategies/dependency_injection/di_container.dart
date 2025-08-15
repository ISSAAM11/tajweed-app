import 'dart:async';

/// Interface for a Dependency Injection (DI) Container.
abstract class DependecyInjectionContainer<A> {
  /// The actor instance that manages the dependencies.
  A get actor;

  //* Instance

  /// Register an existing instance as a singleton.
  void registerInstance<T extends Object>(T instance, {String? name}) {
    throw UnimplementedError("registerInstance not defined");
  }

  /// Register an asynchronous instance.
  void registerInstanceAsync<T extends Object>(Future<T> Function() factoryFunc, {String? name}) {
    throw UnimplementedError("registerInstanceAsync not defined");
  }

  //? Factory

  /// Register a factory function that creates a new instance each time it is requested. //! mandatory
  void registerFactory<T extends Object>(T Function() factoryFunc, {String? name});

  /// Register an asynchronous factory function.
  void registerFactoryAsync<T extends Object>(Future<T> Function() factoryFunc, {String? name}) {
    throw UnimplementedError("registerFactoryAsync not defined");
  }

  //= Singleton

  /// Register a singleton instance. //! mandatory
  void registerSingleton<T extends Object>(T instance,
      {String? name, bool? signalsReady, FutureOr<dynamic> Function(T)? dispose});

  /// Register a singleton with an asynchronous factory function.
  void registerSingletonAsync<T extends Object>(Future<T> Function() factoryFunc,
      {String? name,
      Iterable<Type>? dependsOn,
      bool? signalsReady,
      FutureOr<dynamic> Function(T)? dispose}) {
    throw UnimplementedError("registerSingletonAsync not defined");
  }

  //= Lazy Singleton

  /// Register a lazy singleton with a factory function.
  void registerLazySingleton<T extends Object>(T Function() factoryFunc,
      {String? name, FutureOr<dynamic> Function(T)? dispose}) {
    throw UnimplementedError("registerLazySingleton not defined");
  }

  /// Register a lazy singleton with an asynchronous factory function.
  void registerLazySingletonAsync<T extends Object>(Future<T> Function() factoryFunc,
      {String? instanceName, FutureOr Function(T)? dispose}) {
    throw UnimplementedError("registerLazySingletonAsync not defined");
  }

  /// Retrieve an instance of a registered type.
  T get<T extends Object>();

  /// Retrieve an instance of a registered type with an optional name.
  T getNamed<T extends Object>(String name);

  /// Check if a type is already registered.
  bool isRegistered<T extends Object>({String? name});

  /// Unregister a type.
  void unregister<T extends Object>({String? name});

  /// Clear all registered types.
  void clear();
}
