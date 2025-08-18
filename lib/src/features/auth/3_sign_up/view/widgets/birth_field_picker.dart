import 'package:tajweed_ai/src/base/extensions/date_time_ext.dart';

import '../../../../../base/screens/exports.dart';
import '../../../../common/widgets/custom_date_picker.dart';

class BirthFieldPicker extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) onDateSelected;

  BirthFieldPicker({
    super.key,
    required this.onDateSelected,
    required this.date,
  });

  final initialDate = DateTime.now();

  void _openDatePicker(BuildContext context) {
    CustomDatePicker.show(
      context: context,
      initialDate: DateTime(1996, 10, 22),
      maxDate: DateTime(2005),
      minDate: DateTime(1950),
      onDateSelected: onDateSelected,
    );
  }

  @override
  Widget build(BuildContext context) =>
      Row(
            children: [
              Icon(Icons.date_range_outlined, color: Colors.grey, size: 18),
              const HorizontalSpacing(10),
              Text(
                date.toDate,
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
          .onTap(() => _openDatePicker(context));
}
