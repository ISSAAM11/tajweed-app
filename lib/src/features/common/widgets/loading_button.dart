import '../../../base/screens/exports.dart';

class LoadingButton extends StatelessWidget {
  final double? width;
  final bool isTransparent;
  final bool isLoading;
  final VoidCallback onTap;
  final String title;
  final double? titleFontSize;
  final Color? backgroundColor;
  final Color textColor;
  final double borderWidth;
  final double? height;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final double? prefixIconSize;
  final Color? prefixIconColor;

  const LoadingButton({
    super.key,
    this.width,
    this.isTransparent = false,
    this.isLoading = false,
    required this.onTap,
    required this.title,
    required this.titleFontSize,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.borderWidth = 0,
    this.height,
    this.prefixIcon,
    this.prefixWidget,
    this.prefixIconSize = 20,
    this.prefixIconColor = AppColors.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: AppMetrics.buttons.elevated.elevation,
        iconColor: backgroundColor ?? AppColors.scaffold,
        backgroundColor: isTransparent
            ? Colors.transparent
            : (backgroundColor ?? AppColors.primary),
        fixedSize: Size.fromHeight(height ?? AppMetrics.buttons.elevated.height),
        side: borderWidth == 0 ? BorderSide.none : BorderSide(width: borderWidth, color: textColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null)
            Icon(
              prefixIcon,
              color: prefixIconColor,
              size: prefixIconSize,
            ).customPadding(right: 8, top: 1),
          if (prefixWidget != null) prefixWidget!,
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                title,
                style: AppStyles.title.copyWith(
                  color: isLoading ? Colors.transparent : textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: titleFontSize ?? AppStyles.title.fontSize,
                  shadows: isLoading
                      ? null
                      : [const BoxShadow(blurRadius: 5, offset: Offset(-1, 1.3))],
                ),
                textAlign: TextAlign.center,
              ),
              const CircularProgressIndicator()
                  .resize(height: 18, width: 18)
                  .center()
                  .visibleWhen(isLoading),
            ],
          ),
        ],
      ).resize(width: width),
    );
  }
}
