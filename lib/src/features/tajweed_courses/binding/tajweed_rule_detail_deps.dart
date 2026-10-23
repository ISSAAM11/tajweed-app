import 'package:tajweed_ai/src/app/binding/app_bindings.dart';

import '../vm/tajweed_rule_detail_bloc.dart';

class TajweedRuleDetailDeps {
  final String ruleId;

  TajweedRuleDetailDeps({required this.ruleId});

  void inject() {
    di.registerInstance<TajweedRuleDetailBloc>(
      TajweedRuleDetailBloc(ruleId: ruleId),
    );
  }
}
