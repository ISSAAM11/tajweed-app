import 'tajweed_example.dart';

class TajweedRule {
  final String id;
  final String titleKey;
  final String shortDescriptionKey;
  final String longDescriptionKey;
  final List<TajweedExample> examples;

  const TajweedRule({
    required this.id,
    required this.titleKey,
    required this.shortDescriptionKey,
    required this.longDescriptionKey,
    required this.examples,
  });
}
