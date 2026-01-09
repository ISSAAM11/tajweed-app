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
                        width: 1, // Adjust thickness as needed
                      ),
                    ),
                  ),
                  width: 65,
                  child: Column(
                    spacing: 6,
                    children: [
                      Text(
                        mode.label,
                        style: TextStyle(
                          color: isSelected ? Colors.black87 : Colors.black38,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSizes.title,
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        width: isSelected
                            ? 65
                            : 0, // Adjust thickness as needed
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
}
