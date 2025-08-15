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
  final LinearGradient? gradient;
  final bool useGradient;
  final Color? successColor;

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
    this.prefixIconColor = Colors.white,
    this.gradient,
    this.useGradient = true,
    this.successColor,
  });

  @override
  Widget build(BuildContext context) =>
     Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null)
          Icon(
            prefixIcon,
            color: prefixIconColor,
            size: prefixIconSize,
          ).customPadding(right: 8, top: 1),
        // in Flutter 3.? we can use ?x instead of if(x!=null) x;
        ? prefixWidget,
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
                    : [
                        const BoxShadow(
                          blurRadius: 2,
                          offset: Offset(0, 1),
                          color: Color(0x40000000),
                        ),
                      ],
              ),
              textAlign: TextAlign.center,
            ),
            CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
              ).resize(height: 18,width: 18)
            .visibleWhen(isLoading),
          ],
        ),
      ],
    )
    .symmetricPadding(horizontal: 24)
    .onTap(onTap)
    .absorbWhen(isLoading)
    .decorate(      width: width,
      height: height ?? AppMetrics.buttons.elevated.height,
      decoration: BoxDecoration(
        gradient: useGradient 
            ? (gradient ?? AppColors.primaryGradient)
            : null,
        color: useGradient ? null : (backgroundColor ?? AppColors.primary),
        borderRadius: BorderRadius.circular(AppMetrics.buttons.radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );

  
}

class OutlinedLoadingButton extends StatelessWidget {
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
  final LinearGradient? borderGradient;

  const OutlinedLoadingButton({
    super.key,
    this.width,
    this.isTransparent = false,
    this.isLoading = false,
    required this.onTap,
    required this.title,
    required this.titleFontSize,
    this.backgroundColor,
    this.textColor = AppColors.primary,
    this.borderWidth = 2,
    this.height,
    this.prefixIcon,
    this.prefixWidget,
    this.prefixIconSize = 20,
    this.prefixIconColor,
    this.borderGradient,
  });

  @override
  Widget build(BuildContext context) =>  
        Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null)
                    Icon(
                      prefixIcon,
                      color: prefixIconColor ?? textColor,
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
                        ),
                        textAlign: TextAlign.center,
                      ),
                    CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
                        ).resize(height: 18,width: 18)
                      .visibleWhen(isLoading),
                    ],
                  ),
                ],
              ).symmetricPadding(horizontal: 24)
              .onTap(onTap)
              .absorbWhen(isLoading)
              .decorate( margin: EdgeInsets.all(borderWidth),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(AppMetrics.buttons.radius - borderWidth),
        ),
        ).decorate(width: width,
      height: height ?? AppMetrics.buttons.elevated.height,
      decoration: BoxDecoration(
        gradient: borderGradient ?? AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppMetrics.buttons.radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ));   
        
      
    
  
}
