enum AppThemeMode {
  light('light'),
  dark('dark');

  final String code;

  const AppThemeMode(this.code);

  static AppThemeMode fromCode(String? code) => switch (code) {
    'dark' => AppThemeMode.dark,
    _ => AppThemeMode.light,
  };
}
