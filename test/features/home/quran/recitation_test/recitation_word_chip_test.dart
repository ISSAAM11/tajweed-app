import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tajweed_ai/src/app/design/colors/app_colors.dart';
import 'package:tajweed_ai/src/features/home/quran/recitation_test/data/models/word_verdict_model.dart';
import 'package:tajweed_ai/src/features/home/quran/recitation_test/widgets/recitation_word_chip.dart';

/// Background colour of the chip wrapping [word].
Color? _bgOf(WidgetTester tester, String word) {
  final container = tester.widget<Container>(
    find.ancestor(of: find.text(word), matching: find.byType(Container)).first,
  );
  return (container.decoration as BoxDecoration).color;
}

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  group('RecitationWordChip background', () {
    testWidgets('is transparent when there is no verdict', (tester) async {
      await tester.pumpWidget(_wrap(const RecitationWordChip(glyph: 'بسم')));
      expect(_bgOf(tester, 'بسم'), Colors.transparent);
    });

    testWidgets('is green when correct and final', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const RecitationWordChip(
            glyph: 'الله',
            verdict: WordVerdictModel(
              wordIndex: 1,
              isCorrect: true,
              isFinal: true,
            ),
          ),
        ),
      );
      expect(_bgOf(tester, 'الله'), AppColors.success);
    });

    testWidgets('is red when incorrect and final', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const RecitationWordChip(
            glyph: 'الرحمن',
            verdict: WordVerdictModel(
              wordIndex: 2,
              isCorrect: false,
              isFinal: true,
            ),
          ),
        ),
      );
      expect(_bgOf(tester, 'الرحمن'), AppColors.error);
    });

    testWidgets('is a light tint while tentative (interim)', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const RecitationWordChip(
            glyph: 'الرحيم',
            verdict: WordVerdictModel(
              wordIndex: 3,
              isCorrect: true,
              isFinal: false,
            ),
          ),
        ),
      );
      final bg = _bgOf(tester, 'الرحيم');
      expect(bg, AppColors.success.withAlpha(70));
      expect(bg, isNot(AppColors.success)); // distinct from the locked colour
    });
  });
}
