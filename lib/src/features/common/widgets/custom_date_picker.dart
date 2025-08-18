import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/app/index.dart';
import 'package:tajweed_ai/src/base/extensions/index.dart';
import 'package:tajweed_ai/src/features/common/widgets/index.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final Function(DateTime) onDateSelected;
  final VoidCallback? onCancel;
  final Color? backgroundColor;
  final Widget? headerBuilder;

  const CustomDatePicker({
    super.key,
    this.initialDate,
    this.minDate,
    this.maxDate,
    required this.onDateSelected,
    this.onCancel,
    this.backgroundColor,
    this.headerBuilder,
  });

  static Future<void> show({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
    required Function(DateTime) onDateSelected,
    VoidCallback? onCancel,
    Color? backgroundColor,
    Widget? headerBuilder,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) => CustomDatePicker(
        initialDate: initialDate,
        minDate: minDate,
        maxDate: maxDate,
        onDateSelected: onDateSelected,
        onCancel: onCancel,
        backgroundColor: backgroundColor,
        headerBuilder: headerBuilder,
      ),
    );
  }

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker>
    with TickerProviderStateMixin {
  late DateTime selectedDate;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // Cache the decoration to avoid recreating it on every build
  late final BoxDecoration _containerDecoration;
  late final BorderRadius _borderRadius;

  // Cache static widgets to avoid recreating them
  static const _spacing = SizedBox(width: 16);

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();

    // Validate and adjust initial date if needed
    if (widget.maxDate != null && selectedDate.isAfter(widget.maxDate!)) {
      selectedDate = widget.maxDate!;
    }
    if (widget.minDate != null && selectedDate.isBefore(widget.minDate!)) {
      selectedDate = widget.minDate!;
    }

    // Cache decorations to avoid recreating them
    _borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    );

    _containerDecoration = BoxDecoration(
      color: widget.backgroundColor ?? AppColors.greyBackground,
      borderRadius: _borderRadius,
    );

    // Initialize animations for smooth performance
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDateSelection() {
    _animationController.reverse().then((_) {
      widget.onDateSelected(selectedDate);
      Navigator.pop(context);
    });
  }

  void _handleCancel() {
    _animationController.reverse().then((_) {
      if (widget.onCancel != null) {
        widget.onCancel!();
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 100 * _slideAnimation.value),
          child: Opacity(opacity: _fadeAnimation.value, child: child),
        );
      },
      child: RepaintBoundary(
        child: SafeArea(
          child: Container(
            decoration: _containerDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with RepaintBoundary for isolated painting
                RepaintBoundary(
                  child:
                      widget.headerBuilder ??
                      _DatePickerHeader(onCancel: _handleCancel),
                ),

                // Date Picker with RepaintBoundary for isolated painting
                RepaintBoundary(
                  child: _DatePickerContent(
                    selectedDate: selectedDate,
                    minDate: widget.minDate,
                    maxDate: widget.maxDate,
                    onDateChanged: (DateTime newDate) {
                      if (newDate != selectedDate) {
                        setState(() {
                          selectedDate = newDate;
                        });
                      }
                    },
                  ),
                ),

                // Action Buttons with RepaintBoundary for isolated painting
                RepaintBoundary(
                  child: _DatePickerActions(
                    onCancel: _handleCancel,
                    onSelect: _handleDateSelection,
                    spacing: _spacing,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DatePickerHeader extends StatelessWidget {
  final VoidCallback? onCancel;

  const _DatePickerHeader({super.key, this.onCancel});

  @override
  Widget build(BuildContext context) =>
      Row(
        children: [
          Text(
            'Select Date',
            style: AppStyles.headline3.bold().white(),
          ).expanded(),

          IconButton(
            onPressed: onCancel,
            icon: const Icon(Icons.close, color: Colors.white, size: 24),
          ),
        ],
      ).decorate(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      );
}

class _DatePickerContent extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final Function(DateTime) onDateChanged;

  const _DatePickerContent({
    super.key,
    required this.selectedDate,
    this.minDate,
    this.maxDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 200,
    child: CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      initialDateTime: selectedDate,
      minimumDate: minDate,
      maximumDate: maxDate,
      onDateTimeChanged: onDateChanged,
      // Optimize the picker performance
      itemExtent: 32.0,
      use24hFormat: false,
      minuteInterval: 1,
    ),
  );
}

class _DatePickerActions extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onSelect;
  final Widget spacing;

  const _DatePickerActions({
    super.key,
    this.onCancel,
    this.onSelect,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      OutlinedLoadingButton(
        title: 'Cancel',
        onTap: onCancel ?? () {},
        titleFontSize: FontSizes.title,
        height: AppMetrics.buttons.elevated.height,
      ).expanded(),

      spacing,

      LoadingButton(
        title: 'Select',
        onTap: onSelect ?? () {},
        titleFontSize: FontSizes.title,
        height: AppMetrics.buttons.elevated.height,
        useGradient: true,
      ).expanded(),
    ],
  ).overallPadding(AppMetrics.scaffold.bottomBodyPadding);
}
