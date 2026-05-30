import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/design/colors/app_colors.dart';
import 'package:tajweed_ai/src/app/design/metrics/app_metrics.dart';
import 'package:tajweed_ai/src/app/design/styles/app_fonts.dart';
import 'package:tajweed_ai/src/app/design/styles/app_styles.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/cheikh_reciter.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/audio_player_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/cheikh_cubit.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/cheikh_picker_sheet.dart';

/// Transparent overlay that dims the page behind the floating player.
class AudioPageOverlay extends StatelessWidget {
  const AudioPageOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        final active =
            state is AudioPlaying ||
            state is AudioPaused ||
            state is AudioDownloading;
        return AnimatedOpacity(
          opacity: active ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 280),
          child: IgnorePointer(
            child: Container(
              color: Colors.black.withValues(
                alpha: AppMetrics.audioBar.overlayOpacity,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Floating frosted-glass player card, pinned to the bottom of the screen.
class AudioPlayerBar extends StatelessWidget {
  const AudioPlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        final visible =
            state is AudioPlaying ||
            state is AudioPaused ||
            state is AudioDownloading;

        return AnimatedSlide(
          offset: visible ? Offset.zero : const Offset(0, 1.5),
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
          child: AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 280),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  AppMetrics.audioBar.horizontalMargin,
                  0,
                  AppMetrics.audioBar.horizontalMargin,
                  AppMetrics.audioBar.bottomMargin,
                ),
                child: _FloatingCard(state: state),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FloatingCard extends StatelessWidget {
  final AudioPlayerState state;
  const _FloatingCard({required this.state});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = AppMetrics.audioBar.borderRadius;
    final cardColor = (isDark ? AppColors.darkSurface : Colors.white)
        .withValues(alpha: AppMetrics.audioBar.backgroundOpacity);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppMetrics.audioBar.blurSigma,
          sigmaY: AppMetrics.audioBar.blurSigma,
        ),
        child: Container(
          height: AppMetrics.audioBar.height,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: AppMetrics.audioBar.elevation,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: AppMetrics.audioBar.padding,
          child: switch (state) {
            AudioPlaying() || AudioPaused() => _PlayerControls(state: state),
            AudioDownloading(:final progress) => _DownloadProgress(
              progress: progress,
            ),
            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}

class _PlayerControls extends StatelessWidget {
  final AudioPlayerState state;
  const _PlayerControls({required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AudioPlayerBloc>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPlaying = state is AudioPlaying;

    final (surah, ayah, currentIndex, total) = switch (state) {
      AudioPlaying(
        :final surah,
        :final currentAyah,
        :final currentIndex,
        :final totalInQueue,
      ) =>
        (surah, currentAyah, currentIndex, totalInQueue),
      AudioPaused(
        :final surah,
        :final currentAyah,
        :final currentIndex,
        :final totalInQueue,
      ) =>
        (surah, currentAyah, currentIndex, totalInQueue),
      _ => (0, 0, 0, 0),
    };

    final iconColor = isDark ? AppColors.darkPrimary : AppColors.primary;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.greyDarkest;
    final subColor = isDark ? AppColors.darkTextSecondary : AppColors.greyDark;

    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<CheikhCubit, CheikhReciter>(
                builder: (context, cheikh) => GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (_) => BlocProvider.value(
                      value: context.read<CheikhCubit>(),
                      child: const CheikhPickerSheet(),
                    ),
                  ),
                  child: Text(
                    cheikh.nameArabic,
                    style: AppFonts.lato
                        .withSize(AppMetrics.audioBar.infoFontSize)
                        .withColor(iconColor)
                        .semiBold(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                'Surah $surah · ${AppLocalizations.of(context)!.verseNumberLabel} $ayah'
                ' · ${currentIndex + 1}/$total',
                style: AppFonts.lato
                    .withSize(AppMetrics.audioBar.infoFontSize)
                    .withColor(subColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.skip_previous_rounded, color: textColor),
          iconSize: AppMetrics.audioBar.iconSize,
          onPressed: () => bloc.add(const SkipPrevious()),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 4),
        IconButton(
          icon: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            color: iconColor,
          ),
          iconSize: AppMetrics.audioBar.iconSize,
          onPressed: () =>
              bloc.add(isPlaying ? const PauseAudio() : const ResumeAudio()),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.skip_next_rounded, color: textColor),
          iconSize: AppMetrics.audioBar.iconSize,
          onPressed: () => bloc.add(const SkipNext()),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.stop_rounded, color: AppColors.error),
          iconSize: AppMetrics.audioBar.stopIconSize,
          onPressed: () => bloc.add(const StopAudio()),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}

class _DownloadProgress extends StatelessWidget {
  final double progress;
  const _DownloadProgress({required this.progress});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.audioDownloading,
          style: AppFonts.lato
              .withSize(AppMetrics.audioBar.infoFontSize)
              .withColor(
                isDark ? AppColors.darkTextPrimary : AppColors.greyDarkest,
              ),
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.greyLight,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: AppMetrics.audioBar.progressBarHeight,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
