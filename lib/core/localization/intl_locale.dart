const supportedIntlLanguageCodes = {'ar', 'en'};

String intlLocale(String languageCode) {
  if (supportedIntlLanguageCodes.contains(languageCode)) return languageCode;
  return 'en';
}
