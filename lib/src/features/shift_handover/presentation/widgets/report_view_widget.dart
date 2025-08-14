import '../../../../base/screens/exports.dart';
import '../../data/models/shift_report_do.dart';
import 'note_card.dart';

final class ReportViewWidget extends StatelessWidget {
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
          : ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: report.notes.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  NoteCard(key: ValueKey(report.notes[index].id), note: report.notes[index]),
            ).expanded(),
    ],
  );
}
