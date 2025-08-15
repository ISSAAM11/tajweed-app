import '../../../../base/screens/exports.dart';
import '../../data/models/shift_report_do.dart';
import '../../vm/bloc/shift_handover_bloc.dart';
import 'note_adding/view/add_note_button.dart';
import 'note_card.dart';

final class ReportViewWidget extends SubWidget<ShiftHandoverBloc> {
  const ReportViewWidget(this.report, {super.key});

  final ShiftReportDO report;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      (report.notes.isEmpty)
          ? Text(
              'No notes added yet.\nUse the form below to add the first note.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ).center().expanded()
          : Column(
              children: [
                ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: report.notes.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      NoteCard(key: ValueKey(report.notes[index].id), note: report.notes[index]),
                ).expanded(),

                NoteAddingUC().symmetricPadding(vertical: 20),

                _AccessHomeButton().customPadding(bottom: 40),
              ],
            ).expanded(),
    ],
  ).symmetricPadding(horizontal: AppMetrics.scaffold.horizontalBodyPadding);
}

class _AccessHomeButton extends SubWidget<ShiftHandoverBloc> {
  const _AccessHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      observes: bloc.accessingHomeObs,
      builder: (context, isLoading) => LoadingButton(
        isLoading: isLoading,
        title: 'Access Home',
        titleFontSize: AppStyles.title.fontSize,
        onTap: bloc.accessHome,
      ),
    );
  }
}
