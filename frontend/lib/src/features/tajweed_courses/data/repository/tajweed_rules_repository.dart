import 'package:tajweed_ai/src/app/design/audio/app_audio.dart';

import '../models/tajweed_example.dart';
import '../models/tajweed_rule.dart';

class TajweedRulesRepository {
  const TajweedRulesRepository();

  List<TajweedRule> all() => _rules;

  TajweedRule? byId(String id) {
    for (final rule in _rules) {
      if (rule.id == id) return rule;
    }
    return null;
  }

  static const _rules = <TajweedRule>[
    TajweedRule(
      id: 'madd',
      titleKey: 'tajweedRuleMaddTitle',
      shortDescriptionKey: 'tajweedRuleMaddDescription',
      longDescriptionKey: 'tajweedRuleMaddLongDescription',
      examples: [
        TajweedExample(
          id: 'madd_1',
          arabicText: 'قَالَ',
          referenceKey: 'tajweedRuleMaddExample1Reference',
          transliterationKey: 'tajweedRuleMaddExample1Transliteration',
          explanationKey: 'tajweedRuleMaddExample1Explanation',
        ),
        TajweedExample(
          id: 'madd_2',
          arabicText: 'يَقُولُ',
          referenceKey: 'tajweedRuleMaddExample2Reference',
          transliterationKey: 'tajweedRuleMaddExample2Transliteration',
          explanationKey: 'tajweedRuleMaddExample2Explanation',
        ),
      ],
    ),
    TajweedRule(
      id: 'ghunnah',
      titleKey: 'tajweedRuleGhunnahTitle',
      shortDescriptionKey: 'tajweedRuleGhunnahDescription',
      longDescriptionKey: 'tajweedRuleGhunnahLongDescription',
      examples: [
        TajweedExample(
          id: 'ghunnah_1',
          arabicText: 'إِنَّ',
          referenceKey: 'tajweedRuleGhunnahExample1Reference',
          transliterationKey: 'tajweedRuleGhunnahExample1Transliteration',
          explanationKey: 'tajweedRuleGhunnahExample1Explanation',
        ),
        TajweedExample(
          id: 'ghunnah_2',
          arabicText: 'ثُمَّ',
          referenceKey: 'tajweedRuleGhunnahExample2Reference',
          transliterationKey: 'tajweedRuleGhunnahExample2Transliteration',
          explanationKey: 'tajweedRuleGhunnahExample2Explanation',
        ),
      ],
    ),
    TajweedRule(
      id: 'idgham',
      titleKey: 'tajweedRuleIdghamTitle',
      shortDescriptionKey: 'tajweedRuleIdghamDescription',
      longDescriptionKey: 'tajweedRuleIdghamLongDescription',
      examples: [
        TajweedExample(
          id: 'idgham_with_ghunnah',
          arabicText: 'مَن يَعْمَلْ',
          referenceKey: 'tajweedRuleIdghamExample1Reference',
          transliterationKey: 'tajweedRuleIdghamExample1Transliteration',
          explanationKey: 'tajweedRuleIdghamExample1Explanation',
          audioAsset: AppAudio.idghamWithGhunnah,
        ),
        TajweedExample(
          id: 'idgham_without_ghunnah',
          arabicText: 'مِن رَّبِّهِمْ',
          referenceKey: 'tajweedRuleIdghamExample2Reference',
          transliterationKey: 'tajweedRuleIdghamExample2Transliteration',
          explanationKey: 'tajweedRuleIdghamExample2Explanation',
          audioAsset: AppAudio.idghamWithoutGhunnah,
        ),
      ],
    ),
    TajweedRule(
      id: 'idgham_shafawy',
      titleKey: 'tajweedRuleIdghamShafawyTitle',
      shortDescriptionKey: 'tajweedRuleIdghamShafawyDescription',
      longDescriptionKey: 'tajweedRuleIdghamShafawyLongDescription',
      examples: [
        TajweedExample(
          id: 'idgham_shafawy_1',
          arabicText: 'أَنتُم مَّاكِثُونَ',
          referenceKey: 'tajweedRuleIdghamShafawyExample1Reference',
          transliterationKey: 'tajweedRuleIdghamShafawyExample1Transliteration',
          explanationKey: 'tajweedRuleIdghamShafawyExample1Explanation',
          audioAsset: AppAudio.idghamShafawy,
        ),
      ],
    ),
    TajweedRule(
      id: 'ikhfa',
      titleKey: 'tajweedRuleIkhfaTitle',
      shortDescriptionKey: 'tajweedRuleIkhfaDescription',
      longDescriptionKey: 'tajweedRuleIkhfaLongDescription',
      examples: [
        TajweedExample(
          id: 'ikhfa_1',
          arabicText: 'مِن شَرِّ',
          referenceKey: 'tajweedRuleIkhfaExample1Reference',
          transliterationKey: 'tajweedRuleIkhfaExample1Transliteration',
          explanationKey: 'tajweedRuleIkhfaExample1Explanation',
          audioAsset: AppAudio.ikhfa,
        ),
        TajweedExample(
          id: 'ikhfa_shafawy',
          arabicText: 'يَعْتَصِم بِاللَّهِ',
          referenceKey: 'tajweedRuleIkhfaExample2Reference',
          transliterationKey: 'tajweedRuleIkhfaExample2Transliteration',
          explanationKey: 'tajweedRuleIkhfaExample2Explanation',
          audioAsset: AppAudio.ikhfaShafawy,
        ),
      ],
    ),
    TajweedRule(
      id: 'iqlab',
      titleKey: 'tajweedRuleIqlabTitle',
      shortDescriptionKey: 'tajweedRuleIqlabDescription',
      longDescriptionKey: 'tajweedRuleIqlabLongDescription',
      examples: [
        TajweedExample(
          id: 'iqlab_1',
          arabicText: 'مِنۢ بَعْدِ',
          referenceKey: 'tajweedRuleIqlabExample1Reference',
          transliterationKey: 'tajweedRuleIqlabExample1Transliteration',
          explanationKey: 'tajweedRuleIqlabExample1Explanation',
          audioAsset: AppAudio.iqlab,
        ),
      ],
    ),
    TajweedRule(
      id: 'qalqala',
      titleKey: 'tajweedRuleQalqalaTitle',
      shortDescriptionKey: 'tajweedRuleQalqalaDescription',
      longDescriptionKey: 'tajweedRuleQalqalaLongDescription',
      examples: [
        TajweedExample(
          id: 'qalqala_1',
          arabicText: 'يَجْعَلُونَ',
          referenceKey: 'tajweedRuleQalqalaExample1Reference',
          transliterationKey: 'tajweedRuleQalqalaExample1Transliteration',
          explanationKey: 'tajweedRuleQalqalaExample1Explanation',
        ),
        TajweedExample(
          id: 'qalqala_2',
          arabicText: 'وَلَمْ يُولَدْ',
          referenceKey: 'tajweedRuleQalqalaExample2Reference',
          transliterationKey: 'tajweedRuleQalqalaExample2Transliteration',
          explanationKey: 'tajweedRuleQalqalaExample2Explanation',
        ),
      ],
    ),
  ];
}
