import 'package:country_picker/country_picker.dart';

import '../../../../../base/screens/exports.dart';

class CountryFieldPicker extends StatelessWidget {
  final Country country;
  final Function(Country) onCountrySelected;

  const CountryFieldPicker({
    super.key,
    required this.onCountrySelected,
    required this.country,
  });

  void _openCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false, // تخليها true لو تحب يظهر كود الهاتف
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
      onSelect: onCountrySelected,
    );
  }

  @override
  Widget build(BuildContext context) =>
      Row(
            children: [
              const Icon(Icons.flag_outlined, color: Colors.grey, size: 18),
              const HorizontalSpacing(10),
              Text(
                country.name,
                style: AppStyles.title.medium().withColor(
                  AppColors.greyRegular,
                ),
              ),
            ],
          )
          .decorate(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: AppMetrics.inputs.verticalContentPadding,
              bottom: AppMetrics.inputs.verticalContentPadding,
              left: AppMetrics.inputs.verticalContentPadding - 3,
            ),
            decoration: BoxDecoration(
              color: AppColors.greyBackground,
              borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
              border: Border.all(
                color: AppColors.inputBorder,
                width: AppMetrics.inputs.borderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          )
          .onTap(() => _openCountryPicker(context));
}
