import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

class ListHeader extends StatelessWidget {
  final PartitionMode selectedViewMode;
  final Function(PartitionMode) onSelectMode;

  const ListHeader({
    super.key,
    required this.selectedViewMode,
    required this.onSelectMode,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: PartitionMode.values.map((mode) {
              final isSelected = selectedViewMode == mode;
              return GestureDetector(
                onTap: () => onSelectMode(mode),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                    ),
                  ),
                  width: 65,
                  child: Column(
                    spacing: 6,
                    children: [
                      Text(
                        _localizedPartitionLabel(l10n, mode),
                        style: TextStyle(
                          color: isSelected ? Colors.black87 : Colors.black38,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSizes.title,
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        width: isSelected ? 55 : 0,
                        height: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: isSelected ? Colors.black87 : Colors.black12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  String _localizedPartitionLabel(AppLocalizations l10n, PartitionMode mode) =>
      switch (mode) {
        PartitionMode.surah => l10n.partitionSurah,
        PartitionMode.juz => l10n.partitionJuz,
        PartitionMode.page => l10n.partitionPage,
        PartitionMode.hizb => l10n.partitionHizb,
        PartitionMode.ruku => l10n.partitionRuku,
      };
}
