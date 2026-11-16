import 'package:generic_requester/generic_requester.dart';

/// One row of `GET /api/reciters/` — everything needed to upsert a
/// [CheikhListTableCompanion] except the actual timing database bytes,
/// which are fetched separately (and lazily) from [timingDbUrl].
class RemoteReciter {
  final String slug;
  final String nameSimple;
  final String nameArabic;
  final String timingDbUrl;

  const RemoteReciter({
    required this.slug,
    required this.nameSimple,
    required this.nameArabic,
    required this.timingDbUrl,
  });

  factory RemoteReciter.fromJson(Map<String, dynamic> json) => RemoteReciter(
        slug: json['slug'] as String,
        nameSimple: json['name_simple'] as String,
        nameArabic: json['name_arabic'] as String,
        timingDbUrl: json['timing_db_url'] as String,
      );
}

final class ReciterCatalogModel extends ModelingProtocol {
  final List<RemoteReciter> reciters;

  const ReciterCatalogModel({required this.reciters});

  factory ReciterCatalogModel.empty() => const ReciterCatalogModel(reciters: []);

  @override
  ReciterCatalogModel fromJson(json) {
    final list = (json as List?) ?? const [];
    return ReciterCatalogModel(
      reciters: list
          .cast<Map<String, dynamic>>()
          .map(RemoteReciter.fromJson)
          .toList(),
    );
  }

  @override
  List<Object?> get props => [reciters];
}
