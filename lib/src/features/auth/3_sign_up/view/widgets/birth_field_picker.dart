import '../../../../../base/screens/exports.dart';
import '../../../../common/widgets/bottom_picker.dart';

class BirthFieldPicker extends StatelessWidget {
  final DateTime date;
  final Function(dynamic) onDateSelected;
  final int? width;

  const BirthFieldPicker({
    super.key,
    required this.onDateSelected,
    required this.date,
    this.width,
  });

  @override
  Widget build(BuildContext context) => GenericFieldPicker(
    type: PickerType.date,
    date: date,
    onSelected: onDateSelected,
  );
}
