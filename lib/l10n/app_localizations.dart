import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @lastReadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Last read'**
  String get lastReadingLabel;

  /// No description provided for @verseNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Verse no'**
  String get verseNumberLabel;

  /// No description provided for @continueReadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueReadingLabel;

  /// No description provided for @homeSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeSectionTitle;

  /// No description provided for @homeTajweedLessons.
  ///
  /// In en, this message translates to:
  /// **'Tajweed lessons'**
  String get homeTajweedLessons;

  /// No description provided for @homeLevelOne.
  ///
  /// In en, this message translates to:
  /// **'Level 1'**
  String get homeLevelOne;

  /// No description provided for @homeQuranRecitation.
  ///
  /// In en, this message translates to:
  /// **'Quran recitation'**
  String get homeQuranRecitation;

  /// No description provided for @homeStartRecitation.
  ///
  /// In en, this message translates to:
  /// **'Start recitation'**
  String get homeStartRecitation;

  /// No description provided for @homeTajweedTest.
  ///
  /// In en, this message translates to:
  /// **'Tajweed test'**
  String get homeTajweedTest;

  /// No description provided for @homeStartTest.
  ///
  /// In en, this message translates to:
  /// **'Start test'**
  String get homeStartTest;

  /// No description provided for @homeQuranReflection.
  ///
  /// In en, this message translates to:
  /// **'Quran reflection'**
  String get homeQuranReflection;

  /// No description provided for @homeStartReflection.
  ///
  /// In en, this message translates to:
  /// **'Reflect on Quran'**
  String get homeStartReflection;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @snackbarRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get snackbarRetry;

  /// No description provided for @snackbarOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get snackbarOk;

  /// No description provided for @signedInSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully signed in'**
  String get signedInSuccess;

  /// No description provided for @partitionSurah.
  ///
  /// In en, this message translates to:
  /// **'Surah'**
  String get partitionSurah;

  /// No description provided for @partitionJuz.
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get partitionJuz;

  /// No description provided for @partitionPage.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get partitionPage;

  /// No description provided for @partitionHizb.
  ///
  /// In en, this message translates to:
  /// **'Hizb'**
  String get partitionHizb;

  /// No description provided for @partitionRuku.
  ///
  /// In en, this message translates to:
  /// **'Ruku'**
  String get partitionRuku;

  /// No description provided for @revelationMakkah.
  ///
  /// In en, this message translates to:
  /// **'Makkah'**
  String get revelationMakkah;

  /// No description provided for @revelationMadinah.
  ///
  /// In en, this message translates to:
  /// **'Madinah'**
  String get revelationMadinah;

  /// No description provided for @versesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} verses'**
  String versesCount(int count);

  /// No description provided for @errorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorPrefix;

  /// No description provided for @authTagline.
  ///
  /// In en, this message translates to:
  /// **'Master Qur\'an Recitation with AI Guidance.'**
  String get authTagline;

  /// No description provided for @authSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authSignIn;

  /// No description provided for @authSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get authSignUp;

  /// No description provided for @authEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmail;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get authEmailHint;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get authPasswordHint;

  /// No description provided for @authConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get authConfirmPassword;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get authForgotPassword;

  /// No description provided for @authFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get authFirstName;

  /// No description provided for @authLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get authLastName;

  /// No description provided for @authSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Select your gender:'**
  String get authSelectGender;

  /// No description provided for @authGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get authGenderMale;

  /// No description provided for @authGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get authGenderFemale;

  /// No description provided for @authNoAccountQuestion.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an Account? '**
  String get authNoAccountQuestion;

  /// No description provided for @authCreateOne.
  ///
  /// In en, this message translates to:
  /// **'create one'**
  String get authCreateOne;

  /// No description provided for @authHaveAccountQuestion.
  ///
  /// In en, this message translates to:
  /// **'Already have an Account? '**
  String get authHaveAccountQuestion;

  /// No description provided for @authSignInLink.
  ///
  /// In en, this message translates to:
  /// **'sign in'**
  String get authSignInLink;

  /// No description provided for @authOrContinueAs.
  ///
  /// In en, this message translates to:
  /// **'Or continue as '**
  String get authOrContinueAs;

  /// No description provided for @authGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get authGuest;

  /// No description provided for @authPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get authPrevious;

  /// No description provided for @authNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get authNext;

  /// No description provided for @authActivate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get authActivate;

  /// No description provided for @authCheckInbox.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox 📩'**
  String get authCheckInbox;

  /// No description provided for @authVerificationMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent you a 4-digit verification code to your email. Please enter it below to continue.'**
  String get authVerificationMessage;

  /// No description provided for @authResendCode.
  ///
  /// In en, this message translates to:
  /// **'resend code'**
  String get authResendCode;

  /// No description provided for @authTermsOfUseTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get authTermsOfUseTitle;

  /// No description provided for @authTermsOfUseBody.
  ///
  /// In en, this message translates to:
  /// **'By using this app, you agree to the following Terms of Use:\n\n1. You will use the app responsibly.\n2. You will not misuse or exploit its features.\n3. The app may collect data as per our Privacy Policy.\n4. We may update the Terms at any time.\n\nPlease read carefully before continuing.'**
  String get authTermsOfUseBody;

  /// No description provided for @authIAgreeToThe.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get authIAgreeToThe;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
