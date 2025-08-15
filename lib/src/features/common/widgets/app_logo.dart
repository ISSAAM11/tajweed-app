import '../../../base/screens/exports.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) => Column(
      children: [
        const Icon(
            Icons.mosque,
            size: 50,
            color: Colors.white,
          ).decorate(
             width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
            ],
          ),
          ),
      ],
    );
}