import '../bloc/base_bloc.dart';
import 'exports.dart';

abstract class SubWidget<B extends BaseBloc> extends StatelessWidget {
  /// and current state of the [Bloc].
  const SubWidget({super.key});

  /// con
  B get bloc => get<B>();

  /// Builds the widget's UI based on the current [BuildContext].
  /// You must implement this in subclasses to define the widget's content.
  @override
  @protected
  Widget build(BuildContext context);
}
