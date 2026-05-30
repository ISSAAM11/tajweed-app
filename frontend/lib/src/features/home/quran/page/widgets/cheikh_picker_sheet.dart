import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/binding/app_bindings.dart' show di, get;
import 'package:tajweed_ai/src/app/design/colors/app_colors.dart';
import 'package:tajweed_ai/src/app/design/styles/app_fonts.dart';
import 'package:tajweed_ai/src/app/design/styles/app_styles.dart';
import 'package:tajweed_ai/src/app/design/styles/font_sizes.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/cheikh_reciter.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/audio_player_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/cheikh_cubit.dart';

class CheikhPickerSheet extends StatelessWidget {
  const CheikhPickerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cubit = context.read<CheikhCubit>();
    final selected = context.watch<CheikhCubit>().state;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                l10n.cheikhPickerTitle,
                style: AppFonts.lato
                    .withSize(FontSizes.subtitle)
                    .withColor(
                      isDark ? AppColors.darkTextPrimary : AppColors.greyDarkest,
                    )
                    .semiBold(),
              ),
            ),
            const Divider(),
            ...cubit.availableCheikhs.map(
              (cheikh) => _CheikhTile(
                cheikh: cheikh,
                isSelected: cheikh == selected,
                isDark: isDark,
                onTap: () {
                  if (di.isRegistered<AudioPlayerBloc>()) {
                    get<AudioPlayerBloc>().add(const StopAudio());
                  }
                  cubit.select(cheikh);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheikhTile extends StatelessWidget {
  final CheikhReciter cheikh;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _CheikhTile({
    required this.cheikh,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark ? AppColors.darkPrimary : AppColors.primary;
    return ListTile(
      title: Text(
        cheikh.nameArabic,
        style: AppFonts.lato
            .withSize(FontSizes.subtitle)
            .withColor(isDark ? AppColors.darkTextPrimary : AppColors.greyDarkest)
            .semiBold(),
      ),
      subtitle: Text(
        cheikh.name,
        style: AppFonts.lato
            .withSize(FontSizes.indication)
            .withColor(isDark ? AppColors.darkTextSecondary : AppColors.greyDark),
      ),
      trailing: isSelected
          ? Icon(Icons.check_rounded, color: primaryColor)
          : null,
      onTap: onTap,
    );
  }
}
