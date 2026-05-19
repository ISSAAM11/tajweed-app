enum AppLanguage {
  english('en', 'English'),
  arabic('ar', 'العربية');

  final String code;
  final String nativeLabel;

  const AppLanguage(this.code, this.nativeLabel);

  static AppLanguage fromCode(String? code) => switch (code) {
    'ar' => AppLanguage.arabic,
    _ => AppLanguage.english,
  };
}
