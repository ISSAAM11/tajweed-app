import 'package:package_info_plus/package_info_plus.dart';
import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/theme/app_theme_mode.dart';
import 'package:tajweed_ai/src/app/theme/theme_bloc.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/settings/binding/settings_deps.dart';
import 'package:tajweed_ai/src/features/settings/vm/app_language.dart';
import 'package:tajweed_ai/src/features/settings/vm/settings_bloc.dart';
import 'package:tajweed_ai/src/features/settings/vm/settings_state.dart';

final class SettingsScreen extends Feature<SettingsBloc, SettingsState> {
  SettingsScreen({super.key})
    : super(dependencies: SettingsDependencies().inject);

  @override
  Widget build(BuildContext context, SettingsState state) {
    final selected = state is SettingsReady
        ? state.language
        : AppLanguage.english;
    final metrics = AppMetrics.settingsScreen;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: AppBar(
            backgroundColor: AppColors.greyDarkest,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back, color: AppColors.scaffold),
            ),
            title: Text(
              l10n.settingsTitle,
              style: AppFonts.nunito
                  .withSize(FontSizes.headline3)
                  .withColor(AppColors.scaffold)
                  .semiBold(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: metrics.bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _AccountCardSection(),
            SizedBox(height: AppMetrics.spacing.md),
            _SectionTitle(label: l10n.settingsLanguage),
            _LanguageOption(
              language: AppLanguage.english,
              selected: selected == AppLanguage.english,
              onTap: () => bloc.changeLanguage(AppLanguage.english),
            ),
            SizedBox(height: metrics.optionGap),
            _LanguageOption(
              language: AppLanguage.arabic,
              selected: selected == AppLanguage.arabic,
              onTap: () => bloc.changeLanguage(AppLanguage.arabic),
            ),
            SizedBox(height: AppMetrics.spacing.md),
            const SettingsAppearanceSection(),
            SizedBox(height: AppMetrics.spacing.md),
            const _ComingSoonSection(),
            SizedBox(height: AppMetrics.spacing.md),
            const _AboutSection(),
          ],
        ),
      ),
    );
  }
}

