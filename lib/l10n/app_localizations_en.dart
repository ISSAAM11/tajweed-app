// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get lastReadingLabel => 'Last read';

  @override
  String get verseNumberLabel => 'Verse no';

  @override
  String get continueReadingLabel => 'Continue';

  @override
  String get homeSectionTitle => 'Home';

  @override
  String get homeTajweedLessons => 'Tajweed lessons';

  @override
  String get homeLevelOne => 'Level 1';

  @override
  String get homeQuranRecitation => 'Quran recitation';

  @override
  String get homeStartRecitation => 'Start recitation';

  @override
  String get homeTajweedTest => 'Tajweed test';

  @override
  String get homeStartTest => 'Start test';

  @override
  String get homeQuranReflection => 'Quran reflection';

  @override
  String get homeStartReflection => 'Reflect on Quran';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get comingSoonMessage => 'This feature is coming soon. Stay tuned!';

  @override
  String get settingsAccountSection => 'Account';

  @override
  String get settingsGuestLabel => 'Guest';

  @override
  String get settingsGuestSubtitle => 'Tap to manage your account';

  @override
  String get settingsComingSoonSection => 'Coming soon';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsDailyReminders => 'Daily reminders';

  @override
  String get settingsAboutSection => 'About';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsTermsOfUse => 'Terms of Use';

  @override
  String get termsOfUseTitle => 'Terms of Use';

  @override
  String get termsOfUseBody =>
      'These Terms of Use govern your use of Tajweed AI. By using the app you agree to these terms.\n\nTajweed AI is provided as-is for educational and personal use to help you read and reflect on the Quran with correct Tajweed. We do our best to ensure the Quran text and Tajweed indications displayed are accurate, but we make no warranty of completeness.\n\nWe respect your privacy: no personal data is collected without your consent. Reading progress and settings are stored locally on your device.\n\nThe full Terms of Use will be published with future releases. For questions, please contact us through the app store listing.';

  @override
  String get myAccountTitle => 'My Account';

  @override
  String get myAccountYourAccount => 'Your account';

  @override
  String get myAccountComingSoonSection => 'Coming soon';

  @override
  String get myAccountChangePassword => 'Change password';

  @override
  String get myAccountAvatar => 'Avatar';

  @override
  String get myAccountLinkedAccounts => 'Linked accounts';

  @override
  String get myAccountSignOut => 'Sign out';

  @override
  String get myAccountSignOutConfirmTitle => 'Sign out?';

  @override
  String get myAccountSignOutConfirmMessage =>
      'You\'ll need to sign in again to access your account.';

  @override
  String get myAccountSignOutCancel => 'Cancel';

  @override
  String get tajweedCoursesTitle => 'Tajweed Rules';

  @override
  String get tajweedCoursesIntro =>
      'Tajweed (تجويد) is the set of rules that govern correct pronunciation of the Quran. Below are the core rules every reciter should know.';

  @override
  String get tajweedCoursesInteractive => 'Interactive lessons';

  @override
  String get tajweedRuleMaddTitle => 'Madd (المدّ) — Elongation';

  @override
  String get tajweedRuleMaddDescription =>
      'Prolonging a vowel sound by 2, 4, or 6 counts depending on the type. Madd Tabi\'i is the natural elongation of 2 counts.';

  @override
  String get tajweedRuleGhunnahTitle => 'Ghunnah (الغُنّة) — Nasalization';

  @override
  String get tajweedRuleGhunnahDescription =>
      'A nasal sound produced when pronouncing letters Noon (ن) or Meem (م) with shaddah, held for about 2 counts.';

  @override
  String get tajweedRuleIdghamTitle => 'Idgham (الإدغام) — Merging';

  @override
  String get tajweedRuleIdghamDescription =>
      'Merging a Noon Sakinah or Tanween into one of the letters: ي، ر، م، ل، و، ن. The merging may include Ghunnah depending on the letter.';

  @override
  String get tajweedRuleIkhfaTitle => 'Ikhfa (الإخفاء) — Concealment';

  @override
  String get tajweedRuleIkhfaDescription =>
      'Hiding the sound of Noon Sakinah or Tanween between Idgham and Izhar when followed by any of 15 specific letters, with Ghunnah.';

  @override
  String get tajweedRuleIqlabTitle => 'Iqlab (الإقلاب) — Conversion';

  @override
  String get tajweedRuleIqlabDescription =>
      'Converting a Noon Sakinah or Tanween into a hidden Meem when followed by the letter Ba (ب), with Ghunnah.';

  @override
  String get tajweedRuleQalqalaTitle => 'Qalqala (القلقلة) — Echoing';

  @override
  String get tajweedRuleQalqalaDescription =>
      'A bouncing echo sound on the letters: ق، ط، ب، ج، د when they have a sukoon. Stronger at the end of a verse.';

  @override
  String get snackbarRetry => 'Retry';

  @override
  String get snackbarOk => 'OK';

  @override
  String get signedInSuccess => 'Successfully signed in';

  @override
  String get partitionSurah => 'Surah';

  @override
  String get partitionJuz => 'Juz';

  @override
  String get partitionPage => 'Page';

  @override
  String get partitionHizb => 'Hizb';

  @override
  String get partitionRuku => 'Ruku';

  @override
  String get revelationMakkah => 'Makkah';

  @override
  String get revelationMadinah => 'Madinah';

  @override
  String versesCount(int count) {
    return '$count verses';
  }

  @override
  String get errorPrefix => 'Error';

  @override
  String get authTagline => 'Master Qur\'an Recitation with AI Guidance.';

  @override
  String get authSignIn => 'Sign In';

  @override
  String get authSignUp => 'Sign Up';

  @override
  String get authEmail => 'Email';

  @override
  String get authEmailHint => 'Enter your email';

  @override
  String get authPassword => 'Password';

  @override
  String get authPasswordHint => 'Enter your password';

  @override
  String get authConfirmPassword => 'Confirm Password';

  @override
  String get authForgotPassword => 'Forgot Password?';

  @override
  String get authFirstName => 'First Name';

  @override
  String get authLastName => 'Last Name';

  @override
  String get authSelectGender => 'Select your gender:';

  @override
  String get authGenderMale => 'Male';

  @override
  String get authGenderFemale => 'Female';

  @override
  String get authNoAccountQuestion => 'Don\'t have an Account? ';

  @override
  String get authCreateOne => 'create one';

  @override
  String get authHaveAccountQuestion => 'Already have an Account? ';

  @override
  String get authSignInLink => 'sign in';

  @override
  String get authOrContinueAs => 'Or continue as ';

  @override
  String get authGuest => 'Guest';

  @override
  String get authPrevious => 'Previous';

  @override
  String get authNext => 'Next';

  @override
  String get authActivate => 'Activate';

  @override
  String get authCheckInbox => 'Check your inbox 📩';

  @override
  String get authVerificationMessage =>
      'We\'ve sent you a 4-digit verification code to your email. Please enter it below to continue.';

  @override
  String get authResendCode => 'resend code';

  @override
  String get authTermsOfUseTitle => 'Terms of Use';

  @override
  String get authTermsOfUseBody =>
      'By using this app, you agree to the following Terms of Use:\n\n1. You will use the app responsibly.\n2. You will not misuse or exploit its features.\n3. The app may collect data as per our Privacy Policy.\n4. We may update the Terms at any time.\n\nPlease read carefully before continuing.';

  @override
  String get authIAgreeToThe => 'I agree to the ';
}
