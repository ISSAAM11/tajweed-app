// import '../../../../../base/screens/exports.dart';
// import '../../../../common/widgets/app_logo.dart';
// import '../../../../common/widgets/form_input.dart';
// import '../../../../common/widgets/or_devider.dart';
// import '../../../../../utils/input_validator.dart' show InputValidators;
// import '../../../1_sign_in/view/widgets/social_login_buttons.dart';
// import '../../vm/bloc/sign_up_bloc.dart';
// import '../../vm/states/sign_up_states.dart';

// class SignupStepper extends SubWidget<SignUpBloc> {
//   final SignUpState state;
//   SignupStepper(this.state, {super.key});

//   int currentStep = 0;
//   final PageController _pageController = PageController();
  
//   // Controllers for Step 1
//   // final TextEditingController _emailController = TextEditingController();
//   // final TextEditingController _passwordController = TextEditingController();
//   // final TextEditingController _confirmPasswordController = TextEditingController();
  
//   // // Form key
//   // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   // @override
//   // void dispose() {
//   //   _pageController.dispose();
//   //   _emailController.dispose();
//   //   _passwordController.dispose();
//   //   _confirmPasswordController.dispose();
//   //   super.dispose();
//   // }

//   // void _nextStep() {
//   //   if (currentStep < 2) {
//   //     setState(() {
//   //       currentStep++;
//   //     });
//   //     _pageController.animateToPage(
//   //       currentStep,
//   //       duration: const Duration(milliseconds: 300),
//   //       curve: Curves.easeInOut,
//   //     );
//   //   }
//   // }

