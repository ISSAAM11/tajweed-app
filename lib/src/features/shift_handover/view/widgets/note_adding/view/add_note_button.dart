//= Note ADDING USE CASE

import '../../../../../../base/screens/exports.dart';
import '../../../../vm/bloc/shift_handover_bloc.dart';
import '../vm/bloc/note_adding_bloc.dart';

class NoteAddingUC extends SubFeature<NoteAddingBloc, NoteAddingState, ShiftHandoverBloc> {
  NoteAddingUC() : super(dependencies: () => di.registerInstance(NoteAddingBloc()));

  @override
  Widget build(BuildContext context, NoteAddingState state) => LoadingButton(
    isLoading: state is Loading,
    title: 'Add Note',
    titleFontSize: AppStyles.title.fontSize,
    onTap: () async {
      bloc.addNote();
      await Future.delayed(const Duration(seconds: 1));
      parentBloc.accessHome();
    },
  );
}
