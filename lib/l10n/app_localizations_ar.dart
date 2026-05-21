// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get lastReadingLabel => 'آخر قراءة';

  @override
  String get verseNumberLabel => 'الآية رقم';

  @override
  String get continueReadingLabel => 'أكمل القراءة';

  @override
  String get homeSectionTitle => 'الرئيسية';

  @override
  String get homeTajweedLessons => 'دروس تجويد';

  @override
  String get homeLevelOne => 'المستوى 1';

  @override
  String get homeQuranRecitation => 'تلاوة القرآن';

  @override
  String get homeStartRecitation => 'ابدأ التلاوة';

  @override
  String get homeTajweedTest => 'إختبار التجويد';

  @override
  String get homeStartTest => 'ابدأ الإختبار';

  @override
  String get homeQuranReflection => 'تدبر القرآن';

  @override
  String get homeStartReflection => 'أتدبر القرآن';

  @override
  String get comingSoon => 'قريباً';

  @override
  String get comingSoonMessage => 'هذه الميزة قادمة قريباً. ترقّب!';

  @override
  String get settingsAccountSection => 'الحساب';

  @override
  String get settingsGuestLabel => 'ضيف';

  @override
  String get settingsGuestSubtitle => 'اضغط لإدارة حسابك';

  @override
  String get settingsComingSoonSection => 'قريباً';

  @override
  String get settingsNotifications => 'الإشعارات';

  @override
  String get settingsDailyReminders => 'تذكيرات يومية';

  @override
  String get settingsAboutSection => 'حول';

  @override
  String get settingsVersion => 'الإصدار';

  @override
  String get settingsTermsOfUse => 'شروط الاستخدام';

  @override
  String get termsOfUseTitle => 'شروط الاستخدام';

  @override
  String get termsOfUseBody =>
      'تحكم شروط الاستخدام هذه استخدامك لتطبيق تجويد AI. باستخدامك التطبيق فإنك توافق على هذه الشروط.\n\nيُقدَّم تطبيق تجويد AI كما هو لأغراض تعليمية وشخصية لمساعدتك على قراءة القرآن والتدبر فيه بتجويد سليم. نبذل قصارى جهدنا لضمان دقة نص القرآن وعلامات التجويد المعروضة، دون ضمان الكمال.\n\nنحن نحترم خصوصيتك: لا يتم جمع أي بيانات شخصية دون موافقتك. يتم تخزين تقدّمك في القراءة وإعداداتك محلياً على جهازك.\n\nسيتم نشر شروط الاستخدام الكاملة مع الإصدارات المستقبلية. للأسئلة، يرجى التواصل من خلال صفحة التطبيق في المتجر.';

  @override
  String get myAccountTitle => 'حسابي';

  @override
  String get myAccountYourAccount => 'حسابك';

  @override
  String get myAccountComingSoonSection => 'قريباً';

  @override
  String get myAccountChangePassword => 'تغيير كلمة المرور';

  @override
  String get myAccountAvatar => 'الصورة الرمزية';

  @override
  String get myAccountLinkedAccounts => 'الحسابات المرتبطة';

  @override
  String get myAccountSignOut => 'تسجيل الخروج';

  @override
  String get myAccountSignOutConfirmTitle => 'تسجيل الخروج؟';

  @override
  String get myAccountSignOutConfirmMessage =>
      'ستحتاج إلى تسجيل الدخول مرة أخرى للوصول إلى حسابك.';

  @override
  String get myAccountSignOutCancel => 'إلغاء';

  @override
  String get snackbarRetry => 'إعادة المحاولة';

  @override
  String get snackbarOk => 'حسناً';

  @override
  String get signedInSuccess => 'تم تسجيل الدخول بنجاح';

  @override
  String get partitionSurah => 'سورة';

  @override
  String get partitionJuz => 'جزء';

  @override
  String get partitionPage => 'صفحة';

  @override
  String get partitionHizb => 'حزب';

  @override
  String get partitionRuku => 'ركوع';

  @override
  String get revelationMakkah => 'مكية';

  @override
  String get revelationMadinah => 'مدنية';

  @override
  String versesCount(int count) {
    return '$count آية';
  }

  @override
  String get errorPrefix => 'خطأ';

  @override
  String get authTagline => 'أتقن تلاوة القرآن بإرشاد الذكاء الاصطناعي.';

  @override
  String get authSignIn => 'تسجيل الدخول';

  @override
  String get authSignUp => 'إنشاء حساب';

  @override
  String get authEmail => 'البريد الإلكتروني';

  @override
  String get authEmailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get authPassword => 'كلمة المرور';

  @override
  String get authPasswordHint => 'أدخل كلمة المرور';

  @override
  String get authConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get authForgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get authFirstName => 'الاسم';

  @override
  String get authLastName => 'اللقب';

  @override
  String get authSelectGender => 'اختر جنسك:';

  @override
  String get authGenderMale => 'ذكر';

  @override
  String get authGenderFemale => 'أنثى';

  @override
  String get authNoAccountQuestion => 'ليس لديك حساب؟ ';

  @override
  String get authCreateOne => 'أنشئ حساباً';

  @override
  String get authHaveAccountQuestion => 'لديك حساب بالفعل؟ ';

  @override
  String get authSignInLink => 'سجل دخولك';

  @override
  String get authOrContinueAs => 'أو أكمل كـ';

  @override
  String get authGuest => 'زائر';

  @override
  String get authPrevious => 'السابق';

  @override
  String get authNext => 'التالي';

  @override
  String get authActivate => 'تفعيل';

  @override
  String get authCheckInbox => 'تحقق من بريدك 📩';

  @override
  String get authVerificationMessage =>
      'أرسلنا لك رمز تحقق مكوناً من 4 أرقام إلى بريدك الإلكتروني. الرجاء إدخاله أدناه للمتابعة.';

  @override
  String get authResendCode => 'إعادة إرسال الرمز';

  @override
  String get authTermsOfUseTitle => 'شروط الاستخدام';

  @override
  String get authTermsOfUseBody =>
      'باستخدامك لهذا التطبيق، فإنك توافق على شروط الاستخدام التالية:\n\n1. سوف تستخدم التطبيق بمسؤولية.\n2. لن تسيء استخدام ميزاته أو تستغلها.\n3. قد يجمع التطبيق بيانات وفقاً لسياسة الخصوصية الخاصة بنا.\n4. قد نقوم بتحديث الشروط في أي وقت.\n\nيُرجى القراءة بعناية قبل المتابعة.';

  @override
  String get authIAgreeToThe => 'أوافق على ';
}