//   // void _previousStep() {
//   //   if (currentStep > 0) {
//   //     setState(() {
//   //       currentStep--;
//   //     });
//   //     _pageController.animateToPage(
//   //       currentStep,
//   //       duration: const Duration(milliseconds: 300),
//   //       curve: Curves.easeInOut,
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             children: [
//               //$ Header
//               const AppLogo(),
//               VerticalSpacing(AppMetrics.spacing.xs),
              
//               //$ App Info
//               Text(
//                 'Tajweed AI',
//                 style: AppStyles.headline1.bold().primary(),
//               ),
//               VerticalSpacing(AppMetrics.spacing.xs),
//               Text(
//                 'Create Your Account',
//                 style: AppStyles.subtitle.medium().greyRegular(),
//               ),
//               VerticalSpacing(AppMetrics.spacing.md),
              
//               //$ Step Indicator
//               _buildStepIndicator(),
//               VerticalSpacing(AppMetrics.spacing.md),
              
//               //$ Step Content
//               SizedBox(
//                 height: 300, // Reduced height for more compact layout
//                 child: PageView(
//                   controller: _pageController,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: [
//                     _buildStep1(),
//                     _buildStep2(),
//                     _buildStep3(),
//                   ],
//                 ),
//               ),
              
//               //$ Navigation Buttons
//               _buildNavigationButtons(),
//             ],
//           ).overallPadding(15),
//         ),
//         _backButton(),
//       ],
//     ).center().gradientBackground();
//   }

//   Widget _backButton() =>  //$ Back Button at top left
//         Positioned(
//           top: 24,
//           left: 24,
//           child: IconButton(
//             onPressed: () {
//               // TODO: Navigate back to sign in
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: AppColors.primary,
//               size: 24,
//             ),
//           ),
//         );
  
//   Widget _buildStepIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(3, (index) {
//         final isActive = index == currentStep;
//         final isCompleted = index < currentStep;
        
//         return Row(
//           children: [
//             // Step Circle
//             Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: isCompleted 
//                     ? AppColors.primary 
//                     : isActive 
//                         ? AppColors.primary 
//                         : AppColors.greyLight,
//                 border: Border.all(
//                   color: isActive ? AppColors.primary : AppColors.divider,
//                   width: 2,
//                 ),
//               ),
//               child: Center(
//                 child: isCompleted
//                     ? Icon(
//                         Icons.check,
//                         color: Colors.white,
//                         size: 20,
//                       )
//                     : Text(
//                         '${index + 1}',
//                         style: AppStyles.subtitle.medium().withColor(
//                           isActive ? Colors.white : AppColors.greyRegular,
//                         ),
//                       ),
//               ),
//             ),
            
//             // Connector Line (except for last step)
//             if (index < 2)
//               Container(
//                 width: 60,
//                 height: 2,
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: isCompleted 
//                         ? [AppColors.primary, AppColors.primary]
//                         : [AppColors.divider, AppColors.divider],
//                   ),
//                 ),
//               ),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _buildStep1() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Account Details',
//             style: AppStyles.headline3.bold().primary(),
//           ),
//           VerticalSpacing(AppMetrics.spacing.xs),
//           Text(
//             'Create your account to get started',
//             style: AppStyles.subtitle.medium().greyRegular(),
//           ),
//           VerticalSpacing(AppMetrics.spacing.md),
          
//           // Email Input
//           FormInput(
//             type: FormInputType.email,
//             controller: _emailController,
//             validator: InputValidators.validateEmail,
//             label: 'Email Address',
//             hint: 'Enter your email',
//             prefixIcon: const Icon(Icons.email_outlined),
//             enableRealTimeValidation: true,
//           ),
//           VerticalSpacing(AppMetrics.spacing.sm),
          
//           // Password Input
//           FormInput(
//             type: FormInputType.password,
//             controller: _passwordController,
//             validator: InputValidators.validateLoginPassword,
//             label: 'Password',
//             hint: 'Enter your password',
//             prefixIcon: const Icon(Icons.lock_outline),
//             enableRealTimeValidation: true,
//           ),
//           VerticalSpacing(AppMetrics.spacing.sm),
          
//           // Confirm Password Input
//           FormInput(
//             type: FormInputType.password,
//             controller: _confirmPasswordController,
//             validator: (value) {
//               if (value != _passwordController.text) {
//                 return 'Passwords do not match';
//               }
//               return null;
//             },
//             label: 'Confirm Password',
//             hint: 'Confirm your password',
//             prefixIcon: const Icon(Icons.lock_outline),
//             enableRealTimeValidation: true,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStep2() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Profile Information',
//           style: AppStyles.headline3.bold().primary(),
//         ),
//         VerticalSpacing(AppMetrics.spacing.xs),
//         Text(
//           'Tell us a bit about yourself',
//           style: AppStyles.subtitle.medium().greyRegular(),
//         ),
//         VerticalSpacing(AppMetrics.spacing.md),
        
//         // Placeholder for profile fields
//         Container(
//           height: 150,
//           decoration: BoxDecoration(
//             color: AppColors.greyBackground,
//             borderRadius: BorderRadius.circular(AppMetrics.defaultRadius),
//             border: Border.all(color: AppColors.divider),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.person_add_outlined,
//                   size: 48,
//                   color: AppColors.greyRegular,
//                 ),
//                 VerticalSpacing(AppMetrics.spacing.sm),
//                 Text(
//                   'Profile fields coming soon',
//                   style: AppStyles.subtitle.medium().greyRegular(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStep3() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Verify Account',
//           style: AppStyles.headline3.bold().primary(),
//         ),
//         VerticalSpacing(AppMetrics.spacing.xs),
//         Text(
//           'Verify your email to complete registration',
//           style: AppStyles.subtitle.medium().greyRegular(),
//         ),
//         VerticalSpacing(AppMetrics.spacing.md),
        
//         // Placeholder for verification
//         Container(
//           height: 150,
//           decoration: BoxDecoration(
//             color: AppColors.greyBackground,
//             borderRadius: BorderRadius.circular(AppMetrics.defaultRadius),
//             border: Border.all(color: AppColors.divider),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.verified_outlined,
//                   size: 48,
//                   color: AppColors.greyRegular,
//                 ),
//                 VerticalSpacing(AppMetrics.spacing.sm),
//                 Text(
//                   'Verification coming soon',
//                   style: AppStyles.subtitle.medium().greyRegular(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildNavigationButtons() {
//     return Column(
//       children: [
//         // Social Login (only on first step)
//         if (currentStep == 0) ...[
//           OrDivider(),
//           VerticalSpacing(AppMetrics.spacing.xs),
//           SocialLoginButtons(
//             onGoogleTap: () {
//               // TODO: Implement Google sign up
//             },
//             onFacebookTap: () {
//               // TODO: Implement Facebook sign up
//             },
//           ),
//           VerticalSpacing(AppMetrics.spacing.sm),
//         ],
        
//         // Navigation Buttons
//         Row(
//           children: [
//             if (currentStep > 0)
//               Expanded(
//                 child: OutlinedLoadingButton(
//                   title: 'Previous',
//                   onTap: _previousStep,
//                   titleFontSize: FontSizes.title,
//                   height: AppMetrics.buttons.elevated.height,
//                   textColor: AppColors.primary,
//                   borderGradient: AppColors.primaryGradient,
//                 ),
//               ),
//             if (currentStep > 0) HorizontalSpacing(AppMetrics.spacing.md),
//             Expanded(
//               child: LoadingButton(
//                 title: currentStep == 2 ? 'Complete' : 'Next',
//                 onTap: currentStep == 2 ? () {
//                   // TODO: Complete signup
//                 } : _nextStep,
//                 titleFontSize: FontSizes.title,
//                 height: AppMetrics.buttons.elevated.height,
//                 useGradient: true,
//                 gradient: AppColors.primaryGradient,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
