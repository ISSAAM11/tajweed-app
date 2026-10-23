import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/design/colors/app_colors.dart';
import 'package:tajweed_ai/src/app/design/styles/app_fonts.dart';
import 'package:tajweed_ai/src/app/design/styles/app_styles.dart';
import 'package:tajweed_ai/src/app/design/styles/font_sizes.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/audio_player_bloc.dart';

Future<void> showDownloadConfirmDialog(BuildContext context) {
  final bloc = context.read<AudioPlayerBloc>();
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      final isDark =
          Theme.of(dialogContext).brightness == Brightness.dark;
      final l10n = AppLocalizations.of(context)!;
      final titleColor =
          isDark ? AppColors.darkTextPrimary : AppColors.greyDarkest;
      final bodyColor =
          isDark ? AppColors.darkTextSecondary : AppColors.greyDark;
      final actionColor =
          isDark ? AppColors.darkPrimary : AppColors.primary;

      return AlertDialog(
        backgroundColor:
            isDark ? AppColors.darkSurface : Colors.white,
        title: Text(
          l10n.audioDownloadTitle,
          style: AppFonts.lato
              .withSize(FontSizes.headline3)
              .withColor(titleColor)
              .semiBold(),
        ),
        content: Text(
          l10n.audioDownloadMessage,
          style: AppFonts.lato
              .withSize(FontSizes.subtitle)
              .withColor(bodyColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              bloc.add(const CancelDownload());
            },
            child: Text(
              l10n.audioDownloadCancel,
              style: AppFonts.lato
                  .withSize(FontSizes.subtitle)
                  .withColor(bodyColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              bloc.add(const ConfirmDownload());
            },
            child: Text(
              l10n.audioDownloadConfirm,
              style: AppFonts.lato
                  .withSize(FontSizes.subtitle)
                  .withColor(actionColor)
                  .semiBold(),
            ),
          ),
        ],
      );
    },
  );
}
