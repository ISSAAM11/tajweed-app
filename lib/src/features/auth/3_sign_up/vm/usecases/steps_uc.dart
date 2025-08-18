part of '../bloc/sign_up_bloc.dart';

extension on SignUpBloc {
  Future<void> _next(NextStep event, Emitter<SignUpState> emit) async =>
      switch (event.current.value) {
        0 => _handlefirstStep(
          emit,
          _currentIndex,
          pageController,
          firstStepFormKey,
        ),
        1 => add(SignUpWithEmailAndPassword()),
        2 => _verifyEmail(event, emit),
        _ => null,
      };
  Future<void> _previous(PreviousStep event, Emitter<SignUpState> emit) async =>
      switch (event.current.value) {
        1 => _handlePrevious(emit, currentIndex, pageController),
        _ => null,
      };
}

void _handlePrevious(
  Emitter<SignUpState> emit,
  Observable<int> currentIndex,
  PageController controller,
) {
  currentIndex.value -= 1;
  controller.animateToPage(
    currentIndex.value,
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );
  emit(Idle());
}

void _handlefirstStep(
  Emitter<SignUpState> emit,
  Observable<int> currentIndex,
  PageController controller,
  GlobalKey<FormState> formkey,
) {
  if (formkey.isUnvalid) return;
  currentIndex.value += 1;
  controller.animateToPage(
    currentIndex.value,
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );
  emit(Idle());
}

void _verifyEmail(NextStep event, Emitter<SignUpState> emit) {}
