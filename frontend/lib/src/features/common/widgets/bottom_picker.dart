import 'package:country_picker/country_picker.dart';
import 'package:tajweed_ai/src/base/extensions/date_time_ext.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'custom_date_picker.dart';

enum PickerType { country, date }

class GenericFieldPicker extends StatelessWidget {
  final PickerType type;
  final Country? country;
  final DateTime? date;
  final Function(dynamic)
  onSelected; // dynamic because it can be Country or DateTime
  final int? width;

  const GenericFieldPicker({
    super.key,
    required this.type,
    required this.onSelected,
    this.country,
    this.date,
    this.width,
  });

  void _openPicker(BuildContext context) {
    switch (type) {
      case PickerType.country:
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          countryListTheme: CountryListThemeData(
            borderRadius: BorderRadius.circular(16),
            inputDecoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Type to search country',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.inputBorder,
                  width: AppMetrics.inputs.borderWidth,
                ),
              ),
            ),
          ),
          onSelect: (Country selected) => onSelected(selected),
        );
        break;

      case PickerType.date:
        CustomDatePicker.show(
          context: context,
          initialDate: DateTime(1996, 10, 22),
          maxDate: DateTime(DateTime.now().year - 5),
          minDate: DateTime(1950),
          onDateSelected: (DateTime selected) => onSelected(selected),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    String displayText;
    IconData icon;

    switch (type) {
      case PickerType.country:
        displayText = country != null && country!.name.isNotEmpty
            ? country!.name
            : "Select a country";
        icon = Icons.flag_outlined;
        break;
      case PickerType.date:
        displayText = date != null ? date!.toDate : "Select a date";
        icon = Icons.calendar_today;
        break;
    }

    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => _openPicker(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: type == PickerType.country
              ? "Enter your country"
              : "Enter your Birthday",
          labelStyle: AppStyles.indication.copyWith(color: scheme.onSurfaceVariant),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
            borderSide: BorderSide(
              color: AppColors.inputBorder,
              width: AppMetrics.inputs.borderWidth,
            ),
          ),
          filled: true,
          fillColor: scheme.surfaceContainerHigh,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppMetrics.inputs.horizontalContentPadding - 10,
            vertical: AppMetrics.inputs.verticalContentPadding,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: scheme.onSurfaceVariant, size: 18),
            const SizedBox(width: 10),
            Text(
              displayText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppStyles.title.withColor(scheme.onSurface),
            ).expanded(),
          ],
        ),
      ),
    );
  }
}
