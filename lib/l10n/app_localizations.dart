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

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

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

  /// No description provided for @comingSoonMessage.
  ///
  /// In en, this message translates to:
  /// **'This feature is coming soon. Stay tuned!'**
  String get comingSoonMessage;

  /// No description provided for @settingsAccountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccountSection;

  /// No description provided for @settingsGuestLabel.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get settingsGuestLabel;

  /// No description provided for @settingsGuestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap to manage your account'**
  String get settingsGuestSubtitle;

  /// No description provided for @settingsComingSoonSection.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get settingsComingSoonSection;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsDailyReminders.
  ///
  /// In en, this message translates to:
  /// **'Daily reminders'**
  String get settingsDailyReminders;

  /// No description provided for @settingsAboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutSection;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get settingsTermsOfUse;

  /// No description provided for @termsOfUseTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUseTitle;

  /// No description provided for @termsOfUseBody.
  ///
  /// In en, this message translates to:
  /// **'These Terms of Use govern your use of Tajweed AI. By using the app you agree to these terms.\n\nTajweed AI is provided as-is for educational and personal use to help you read and reflect on the Quran with correct Tajweed. We do our best to ensure the Quran text and Tajweed indications displayed are accurate, but we make no warranty of completeness.\n\nWe respect your privacy: no personal data is collected without your consent. Reading progress and settings are stored locally on your device.\n\nThe full Terms of Use will be published with future releases. For questions, please contact us through the app store listing.'**
  String get termsOfUseBody;

  /// No description provided for @myAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccountTitle;

  /// No description provided for @myAccountYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Your account'**
  String get myAccountYourAccount;

  /// No description provided for @myAccountComingSoonSection.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get myAccountComingSoonSection;

  /// No description provided for @myAccountChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get myAccountChangePassword;

  /// No description provided for @myAccountAvatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get myAccountAvatar;

  /// No description provided for @myAccountLinkedAccounts.
  ///
  /// In en, this message translates to:
  /// **'Linked accounts'**
  String get myAccountLinkedAccounts;

  /// No description provided for @myAccountSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get myAccountSignOut;

  /// No description provided for @myAccountSignOutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get myAccountSignOutConfirmTitle;

  /// No description provided for @myAccountSignOutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ll need to sign in again to access your account.'**
  String get myAccountSignOutConfirmMessage;

  /// No description provided for @myAccountSignOutCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get myAccountSignOutCancel;

  /// No description provided for @tajweedCoursesTitle.
  ///
  /// In en, this message translates to:
  /// **'Tajweed Rules'**
  String get tajweedCoursesTitle;

  /// No description provided for @tajweedCoursesIntro.
  ///
  /// In en, this message translates to:
  /// **'Tajweed (تجويد) is the set of rules that govern correct pronunciation of the Quran. Below are the core rules every reciter should know.'**
  String get tajweedCoursesIntro;

  /// No description provided for @tajweedCoursesInteractive.
  ///
  /// In en, this message translates to:
  /// **'Interactive lessons'**
  String get tajweedCoursesInteractive;

  /// No description provided for @tajweedRuleMaddTitle.
  ///
  /// In en, this message translates to:
  /// **'Madd (المدّ) — Elongation'**
  String get tajweedRuleMaddTitle;

  /// No description provided for @tajweedRuleMaddDescription.
  ///
  /// In en, this message translates to:
  /// **'Prolonging a vowel sound by 2, 4, or 6 counts depending on the type. Madd Tabi\'i is the natural elongation of 2 counts.'**
  String get tajweedRuleMaddDescription;

  /// No description provided for @tajweedRuleGhunnahTitle.
  ///
  /// In en, this message translates to:
  /// **'Ghunnah (الغُنّة) — Nasalization'**
  String get tajweedRuleGhunnahTitle;

  /// No description provided for @tajweedRuleGhunnahDescription.
  ///
  /// In en, this message translates to:
  /// **'A nasal sound produced when pronouncing letters Noon (ن) or Meem (م) with shaddah, held for about 2 counts.'**
  String get tajweedRuleGhunnahDescription;

  /// No description provided for @tajweedRuleIdghamTitle.
  ///
  /// In en, this message translates to:
  /// **'Idgham (الإدغام) — Merging'**
  String get tajweedRuleIdghamTitle;

  /// No description provided for @tajweedRuleIdghamDescription.
  ///
  /// In en, this message translates to:
  /// **'Merging a Noon Sakinah or Tanween into one of the letters: ي، ر، م، ل، و، ن. The merging may include Ghunnah depending on the letter.'**
  String get tajweedRuleIdghamDescription;

  /// No description provided for @tajweedRuleIkhfaTitle.
  ///
  /// In en, this message translates to:
  /// **'Ikhfa (الإخفاء) — Concealment'**
  String get tajweedRuleIkhfaTitle;

  /// No description provided for @tajweedRuleIkhfaDescription.
  ///
  /// In en, this message translates to:
  /// **'Hiding the sound of Noon Sakinah or Tanween between Idgham and Izhar when followed by any of 15 specific letters, with Ghunnah.'**
  String get tajweedRuleIkhfaDescription;

  /// No description provided for @tajweedRuleIqlabTitle.
  ///
  /// In en, this message translates to:
  /// **'Iqlab (الإقلاب) — Conversion'**
  String get tajweedRuleIqlabTitle;

  /// No description provided for @tajweedRuleIqlabDescription.
  ///
  /// In en, this message translates to:
  /// **'Converting a Noon Sakinah or Tanween into a hidden Meem when followed by the letter Ba (ب), with Ghunnah.'**
  String get tajweedRuleIqlabDescription;

  /// No description provided for @tajweedRuleQalqalaTitle.
  ///
  /// In en, this message translates to:
  /// **'Qalqala (القلقلة) — Echoing'**
  String get tajweedRuleQalqalaTitle;

  /// No description provided for @tajweedRuleQalqalaDescription.
  ///
  /// In en, this message translates to:
  /// **'A bouncing echo sound on the letters: ق، ط، ب، ج، د when they have a sukoon. Stronger at the end of a verse.'**
  String get tajweedRuleQalqalaDescription;

  /// No description provided for @tajweedRuleExamplesSection.
  ///
  /// In en, this message translates to:
  /// **'Examples'**
  String get tajweedRuleExamplesSection;

  /// No description provided for @tajweedRuleMaddLongDescription.
  ///
  /// In en, this message translates to:
  /// **'Madd (المدّ) is the elongation of a vowel sound carried by one of the three Madd letters: Alif (ا), Waw (و), or Yaa (ي). The baseline elongation — Madd Tabi\'i — is exactly 2 counts. When a Madd letter is followed by a Hamza or a Sukoon, the count increases to 4 or 6 depending on the rule type. Shortening a Madd can alter the meaning of a word entirely, so precision is essential.'**
  String get tajweedRuleMaddLongDescription;

  /// No description provided for @tajweedRuleMaddExample1Reference.
  ///
  /// In en, this message translates to:
  /// **'Al-Baqarah 2:30'**
  String get tajweedRuleMaddExample1Reference;

  /// No description provided for @tajweedRuleMaddExample1Transliteration.
  ///
  /// In en, this message translates to:
  /// **'qaa-la'**
  String get tajweedRuleMaddExample1Transliteration;

  /// No description provided for @tajweedRuleMaddExample1Explanation.
  ///
  /// In en, this message translates to:
  /// **'The Alif after Qaaf is a Madd Tabi\'i letter — the vowel is held for exactly 2 counts before moving to Lam.'**
  String get tajweedRuleMaddExample1Explanation;

  /// No description provided for @tajweedRuleMaddExample2Reference.
  ///
  /// In en, this message translates to:
  /// **'Al-Baqarah 2:8'**
  String get tajweedRuleMaddExample2Reference;

  /// No description provided for @tajweedRuleMaddExample2Transliteration.
  ///
  /// In en, this message translates to:
  /// **'ya-qoo-lu'**
  String get tajweedRuleMaddExample2Transliteration;

  /// No description provided for @tajweedRuleMaddExample2Explanation.
  ///
  /// In en, this message translates to:
  /// **'The Waw after Qaaf carries a Madd Tabi\'i — the \'oo\' sound is held for 2 counts before completing the word.'**
  String get tajweedRuleMaddExample2Explanation;

  /// No description provided for @tajweedRuleGhunnahLongDescription.
  ///
  /// In en, this message translates to:
  /// **'Ghunnah (الغُنّة) is a nasal resonance produced through the nasal passage — not the mouth. It occurs whenever Noon (ن) or Meem (م) carries a Shaddah (تشديد), indicating a doubled letter. The duration of Ghunnah is 2 counts. Beyond these standalone cases, Ghunnah also accompanies the rules of Idgham (with Ghunnah), Ikhfa, and Iqlab, giving Quranic recitation its characteristic nasal melody.'**
  String get tajweedRuleGhunnahLongDescription;

  /// No description provided for @tajweedRuleGhunnahExample1Reference.
  ///
  /// In en, this message translates to:
  /// **'Al-Baqarah 2:6'**
  String get tajweedRuleGhunnahExample1Reference;

  /// No description provided for @tajweedRuleGhunnahExample1Transliteration.
  ///
  /// In en, this message translates to:
  /// **'in-na'**
  String get tajweedRuleGhunnahExample1Transliteration;

  /// No description provided for @tajweedRuleGhunnahExample1Explanation.
  ///
  /// In en, this message translates to:
  /// **'Noon with Shaddah (إِنَّ) produces a 2-count nasal resonance — the sound comes entirely from the nose, not the mouth.'**
  String get tajweedRuleGhunnahExample1Explanation;

  /// No description provided for @tajweedRuleGhunnahExample2Reference.
  ///
  /// In en, this message translates to:
  /// **'Al-Baqarah 2:28'**
  String get tajweedRuleGhunnahExample2Reference;

  /// No description provided for @tajweedRuleGhunnahExample2Transliteration.
  ///
  /// In en, this message translates to:
  /// **'thum-ma'**
  String get tajweedRuleGhunnahExample2Transliteration;

  /// No description provided for @tajweedRuleGhunnahExample2Explanation.
  ///
  /// In en, this message translates to:
  /// **'Meem with Shaddah (ثُمَّ) produces a 2-count Ghunnah — the lips stay together while the nasal resonance is held.'**
  String get tajweedRuleGhunnahExample2Explanation;

  /// No description provided for @tajweedRuleIdghamLongDescription.
  ///
  /// In en, this message translates to:
  /// **'Idgham (الإدغام) means \'to merge\'. When Noon Sakinah (نْ) or Tanween is followed by one of the letters ي ن م و ل ر, the noon is absorbed into that letter and both are pronounced as one. There are two types — With Ghunnah: if the following letter is ي ن م و, skip the noon but apply a 2-count nasal resonance with the merged letter. Without Ghunnah: if the following letter is ل or ر, skip the noon entirely and pronounce the next letter cleanly with no nasalization.'**
  String get tajweedRuleIdghamLongDescription;

  /// No description provided for @tajweedRuleIdghamExample1Reference.
  ///
  /// In en, this message translates to:
  /// **'Al-Zalzalah 99:7'**
  String get tajweedRuleIdghamExample1Reference;

  /// No description provided for @tajweedRuleIdghamExample1Transliteration.
  ///
  /// In en, this message translates to:
  /// **'man ya\'-mal'**
  String get tajweedRuleIdghamExample1Transliteration;

  /// No description provided for @tajweedRuleIdghamExample1Explanation.
  ///
  /// In en, this message translates to:
  /// **'With Ghunnah — the Noon Sakinah in \'man\' (مَن) merges into Yaa (يَعْمَلْ) with a 2-count Ghunnah. The noon disappears and only the Ghunnah + Yaa remain.'**
  String get tajweedRuleIdghamExample1Explanation;

  /// No description provided for @tajweedRuleIdghamExample2Reference.
  ///
  /// In en, this message translates to:
  /// **'Al-Baqarah 2:5'**
  String get tajweedRuleIdghamExample2Reference;

  /// No description provided for @tajweedRuleIdghamExample2Transliteration.
  ///
  /// In en, this message translates to:
  /// **'mir-rab-bi-him'**
  String get tajweedRuleIdghamExample2Transliteration;

  /// No description provided for @tajweedRuleIdghamExample2Explanation.
  ///
  /// In en, this message translates to:
  /// **'Without Ghunnah — the Noon Sakinah of \'min\' (مِن) merges into Raa (رَّبِّهِمْ) cleanly, with no nasal sound at all. The transition is immediate and silent.'**
  String get tajweedRuleIdghamExample2Explanation;

  /// No description provided for @tajweedRuleIdghamShafawyTitle.
  ///
  /// In en, this message translates to:
  /// **'Idgham Shafawi (الإدغام الشفوي) — Labial Merging'**
  String get tajweedRuleIdghamShafawyTitle;

  /// No description provided for @tajweedRuleIdghamShafawyDescription.
  ///
  /// In en, this message translates to:
  /// **'Merging Meem Sakinah (مْ) into a following Meem (م) with a 2-count Ghunnah.'**
  String get tajweedRuleIdghamShafawyDescription;

  /// No description provided for @tajweedRuleIdghamShafawyLongDescription.
  ///
  /// In en, this message translates to:
  /// **'Idgham Shafawi (الإدغام الشفوي) is a sub-rule of Idgham that concerns Meem Sakinah (مْ), not Noon Sakinah. When Meem Sakinah is immediately followed by another Meem (م), the two Meems merge into one doubled Meem accompanied by a 2-count Ghunnah. The lips come together and the nasal resonance is held before releasing. It is called Shafawi (labial) because it is produced at the lips. This rule applies regardless of where the Meems appear — across words or within a word.'**
  String get tajweedRuleIdghamShafawyLongDescription;

  /// No description provided for @tajweedRuleIdghamShafawyExample1Reference.
  ///
  /// In en, this message translates to:
  /// **'Az-Zukhruf 43:77'**
  String get tajweedRuleIdghamShafawyExample1Reference;

  /// No description provided for @tajweedRuleIdghamShafawyExample1Transliteration.
  ///
  /// In en, this message translates to:
  /// **'an-tum maa-ki-thoon'**
  String get tajweedRuleIdghamShafawyExample1Transliteration;

  /// No description provided for @tajweedRuleIdghamShafawyExample1Explanation.
  ///
  /// In en, this message translates to:
  /// **'Meem Sakinah at the end of \'antum\' (أَنتُم) merges into the Meem of \'maakithoon\' (مَّاكِثُونَ) with Ghunnah. Both Meems become one doubled sound held for 2 counts.'**
  String get tajweedRuleIdghamShafawyExample1Explanation;

  /// No description provided for @tajweedRuleIkhfaLongDescription.
  ///
  /// In en, this message translates to:
  /// **'Ikhfa (الإخفاء) means \'to conceal\'. When Noon Sakinah (نْ) or Tanween is followed by any of 15 specific letters (ت ث ج د ذ س ش ص ض ط ظ ف ق ك), the noon sound is neither fully pronounced nor fully merged — it is hidden as a nasal resonance while the mouth moves toward the next letter. Always accompanied by a 2-count Ghunnah, Ikhfa is a middle state between the clarity of Izhar and the full merge of Idgham. Ikhfa Shafawi is a related rule that applies when Meem Sakinah (مْ) meets Ba (ب).'**
  String get tajweedRuleIkhfaLongDescription;

  /// No description provided for @tajweedRuleIkhfaExample1Reference.
  ///
  /// In en, this message translates to:
  /// **'An-Nas 114:4'**
  String get tajweedRuleIkhfaExample1Reference;

  /// No description provided for @tajweedRuleIkhfaExample1Transliteration.
  ///
  /// In en, this message translates to:
  /// **'min shar-ri'**
  String get tajweedRuleIkhfaExample1Transliteration;

  /// No description provided for @tajweedRuleIkhfaExample1Explanation.
  ///
  /// In en, this message translates to:
  /// **'Noon Sakinah is concealed before Sheen. The sound is between a full noon and its disappearance — a nasal resonance held for 2 counts before transitioning to Sheen.'**
  String get tajweedRuleIkhfaExample1Explanation;

  /// No description provided for @tajweedRuleIkhfaExample2Reference.
  ///
  /// In en, this message translates to:
  /// **'Al-Imran 3:101'**
  String get tajweedRuleIkhfaExample2Reference;

  /// No description provided for @tajweedRuleIkhfaExample2Transliteration.
  ///
  /// In en, this message translates to:
  /// **'ya\'-ta-sim bil-laa-hi'**
  String get tajweedRuleIkhfaExample2Transliteration;

  /// No description provided for @tajweedRuleIkhfaExample2Explanation.
  ///
  /// In en, this message translates to:
  /// **'Ikhfa Shafawi: Meem Sakinah (يَعْتَصِم) is concealed before Ba (بِاللَّهِ). The lips almost close as if saying Meem, a 2-count Ghunnah is held, then Ba is pronounced.'**
  String get tajweedRuleIkhfaExample2Explanation;

  /// No description provided for @tajweedRuleIqlabLongDescription.
  ///
  /// In en, this message translates to:
  /// **'Iqlab (الإقلاب) means \'to convert\' or \'to flip\'. When Noon Sakinah (نْ) or Tanween is immediately followed by Ba (ب), the noon is converted into a concealed Meem (م). The lips come together as if pronouncing Meem, a 2-count Ghunnah is applied through the nose, and then Ba is pronounced. Ba is the only letter that triggers this rule, making Iqlab straightforward to identify. In the Mushaf, a small \'م\' above the noon or tanween marks this rule.'**
  String get tajweedRuleIqlabLongDescription;

  /// No description provided for @tajweedRuleIqlabExample1Reference.
  ///
  /// In en, this message translates to:
  /// **'Al-Baqarah 2:27'**
  String get tajweedRuleIqlabExample1Reference;

  /// No description provided for @tajweedRuleIqlabExample1Transliteration.
  ///
  /// In en, this message translates to:
  /// **'mim ba\'-di'**
  String get tajweedRuleIqlabExample1Transliteration;

  /// No description provided for @tajweedRuleIqlabExample1Explanation.
  ///
  /// In en, this message translates to:
  /// **'Noon Sakinah converts to a concealed Meem before Ba. The lips come together for a 2-count Ghunnah, then Ba is pronounced — the noon is never heard.'**
  String get tajweedRuleIqlabExample1Explanation;

  /// No description provided for @tajweedRuleQalqalaLongDescription.
  ///
  /// In en, this message translates to:
  /// **'Qalqala (القلقلة) means \'to vibrate\' or \'to echo\'. When any of the five Qalqala letters — ق، ط، ب، ج، د — has a Sukoon (no vowel), a slight bouncing or echoing sound is added at the end of the letter\'s pronunciation. In the middle of a word (Qalqala Sughra), the echo is subtle to maintain flow. At the end of a verse when pausing (Qalqala Kubra), the echo is strong and deliberate. When the Qalqala letter also has a Shaddah, the echo is the strongest (Qalqala Akbar).'**
  String get tajweedRuleQalqalaLongDescription;

  /// No description provided for @tajweedRuleQalqalaExample1Reference.
  ///
  /// In en, this message translates to:
  /// **'Al-Baqarah 2:10'**
  String get tajweedRuleQalqalaExample1Reference;

  /// No description provided for @tajweedRuleQalqalaExample1Transliteration.
  ///
  /// In en, this message translates to:
  /// **'yaj-\'a-loon'**
  String get tajweedRuleQalqalaExample1Transliteration;

  /// No description provided for @tajweedRuleQalqalaExample1Explanation.
  ///
  /// In en, this message translates to:
  /// **'Jeem with Sukoon in the middle of the word produces a subtle Qalqala (Sughra) — a brief echo before moving to the next letter.'**
  String get tajweedRuleQalqalaExample1Explanation;

  /// No description provided for @tajweedRuleQalqalaExample2Reference.
  ///
  /// In en, this message translates to:
  /// **'Al-Ikhlas 112:3'**
  String get tajweedRuleQalqalaExample2Reference;

  /// No description provided for @tajweedRuleQalqalaExample2Transliteration.
  ///
  /// In en, this message translates to:
  /// **'wa-lam yu-lad'**
  String get tajweedRuleQalqalaExample2Transliteration;

  /// No description provided for @tajweedRuleQalqalaExample2Explanation.
  ///
  /// In en, this message translates to:
  /// **'Dal with Sukoon at the end of the verse produces a strong Qalqala (Kubra) when pausing — the echo is clear and deliberate.'**
  String get tajweedRuleQalqalaExample2Explanation;

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

  /// No description provided for @audioPlayAyah.
  ///
  /// In en, this message translates to:
  /// **'Play this ayah'**
  String get audioPlayAyah;

  /// No description provided for @audioPlayPage.
  ///
  /// In en, this message translates to:
  /// **'Play this page'**
  String get audioPlayPage;

  /// No description provided for @audioPlaySurah.
  ///
  /// In en, this message translates to:
  /// **'Play this surah'**
  String get audioPlaySurah;

  /// No description provided for @audioDownloadTitle.
  ///
  /// In en, this message translates to:
  /// **'Download audio'**
  String get audioDownloadTitle;

  /// No description provided for @audioDownloadMessage.
  ///
  /// In en, this message translates to:
  /// **'Download surah audio for offline playback?'**
  String get audioDownloadMessage;

  /// No description provided for @audioDownloadConfirm.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get audioDownloadConfirm;

  /// No description provided for @audioDownloadCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get audioDownloadCancel;

  /// No description provided for @audioDownloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading audio...'**
  String get audioDownloading;

  /// No description provided for @audioNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get audioNoInternet;

  /// No description provided for @cheikhPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose reciter'**
  String get cheikhPickerTitle;

  /// No description provided for @settingsReciterSection.
  ///
  /// In en, this message translates to:
  /// **'Reciter'**
  String get settingsReciterSection;
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
