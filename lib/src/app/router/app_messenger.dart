import '../../base/screens/exports.dart';

final ScaffoldMessengerState appMessenger = ScaffoldMessenger.of(globalContext);

class CommonSnackbar extends SnackBar {
  final BuildContext context;
  final String message;
  final SnackbarType type;
  final String? actionTitle;
  final VoidCallback? onActionPressed;
  final bool defaultCloseButton;

  CommonSnackbar({
    super.key,
    required this.context,
    required this.message,
    required this.type,
    this.actionTitle,
    this.onActionPressed,
    this.defaultCloseButton = true,
  }) : super(
         content: Text(message),
         backgroundColor: switch (type) {
           SnackbarType.success => Theme.of(globalContext).colorScheme.primary,
           SnackbarType.error => Theme.of(globalContext).colorScheme.error,
           SnackbarType.warning => Theme.of(globalContext).colorScheme.tertiary,
           SnackbarType.info => Theme.of(globalContext).colorScheme.secondary,
         },
         duration: const Duration(seconds: 5),
         action: SnackBarAction(
           label: actionTitle ?? 'Close',
           onPressed: onActionPressed != null
               ? () => onActionPressed.call()
               : appMessenger.clearSnackBars,
         ),
         behavior: SnackBarBehavior.floating,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
         margin: const EdgeInsets.all(10),
         padding: const EdgeInsets.all(10),
         hitTestBehavior: HitTestBehavior.opaque,
         dismissDirection: DismissDirection.horizontal,
         clipBehavior: Clip.hardEdge,
         closeIconColor: Colors.white,
         showCloseIcon: defaultCloseButton,
         elevation: 10,
       );
}

enum SnackbarType { success, error, warning, info }
