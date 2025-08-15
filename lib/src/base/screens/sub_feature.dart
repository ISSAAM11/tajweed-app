import '../bloc/base_bloc.dart';
import 'exports.dart';

abstract class SubFeature<B extends BaseBloc<dynamic, S>, S, PB extends BaseBloc>
    extends Feature<B, S> {
  SubFeature({
    super.key,
    super.dependencies,
    super.lazy,
    super.updateWhen,
    super.onUpdate,
    super.fullRebuildWhen,
    super.debugStateChanges,
  });

  PB get parentBloc => get<PB>();
}
