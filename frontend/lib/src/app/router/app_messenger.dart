import '../../base/screens/exports.dart';

final ScaffoldMessengerState appMessenger = ScaffoldMessenger.of(globalContext);

class CommonSnackbar extends SnackBar {
  final String message;
  final SnackbarType type;
  final String? actionTitle;
  final VoidCallback? onActionPressed;
  final bool defaultCloseButton;

  CommonSnackbar({
    super.key,
    required this.message,
    required this.type,
    this.actionTitle,
    this.onActionPressed,
    this.defaultCloseButton = true,
  }) : super(
         content: Text(message),
         backgroundColor: switch (type) {
           SnackbarType.success => AppColors.success,
           SnackbarType.error => AppColors.error,
           SnackbarType.warning => AppColors.warning,
           SnackbarType.info => AppColors.info,
         },
         duration: const Duration(seconds: 5),
         action: SnackBarAction(
           label: actionTitle ?? 'Close',
           onPressed: onActionPressed != null
               ? () => onActionPressed.call()
               : appMessenger.clearSnackBars,
         ),
         behavior: SnackBarBehavior.floating,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(
             AppMetrics.snackBars.defaultRadius,
           ),
         ),
         margin: AppMetrics.snackBars.defaultMargin,
         padding: AppMetrics.snackBars.defaultPadding,
         hitTestBehavior: HitTestBehavior.opaque,
         dismissDirection: DismissDirection.horizontal,
         clipBehavior: Clip.hardEdge,
         closeIconColor: Colors.white,
         showCloseIcon: defaultCloseButton,
         elevation: AppMetrics.snackBars.defaultElevation,
       );
}

enum SnackbarType { success, error, warning, info }
