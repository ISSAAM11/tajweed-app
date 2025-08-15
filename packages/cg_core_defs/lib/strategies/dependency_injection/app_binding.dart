abstract class AppBindings {
  Future<void> asynchronous();
  void synchronous();

  Future<void> all() async => await asynchronous().then((_) => synchronous());
}
