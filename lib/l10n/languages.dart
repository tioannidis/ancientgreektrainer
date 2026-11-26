class AppLanguage {
  final String code;
  final String nativeName;

  const AppLanguage(this.code, this.nativeName);
}

const String systemLanguageCode = 'system';

const List<AppLanguage> supportedAppLanguages = [
  AppLanguage('de', 'Deutsch'),
  AppLanguage('en', 'English'),
];

bool isSupportedAppLanguage(String code) =>
    supportedAppLanguages.any((language) => language.code == code);

String normalizeLanguageSetting(String? code) {
  if (code == null || code == systemLanguageCode) return systemLanguageCode;
  return isSupportedAppLanguage(code) ? code : systemLanguageCode;
}
