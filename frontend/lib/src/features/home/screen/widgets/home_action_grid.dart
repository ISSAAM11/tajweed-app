import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/app/index.dart';
import 'package:tajweed_ai/src/features/home/screen/data/models/home_action.dart';

import 'home_action_card.dart';

class HomeActionGrid extends StatelessWidget {
  final List<HomeAction> actions;
  final void Function(HomeAction action) onActionTap;

  const HomeActionGrid({
    super.key,
    required this.actions,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.homeScreen;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: metrics.gridCrossSpacing,
        mainAxisSpacing: metrics.gridMainSpacing,
        childAspectRatio: metrics.gridChildAspectRatio,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return HomeActionCard(
          action: action,
          onTap: () => onActionTap(action),
        );
      },
    );
  }
}
