import '../bloc/base_bloc.dart';
import '../dependencies/dependencies.dart';
import 'exports.dart';

/// A base widget for providing a Bloc to its child widget tree. It allows you to inject
/// dependencies and manage the lifecycle of the provided Bloc.
///
/// Example:
/// ```dart
/// class LoginScreen extends Feature<LoginBloc> {
///   ProductDetailsScreenEnum({super.key})
///      :  super(
///           dependencies: ProductScreenDependencies(),
///         );
///
///   @override
///   Widget build(BuildContext context) {
///     return BlocBuilder<LoginBloc, LoginState>(
///       builder: (context, state) {
///         return switch (state) {
///           Idle() => const IdleWidget(),
///           Loading() => const LoadingWidget(),
///           Error(message: final String message) => ErrorWidget(message: message),
///           Empty() => const EmptyWidget(),
///           Success() => SuccessWidget(),
///         };
///       },
///     );
///   }
/// }
/// ```
///
/// Where:
/// - `IdleWidget`: A widget displayed when the state is idle.
/// - `LoadingWidget`: A widget displayed when the state is loading.
/// - `ErrorWidget`: A widget displayed when an error occurs. It takes a message as a parameter.
/// - `EmptyWidget`: A widget displayed when the state is empty.
/// - `SuccessWidget`: A widget displayed when the state is successful, typically containing a list of products.
/// - [dependencies] allows dependency injection
abstract class Feature<B extends BaseBloc<dynamic, S>, S> extends StatefulWidget {
  /// Creates a [Feature].
  ///
  /// - [dependencies]: Optional. A [Dependencies] instance for lazy or eager dependency injection.
  /// - [lazy]: Whether to create the [Bloc] lazily or eagerly. Defaults to `true` (lazy).
  /// - [buildWhen]: Optional. A function that decides when to rebuild the widget based on the previous
  /// and current state of the [Bloc].
  Feature({
    super.key,
    this.dependencies,
    this.lazy = true,
    this.updateWhen,
    this.onUpdate,
    this.fullRebuildWhen,
    this.debugStateChanges = false,
  });

  final VoidCallback? dependencies;

  /// Whether to create the [Bloc] lazily or eagerly. Defaults to `true`.
  final bool lazy;

  /// A function that determines when to rebuild the widget based on the previous and current state.
  /// If `null`, the widget will rebuild on every state change.
  final BlocBuilderCondition<dynamic>? updateWhen;

  final void Function(BuildContext, dynamic)? onUpdate;
  final bool Function(BuildContext, dynamic)? fullRebuildWhen;

  /// Whether to print state changes to the console. Defaults to `false`.
  final bool debugStateChanges;

  /// The [Bloc] provided to the widget.
  B get bloc => _state!.bloc;

  _State<B, S>? _state;

  @override
  createState() => _State<B, S>();

  /// Builds the widget's UI based on the current [BuildContext].
  /// You must implement this in subclasses to define the widget's content.
  @protected
  Widget build(BuildContext context, S state);
}

class _State<B extends BaseBloc<dynamic, S>, S> extends State<Feature<B, S>> {
  late final B bloc; // Ensures bloc persists

  @override
  @protected
  void initState() {
    super.initState();
    widget._state = this;
    widget.dependencies?.call();
    bloc = get<B>(); // Initialize bloc only once
  }

  @override
  void didUpdateWidget(covariant Feature<B, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget._state = this;
  }

  @override
  void dispose() {
    bloc.onDispose();
    widget._state = null;
    super.dispose();
  }

  @override
  @protected
  Widget build(BuildContext context) => BlocProvider<B>.value(
    value: bloc,
    child: BlocConsumer<B, S>(
      builder: widget.build,
      listener: (context, state) {
        setState.execute(
          () => () {
            Debugger.white('${widget.runtimeType} rebuilt');
          },
          when: widget.fullRebuildWhen?.call(context, state),
        );
        if (widget.onUpdate != null) widget.onUpdate!.call(context, state);

        if (widget.debugStateChanges)
          Debugger.cyan('${widget.runtimeType} state: ${state.toString().split('(').first}');
      },
    ),
  );
}
