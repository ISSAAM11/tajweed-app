import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/audio_player_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/binding/hifth_deps.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/router/hifth_route.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/vm/hifth_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/widgets/hifth_ayah_tile.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/widgets/hifth_bottom_bar.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/widgets/hifth_surah_header.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/cache/marked_ayah_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/download_confirm_dialog.dart';

/// Memorization screen: the surah ayah-by-ayah, each with its own play and
/// repeat (infinite loop) controls.
final class HifthScreen extends Feature<HifthBloc, HifthState> {
  final HifthArgs args;

  HifthScreen({super.key, required this.args})
    : super(
        dependencies: HifthDependencies().inject,
        onInit: (context, bloc) {
          // Marks are read from storage on first touch. Do it before the first
          // paint, otherwise every tile renders unmarked and then flips.
          get<MarkedAyahService>().current;
          bloc.add(LoadSurah(args.surah));
        },
      );

  @override
  Widget build(BuildContext context, HifthState state) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider<AudioPlayerBloc>(
      create: (_) => get<AudioPlayerBloc>(),
      child: BlocListener<AudioPlayerBloc, AudioPlayerState>(
        listener: (context, audioState) {
          if (audioState is AudioAwaitingDownload) {
            showDownloadConfirmDialog(context);
          } else if (audioState is AudioError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_resolveAudioError(l10n, audioState.messageKey)),
                action: SnackBarAction(label: l10n.snackbarOk, onPressed: () {}),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.scaffold,
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
                  l10n.hifthTitle,
                  style: AppFonts.nunito
                      .withSize(FontSizes.headline3)
                      .withColor(AppColors.scaffold)
                      .semiBold(),
                ),
                actions: [
                  IconButton(
                    onPressed: () => context.push('/settings'),
                    icon: const Icon(Icons.settings, color: AppColors.scaffold),
                  ),
                ],
              ),
            ),
          ),
          body: switch (state) {
            HifthLoaded(:final header, :final ayahs) => ListView.builder(
              padding: AppMetrics.hifthScreen.listPadding,
              itemCount: ayahs.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) return HifthSurahHeader(header: header);
                return HifthAyahTile(
                  surah: header.id,
                  ayah: ayahs[index - 1],
                );
              },
            ).safeArea(),
            HifthError(:final messageKey) => Center(
              child: Text(
                '${l10n.errorPrefix}: ${_resolveLoadError(l10n, messageKey)}',
              ),
            ),
            _ => CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
            ).resize(height: 20, width: 20).center(),
          },
          bottomNavigationBar: const HifthBottomBar(),
        ),
      ),
    );
  }
}

String _resolveAudioError(AppLocalizations l10n, String key) {
  return switch (key) {
    'audioNoInternet' => l10n.audioNoInternet,
    _ => '${l10n.errorPrefix}: $key',
  };
}

String _resolveLoadError(AppLocalizations l10n, String key) {
  return switch (key) {
    'hifthLoadError' => l10n.hifthLoadError,
    _ => key,
  };
}
