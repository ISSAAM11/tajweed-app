import 'package:country_picker/country_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:tajweed_ai/src/features/auth/3_sign_up/view/widgets/birth_field_picker.dart';
import 'package:tajweed_ai/src/features/auth/3_sign_up/view/widgets/country_field_picker.dart';
import 'package:tajweed_ai/src/features/common/widgets/custom_text_button.dart';

import '../../../../../base/screens/exports.dart';
import '../../../../../utils/input_validator.dart';
import '../../../../common/widgets/animated_stepper.dart';
import '../../../../common/widgets/form_input.dart';

part 'first_step.dart';
part 'second_step.dart';
part 'third_step.dart';
part 'terms_of_use.dart';
part 'form_builder.dart';
part 'sign_up_buttons.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> firstStepFormKey;
  final GlobalKey<FormState> secondStepFormKey;
  final InputControl firstName;
  final InputControl lastName;
  final Observable<DateTime> birthDate;
  final Observable<Country> country;
  final InputControl email;
  final InputControl password;
  final InputControl confirmPassword;
  final Observable<String> selectedGenderObs;
  final PageController pageController;
  final Observable<int> currentStep;
  final Observable<bool> acceptedTerms;
  final bool isLoading;
  final void Function() nextAction;
  final void Function()? previousActions;
  final TextEditingController pinController;
  final FocusNode pinFocusNode;
  final void Function(String)? onPinSubmitted;
  final void Function() resnedPin;
  const SignUpForm({
    super.key,
    required this.firstStepFormKey,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.acceptedTerms,
    required this.currentStep,
    required this.secondStepFormKey,
    required this.pageController,
    required this.nextAction,
    this.previousActions,
    required this.birthDate,
    required this.country,
    required this.selectedGenderObs,
    required this.isLoading,
    required this.pinController,
    required this.pinFocusNode,
    this.onPinSubmitted,
    required this.resnedPin,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      RepaintBoundary(
        child: AnimatedStepper(length: 3, currentStep: currentStep),
      ),

      _FormBuilder(
        controller: pageController,
        widgets: [
          _Step1(
            formKey: firstStepFormKey,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
          ),
          _Step2(
            formKey: secondStepFormKey,
            firstName: firstName,
            lastName: lastName,
            birthDate: birthDate,
            country: country,
            selectedGenderObs: selectedGenderObs,
          ),
          _Step3(
            pinController: pinController,
            pinFocusNode: pinFocusNode,
            onCompleted: onPinSubmitted,
            resend: resnedPin,
          ),
        ],
      ),
      _TermsOfUse(isChecked: acceptedTerms),

      _Actions(
        index: currentStep,
        onNext: nextAction,
        onPrevious: previousActions,
        isLoading: isLoading,
      ),
      VerticalSpacing(AppMetrics.spacing.md),
    ],
  );
}
