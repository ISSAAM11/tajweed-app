import '../../../base/screens/exports.dart';

class AppLogo extends StatelessWidget {
  final double? iconSize;
  final double? width;
  final double? height;
  final double? radius;
  const AppLogo({
    super.key,
    this.iconSize,
    this.width,
    this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Icon(
        Icons.mosque,
        size: iconSize ?? AppMetrics.inputs.height,
        color: Colors.white,
      ).decorate(
        width: width ?? AppMetrics.inputs.height * 2,
        height: height ?? AppMetrics.inputs.height * 2,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(
            radius ?? AppMetrics.defaultRadius,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: radius ?? AppMetrics.defaultRadius,
              offset: const Offset(0, 6),
            ),
          ],
        ),
      ),
    ],
  );
}
