import '../../../../base/screens/exports.dart';
import '../../vm/bloc/shift_handover_bloc.dart';
import '../../vm/events/shift_handover_events.dart';

final class ShiftHandoverEmptyWidget extends SubWidget<ShiftHandoverBloc> {
  const ShiftHandoverEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'No shift report found.',
        style: AppStyles.headline3.bold().withColor(AppColors.greyDark),
      ),
      const VerticalSpacing(16),
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.warning),
        icon: const Icon(Icons.refresh, size: 30),
        label: Text('Try Again', style: AppStyles.title),
        onPressed: () => bloc.add(GetShiftReport('current-user-id')),
      ),
    ],
  ).symmetricPadding(horizontal: AppMetrics.scaffold.horizontalBodyPadding);
}
