class HomeAction {
  final String title;
  final String? actionLabel;
  final String? levelLabel;
  final int? progressCurrent;
  final int? progressTotal;

  /// Asset path of the card illustration (an `AppImages` constant).
  final String iconAsset;
  final bool highlighted;
  final String? targetRoute;

  const HomeAction({
    required this.title,
    required this.iconAsset,
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
