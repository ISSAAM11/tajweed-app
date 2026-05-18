part of '../app_metrics.dart';

class _Inputs {
  const _Inputs._();

  final AutovalidateMode inputsAutovalidationMode = AutovalidateMode.disabled;
  static const _applyElevation = false;
  final double elevation = _applyElevation ? AppMetrics.defaultElevation : 0;
  final double radius = 12;
  final double height = 40;
  final double horizontalContentPadding = 20;
  final double verticalContentPadding = 13;
  final double borderWidth = 1.5;
  final int passwordInputMaxLength = 12;
  final int maxLength = 50;
  final prefixIconConstraints = const BoxConstraints(
    minWidth: 40,
    maxWidth: 40,
    minHeight: 40,
    maxHeight: 40,
  );
  final suffixIconConstraints = const BoxConstraints(
    minWidth: 40,
    maxWidth: 40,
    minHeight: 40,
    maxHeight: 40,
  );
}
