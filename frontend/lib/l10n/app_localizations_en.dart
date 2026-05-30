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
  String get tajweedRuleExamplesSection => 'Examples';

  @override
  String get tajweedRuleMaddLongDescription =>
      'Madd (المدّ) is the elongation of a vowel sound carried by one of the three Madd letters: Alif (ا), Waw (و), or Yaa (ي). The baseline elongation — Madd Tabi\'i — is exactly 2 counts. When a Madd letter is followed by a Hamza or a Sukoon, the count increases to 4 or 6 depending on the rule type. Shortening a Madd can alter the meaning of a word entirely, so precision is essential.';

  @override
  String get tajweedRuleMaddExample1Reference => 'Al-Baqarah 2:30';

  @override
  String get tajweedRuleMaddExample1Transliteration => 'qaa-la';

  @override
  String get tajweedRuleMaddExample1Explanation =>
      'The Alif after Qaaf is a Madd Tabi\'i letter — the vowel is held for exactly 2 counts before moving to Lam.';

  @override
  String get tajweedRuleMaddExample2Reference => 'Al-Baqarah 2:8';

  @override
  String get tajweedRuleMaddExample2Transliteration => 'ya-qoo-lu';

  @override
  String get tajweedRuleMaddExample2Explanation =>
      'The Waw after Qaaf carries a Madd Tabi\'i — the \'oo\' sound is held for 2 counts before completing the word.';

  @override
  String get tajweedRuleGhunnahLongDescription =>
      'Ghunnah (الغُنّة) is a nasal resonance produced through the nasal passage — not the mouth. It occurs whenever Noon (ن) or Meem (م) carries a Shaddah (تشديد), indicating a doubled letter. The duration of Ghunnah is 2 counts. Beyond these standalone cases, Ghunnah also accompanies the rules of Idgham (with Ghunnah), Ikhfa, and Iqlab, giving Quranic recitation its characteristic nasal melody.';

  @override
  String get tajweedRuleGhunnahExample1Reference => 'Al-Baqarah 2:6';

  @override
  String get tajweedRuleGhunnahExample1Transliteration => 'in-na';

  @override
  String get tajweedRuleGhunnahExample1Explanation =>
      'Noon with Shaddah (إِنَّ) produces a 2-count nasal resonance — the sound comes entirely from the nose, not the mouth.';

  @override
  String get tajweedRuleGhunnahExample2Reference => 'Al-Baqarah 2:28';

  @override
  String get tajweedRuleGhunnahExample2Transliteration => 'thum-ma';

  @override
  String get tajweedRuleGhunnahExample2Explanation =>
      'Meem with Shaddah (ثُمَّ) produces a 2-count Ghunnah — the lips stay together while the nasal resonance is held.';

  @override
  String get tajweedRuleIdghamLongDescription =>
      'Idgham (الإدغام) means \'to merge\'. When Noon Sakinah (نْ) or Tanween is followed by one of the letters ي ن م و ل ر, the noon is absorbed into that letter and both are pronounced as one. There are two types — With Ghunnah: if the following letter is ي ن م و, skip the noon but apply a 2-count nasal resonance with the merged letter. Without Ghunnah: if the following letter is ل or ر, skip the noon entirely and pronounce the next letter cleanly with no nasalization.';

  @override
  String get tajweedRuleIdghamExample1Reference => 'Al-Zalzalah 99:7';

  @override
  String get tajweedRuleIdghamExample1Transliteration => 'man ya\'-mal';

  @override
  String get tajweedRuleIdghamExample1Explanation =>
      'With Ghunnah — the Noon Sakinah in \'man\' (مَن) merges into Yaa (يَعْمَلْ) with a 2-count Ghunnah. The noon disappears and only the Ghunnah + Yaa remain.';

  @override
  String get tajweedRuleIdghamExample2Reference => 'Al-Baqarah 2:5';

  @override
  String get tajweedRuleIdghamExample2Transliteration => 'mir-rab-bi-him';

  @override
  String get tajweedRuleIdghamExample2Explanation =>
      'Without Ghunnah — the Noon Sakinah of \'min\' (مِن) merges into Raa (رَّبِّهِمْ) cleanly, with no nasal sound at all. The transition is immediate and silent.';

  @override
  String get tajweedRuleIdghamShafawyTitle =>
      'Idgham Shafawi (الإدغام الشفوي) — Labial Merging';

  @override
  String get tajweedRuleIdghamShafawyDescription =>
      'Merging Meem Sakinah (مْ) into a following Meem (م) with a 2-count Ghunnah.';

  @override
  String get tajweedRuleIdghamShafawyLongDescription =>
      'Idgham Shafawi (الإدغام الشفوي) is a sub-rule of Idgham that concerns Meem Sakinah (مْ), not Noon Sakinah. When Meem Sakinah is immediately followed by another Meem (م), the two Meems merge into one doubled Meem accompanied by a 2-count Ghunnah. The lips come together and the nasal resonance is held before releasing. It is called Shafawi (labial) because it is produced at the lips. This rule applies regardless of where the Meems appear — across words or within a word.';

  @override
  String get tajweedRuleIdghamShafawyExample1Reference => 'Az-Zukhruf 43:77';

  @override
  String get tajweedRuleIdghamShafawyExample1Transliteration =>
      'an-tum maa-ki-thoon';

  @override
  String get tajweedRuleIdghamShafawyExample1Explanation =>
      'Meem Sakinah at the end of \'antum\' (أَنتُم) merges into the Meem of \'maakithoon\' (مَّاكِثُونَ) with Ghunnah. Both Meems become one doubled sound held for 2 counts.';

  @override
  String get tajweedRuleIkhfaLongDescription =>
      'Ikhfa (الإخفاء) means \'to conceal\'. When Noon Sakinah (نْ) or Tanween is followed by any of 15 specific letters (ت ث ج د ذ س ش ص ض ط ظ ف ق ك), the noon sound is neither fully pronounced nor fully merged — it is hidden as a nasal resonance while the mouth moves toward the next letter. Always accompanied by a 2-count Ghunnah, Ikhfa is a middle state between the clarity of Izhar and the full merge of Idgham. Ikhfa Shafawi is a related rule that applies when Meem Sakinah (مْ) meets Ba (ب).';

  @override
  String get tajweedRuleIkhfaExample1Reference => 'An-Nas 114:4';

  @override
  String get tajweedRuleIkhfaExample1Transliteration => 'min shar-ri';

  @override
  String get tajweedRuleIkhfaExample1Explanation =>
      'Noon Sakinah is concealed before Sheen. The sound is between a full noon and its disappearance — a nasal resonance held for 2 counts before transitioning to Sheen.';

  @override
  String get tajweedRuleIkhfaExample2Reference => 'Al-Imran 3:101';

  @override
  String get tajweedRuleIkhfaExample2Transliteration =>
      'ya\'-ta-sim bil-laa-hi';

  @override
  String get tajweedRuleIkhfaExample2Explanation =>
      'Ikhfa Shafawi: Meem Sakinah (يَعْتَصِم) is concealed before Ba (بِاللَّهِ). The lips almost close as if saying Meem, a 2-count Ghunnah is held, then Ba is pronounced.';

  @override
  String get tajweedRuleIqlabLongDescription =>
      'Iqlab (الإقلاب) means \'to convert\' or \'to flip\'. When Noon Sakinah (نْ) or Tanween is immediately followed by Ba (ب), the noon is converted into a concealed Meem (م). The lips come together as if pronouncing Meem, a 2-count Ghunnah is applied through the nose, and then Ba is pronounced. Ba is the only letter that triggers this rule, making Iqlab straightforward to identify. In the Mushaf, a small \'م\' above the noon or tanween marks this rule.';

  @override
  String get tajweedRuleIqlabExample1Reference => 'Al-Baqarah 2:27';

  @override
  String get tajweedRuleIqlabExample1Transliteration => 'mim ba\'-di';

  @override
  String get tajweedRuleIqlabExample1Explanation =>
      'Noon Sakinah converts to a concealed Meem before Ba. The lips come together for a 2-count Ghunnah, then Ba is pronounced — the noon is never heard.';

  @override
  String get tajweedRuleQalqalaLongDescription =>
      'Qalqala (القلقلة) means \'to vibrate\' or \'to echo\'. When any of the five Qalqala letters — ق، ط، ب، ج، د — has a Sukoon (no vowel), a slight bouncing or echoing sound is added at the end of the letter\'s pronunciation. In the middle of a word (Qalqala Sughra), the echo is subtle to maintain flow. At the end of a verse when pausing (Qalqala Kubra), the echo is strong and deliberate. When the Qalqala letter also has a Shaddah, the echo is the strongest (Qalqala Akbar).';

  @override
  String get tajweedRuleQalqalaExample1Reference => 'Al-Baqarah 2:10';

  @override
  String get tajweedRuleQalqalaExample1Transliteration => 'yaj-\'a-loon';

  @override
  String get tajweedRuleQalqalaExample1Explanation =>
      'Jeem with Sukoon in the middle of the word produces a subtle Qalqala (Sughra) — a brief echo before moving to the next letter.';

  @override
  String get tajweedRuleQalqalaExample2Reference => 'Al-Ikhlas 112:3';

  @override
  String get tajweedRuleQalqalaExample2Transliteration => 'wa-lam yu-lad';

  @override
  String get tajweedRuleQalqalaExample2Explanation =>
      'Dal with Sukoon at the end of the verse produces a strong Qalqala (Kubra) when pausing — the echo is clear and deliberate.';

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

  @override
  String get audioPlayAyah => 'Play this ayah';

  @override
  String get audioPlayPage => 'Play this page';

  @override
  String get audioPlaySurah => 'Play this surah';

  @override
  String get audioDownloadTitle => 'Download audio';

  @override
  String get audioDownloadMessage =>
      'Download surah audio for offline playback?';

  @override
  String get audioDownloadConfirm => 'Download';

  @override
  String get audioDownloadCancel => 'Cancel';

  @override
  String get audioDownloading => 'Downloading audio...';

  @override
  String get audioNoInternet => 'No internet connection';

  @override
  String get cheikhPickerTitle => 'Choose reciter';

  @override
  String get settingsReciterSection => 'Reciter';

  @override
  String get homeRecitationTest => 'Recitation Test';

  @override
  String get homeStartRecitationTest => 'Start recitation';

  @override
  String get recitationTestTitle => 'Recitation Test';

  @override
  String get recitationInstruction =>
      'Recite the surah aloud — each word turns green when correct.';

  @override
  String get recitationListening => 'Listening...';

  @override
  String get recitationStart => 'Start';

  @override
  String get recitationStop => 'Stop';

  @override
  String get recitationTryAgain => 'Try Again';

  @override
  String get recitationMicDenied =>
      'Microphone permission denied. Enable it in settings to record.';

  @override
  String get recitationConnectionError => 'Connection lost. Please try again.';
}
