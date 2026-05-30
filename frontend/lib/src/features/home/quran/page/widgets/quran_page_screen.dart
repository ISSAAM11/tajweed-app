import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/audio_player_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/binding/quran_page_deps.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_state.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/audio_player_bar.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/download_confirm_dialog.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/quran_page_body.dart';

String _displaySurahName(BuildContext context, QuranPageState state) {
  final isArabic = Localizations.localeOf(context).languageCode == 'ar';
  if (isArabic) return state.surahName;
  return state.surahNameSimple.isNotEmpty
      ? state.surahNameSimple
      : state.surahName;
}

final class QuranPageScreen extends Feature<QuranPageBloc, QuranPageState> {
  final QuranPageArgs args;
  QuranPageScreen({super.key, required this.args})
    : super(
        dependencies: QuranPageDependencies().inject,
        onInit: (context, bloc) {
          bloc.initToVerse(args.verseKey);
        },
        onUpdate: (context, state) => switch (state) {
          _ => null,
        },
      );

  @override
  Widget build(BuildContext context, QuranPageState state) {
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
                action: SnackBarAction(
                  label: l10n.snackbarOk,
                  onPressed: () {},
                ),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: ClipRRect(
              borderRadius: BorderRadius.only(),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: AppBar(
                  title: BlocBuilder<QuranPageBloc, QuranPageState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Text(
                            _displaySurahName(context, state),
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Stack(
            children: [
              Positioned.fill(
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: QuranPageBody(state),
                ),
              ),
              const Positioned.fill(child: AudioPageOverlay()),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AudioPlayerBar(),
              ),
            ],
          ),
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
