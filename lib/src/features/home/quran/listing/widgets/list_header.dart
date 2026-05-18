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
    return SizedBox(
      width: double.infinity,
      child: Container(
        color: AppColors.focusColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: PartitionMode.values.map((mode) {
              return ChoiceChip(
                label: Text(
                  mode.label,
                  style: TextStyle(color: AppColors.primary, fontSize: 20),
                ),
                selectedShadowColor: const Color.fromARGB(197, 139, 115, 85),
                selected: selectedViewMode == mode,
                showCheckmark: false,
                onSelected: (isSelected) {
                  if (isSelected) onSelectMode(mode);
                },
              ).symmetricPadding(horizontal: 5, vertical: 5);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
