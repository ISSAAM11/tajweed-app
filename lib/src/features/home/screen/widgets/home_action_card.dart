import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/app/index.dart';
import 'package:tajweed_ai/src/features/home/screen/data/models/home_action.dart';

class HomeActionCard extends StatelessWidget {
  final HomeAction action;
  final VoidCallback onTap;

  const HomeActionCard({super.key, required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.homeActionCard;
    final isHighlighted = action.highlighted;

    final backgroundColor = isHighlighted
        ? AppColors.primaryLight
        : AppColors.scaffold;
    final foregroundColor = isHighlighted
        ? AppColors.greyDarkest
        : AppColors.greyDarkest;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(metrics.radius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: metrics.contentPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(metrics.radius),
            border: isHighlighted
                ? null
                : Border.all(
                    color: AppColors.primaryLight,
                    width: metrics.borderWidth,
                  ),
            gradient: isHighlighted ? AppColors.secondaryGradient : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(action.icon, size: metrics.iconSize, color: foregroundColor),
              SizedBox(height: metrics.titleSpacing),
              Text(
                action.title,
                textAlign: TextAlign.center,
                style: AppFonts.lato
                    .withSize(FontSizes.title)
                    .withColor(foregroundColor)
                    .semiBold(),
              ),
              SizedBox(height: metrics.progressBarHeight),
              if (action.hasProgress)
                _ProgressBadge(action: action, foreground: foregroundColor)
              else if (action.hasActionLabel)
                _ActionLabelBadge(
                  label: action.actionLabel!,
                  isHighlighted: isHighlighted,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionLabelBadge extends StatelessWidget {
  final String label;
  final bool isHighlighted;

  const _ActionLabelBadge({required this.label, required this.isHighlighted});

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.homeActionCard;
    final backgroundColor = isHighlighted
        ? AppColors.scaffold
        : AppColors.secondary;
    return Container(
      padding: metrics.badgePadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(metrics.badgeRadius),
      ),
      child: Text(
        label,
        style: AppFonts.lato
            .withSize(FontSizes.indication)
            .withColor(AppColors.greyDarkest)
            .medium(),
      ),
    );
  }
}

class _ProgressBadge extends StatelessWidget {
  final HomeAction action;
  final Color foreground;

  const _ProgressBadge({required this.action, required this.foreground});

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.homeActionCard;
    final current = action.progressCurrent ?? 0;
    final total = action.progressTotal ?? 0;
    final fraction = total == 0 ? 0.0 : (current / total).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$current/$total',
              style: AppFonts.lato
                  .withSize(FontSizes.caption)
                  .withColor(foreground)
                  .medium(),
            ),
            SizedBox(width: metrics.progressLabelSpacing),
            Text(
              '• ${action.levelLabel}',
              style: AppFonts.lato
                  .withSize(FontSizes.caption)
                  .withColor(foreground)
                  .medium(),
            ),
          ],
        ),
        SizedBox(height: metrics.progressBarSpacing),
        ClipRRect(
          borderRadius: BorderRadius.circular(metrics.progressBarRadius),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: metrics.progressBarHeight,
            backgroundColor: AppColors.scaffold,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.greyDarkest),
          ),
        ),
      ],
    );
  }
}
