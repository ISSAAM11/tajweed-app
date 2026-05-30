import 'package:flutter/material.dart';
import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/design/colors/app_colors.dart';
import 'package:tajweed_ai/src/app/design/styles/app_fonts.dart';
import 'package:tajweed_ai/src/app/design/styles/app_styles.dart';
import 'package:tajweed_ai/src/app/design/styles/font_sizes.dart';

class PlayOptionsSheet extends StatelessWidget {
  final VoidCallback onPlayAyah;
  final VoidCallback onPlayPage;
  final VoidCallback onPlaySurah;
  final int ayahNumber;
  final int pageNo;
  final String surahName;

  const PlayOptionsSheet({
    super.key,
    required this.onPlayAyah,
    required this.onPlayPage,
    required this.onPlaySurah,
    required this.ayahNumber,
    required this.pageNo,
    required this.surahName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? AppColors.darkPrimary : AppColors.primary;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Option(
              icon: Icons.music_note_rounded,
              label: l10n.audioPlayAyah,
              subtitle: '${l10n.verseNumberLabel} $ayahNumber',
              iconColor: iconColor,
              onTap: () {
                Navigator.pop(context);
                onPlayAyah();
              },
            ),
            _Option(
              icon: Icons.menu_book_rounded,
              label: l10n.audioPlayPage,
              subtitle: '${l10n.partitionPage} $pageNo',
              iconColor: iconColor,
              onTap: () {
                Navigator.pop(context);
                onPlayPage();
              },
            ),
            _Option(
              icon: Icons.queue_music_rounded,
              label: l10n.audioPlaySurah,
              subtitle: surahName,
              iconColor: iconColor,
              onTap: () {
                Navigator.pop(context);
                onPlaySurah();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  const _Option({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        label,
        style: AppFonts.lato
            .withSize(FontSizes.subtitle)
            .withColor(isDark ? AppColors.darkTextPrimary : AppColors.greyDarkest)
            .semiBold(),
      ),
      subtitle: Text(
        subtitle,
        style: AppFonts.lato
            .withSize(FontSizes.indication)
            .withColor(isDark ? AppColors.darkTextSecondary : AppColors.greyDark),
      ),
      onTap: onTap,
    );
  }
}
