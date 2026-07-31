import 'package:flutter/widgets.dart' show IconData;

class HomeAction {
  final String title;
  final String? actionLabel;
  final String? levelLabel;
  final int? progressCurrent;
  final int? progressTotal;
  final IconData icon;
  final bool highlighted;
  final String? targetRoute;

  const HomeAction({
    required this.title,
    required this.icon,
    required this.highlighted,
    this.actionLabel,
    this.levelLabel,
    this.progressCurrent,
    this.progressTotal,
    this.targetRoute,
  });

  bool get hasProgress => levelLabel != null;
  bool get hasActionLabel => actionLabel != null;
}