/// Theme picker section of the settings screen. Public so it can be
/// rendered and tested in isolation. Reads / writes directly from the
/// global ThemeBloc — no parent state required.
class SettingsAppearanceSection extends StatelessWidget {
  const SettingsAppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final metrics = AppMetrics.settingsScreen;
    final themeBloc = get<ThemeBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(label: l10n.settingsAppearance),
        BlocBuilder<ThemeBloc, AppThemeMode>(
          bloc: themeBloc,
          builder: (context, mode) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ThemeOption(
                label: l10n.settingsThemeLight,
                selected: mode == AppThemeMode.light,
                onTap: () => themeBloc.change(AppThemeMode.light),
              ),
              SizedBox(height: metrics.optionGap),
              _ThemeOption(
                label: l10n.settingsThemeDark,
                selected: mode == AppThemeMode.dark,
                onTap: () => themeBloc.change(AppThemeMode.dark),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AccountCardSection extends StatelessWidget {
  const _AccountCardSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final metrics = AppMetrics.settingsScreen;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(label: l10n.settingsAccountSection),
        InkWell(
          borderRadius: BorderRadius.circular(metrics.optionRowRadius),
          onTap: () => context.push('/my-account'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(metrics.optionRowRadius),
              border: Border.all(
                color: scheme.outlineVariant,
                width: metrics.optionRowBorderWidth,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: scheme.surfaceContainerHigh,
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: scheme.onSurfaceVariant,
                    size: 28,
                  ),
                ),
                SizedBox(width: AppMetrics.spacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.settingsGuestLabel,
                        style: AppFonts.lato
                            .withSize(FontSizes.title)
                            .withColor(scheme.onSurface)
                            .semiBold(),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.settingsGuestSubtitle,
                        style: AppFonts.lato
                            .withSize(FontSizes.indication)
                            .withColor(scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: scheme.onSurfaceVariant,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ComingSoonSection extends StatelessWidget {
  const _ComingSoonSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final metrics = AppMetrics.settingsScreen;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(label: l10n.settingsComingSoonSection),
        ComingSoonTile(
          icon: Icons.notifications_none_rounded,
          title: l10n.settingsNotifications,
        ),
        SizedBox(height: metrics.optionGap),
        ComingSoonTile(
          icon: Icons.access_time_rounded,
          title: l10n.settingsDailyReminders,
        ),
      ],
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final metrics = AppMetrics.settingsScreen;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(label: l10n.settingsAboutSection),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            final versionText = snapshot.hasData
                ? '${snapshot.data!.version} (${snapshot.data!.buildNumber})'
                : '—';
            return Container(
              height: metrics.optionRowHeight,
              padding: metrics.optionRowPadding,
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(metrics.optionRowRadius),
                border: Border.all(
                  color: scheme.outlineVariant,
                  width: metrics.optionRowBorderWidth,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: scheme.onSurfaceVariant,
                    size: metrics.selectionIconSize,
                  ),
                  SizedBox(width: AppMetrics.spacing.xs),
                  Expanded(
                    child: Text(
                      l10n.settingsVersion,
                      style: AppFonts.lato
                          .withSize(FontSizes.title)
                          .withColor(scheme.onSurface)
                          .medium(),
                    ),
                  ),
                  Text(
                    versionText,
                    style: AppFonts.lato
                        .withSize(FontSizes.subtitle)
                        .withColor(scheme.onSurfaceVariant),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: metrics.optionGap),
        _NavTile(
          icon: Icons.description_outlined,
          label: l10n.settingsTermsOfUse,
          onTap: () => context.push('/terms-of-use'),
        ),
      ],
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.settingsScreen;
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(metrics.optionRowRadius),
      onTap: onTap,
      child: Container(
        height: metrics.optionRowHeight,
        padding: metrics.optionRowPadding,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(metrics.optionRowRadius),
          border: Border.all(
            color: scheme.outlineVariant,
            width: metrics.optionRowBorderWidth,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: scheme.onSurfaceVariant,
              size: metrics.selectionIconSize,
            ),
            SizedBox(width: AppMetrics.spacing.xs),
            Expanded(
              child: Text(
                label,
                style: AppFonts.lato
                    .withSize(FontSizes.title)
                    .withColor(scheme.onSurface)
                    .medium(),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: scheme.onSurfaceVariant,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String label;

  const _SectionTitle({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppMetrics.settingsScreen.sectionTitlePadding,
      child: Text(
        label,
        style: AppFonts.lato
            .withSize(FontSizes.subtitle)
            .withColor(Theme.of(context).colorScheme.onSurfaceVariant)
            .semiBold(),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final AppLanguage language;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.language,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.settingsScreen;
    final scheme = Theme.of(context).colorScheme;
    final borderColor = selected ? AppColors.primary : scheme.outlineVariant;
    final labelColor = selected ? scheme.primary : scheme.onSurface;

    return InkWell(
      borderRadius: BorderRadius.circular(metrics.optionRowRadius),
      onTap: onTap,
      child: Container(
        height: metrics.optionRowHeight,
        padding: metrics.optionRowPadding,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(metrics.optionRowRadius),
          border: Border.all(
            color: borderColor,
            width: metrics.optionRowBorderWidth,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                language.nativeLabel,
                style: AppFonts.lato
                    .withSize(FontSizes.title)
                    .withColor(labelColor)
                    .medium(),
              ),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: selected ? scheme.primary : scheme.onSurfaceVariant,
              size: metrics.selectionIconSize,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.settingsScreen;
    final scheme = Theme.of(context).colorScheme;
    final borderColor = selected ? AppColors.primary : scheme.outlineVariant;
    final labelColor = selected ? scheme.primary : scheme.onSurface;

    return InkWell(
      borderRadius: BorderRadius.circular(metrics.optionRowRadius),
      onTap: onTap,
      child: Container(
        height: metrics.optionRowHeight,
        padding: metrics.optionRowPadding,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(metrics.optionRowRadius),
          border: Border.all(
            color: borderColor,
            width: metrics.optionRowBorderWidth,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppFonts.lato
                    .withSize(FontSizes.title)
                    .withColor(labelColor)
                    .medium(),
              ),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: selected ? scheme.primary : scheme.onSurfaceVariant,
              size: metrics.selectionIconSize,
            ),
          ],
        ),
      ),
    );
  }
}
