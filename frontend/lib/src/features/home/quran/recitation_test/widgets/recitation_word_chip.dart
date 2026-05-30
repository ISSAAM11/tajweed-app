import 'package:tajweed_ai/src/base/screens/exports.dart';

import '../data/models/word_verdict_model.dart';

/// A single surah word, shown as a QPC V2 glyph, whose *background* reflects
/// its verdict: transparent (no verdict) · light tint (interim) · green
/// (correct) · red (wrong).
class RecitationWordChip extends StatelessWidget {
  /// QPC V2 glyph code, rendered with the page-1 font (Al-Fatiha is page 1).
  final String glyph;
  final WordVerdictModel? verdict;

  /// QPC fonts are per-page; v1 recites Al-Fatiha, which lives on page 1.
  static const _fontFamily = 'QPC-V2-Font-p1';

  const RecitationWordChip({required this.glyph, this.verdict, super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final locked = verdict?.isFinal ?? false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _background(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        glyph,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: _fontFamily,
          fontSize: FontSizes.headline2,
          // White reads on a solid (locked) verdict colour; otherwise the
          // normal text colour over a transparent / lightly-tinted background.
          color: locked ? AppColors.scaffold : scheme.onSurface,
        ),
      ),
    );
  }

  Color _background() {
    final current = verdict;
    if (current == null) return Colors.transparent; // neutral
    final base = current.isCorrect ? AppColors.success : AppColors.error;
    return current.isFinal ? base : base.withAlpha(70); // tentative tint
  }
}
