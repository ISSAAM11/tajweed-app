import 'package:country_picker/country_picker.dart';

import '../../../../../base/screens/exports.dart';
import '../../../../common/widgets/bottom_picker.dart';

class CountryFieldPicker extends StatelessWidget {
  final Country country;
  final int? width;
  final Function(dynamic) onCountrySelected;

  const CountryFieldPicker({
    super.key,
    required this.onCountrySelected,
    required this.country,
    this.width,
  });

  @override
  Widget build(BuildContext context) => GenericFieldPicker(
    type: PickerType.country,
    country: country,
    onSelected: onCountrySelected,
  );
}
