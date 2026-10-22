import 'package:easy_localization/easy_localization.dart';
import 'package:tabib_app/core/localization/intl_locale.dart';

String formatChatListTime(String isoDate, {String? locale}) {
  final local = _parseLocal(isoDate);
  if (local == null) return '';
  final dateLocale = _dateLocale(locale);
  final now = DateTime.now();
  if (_isSameDay(local, now)) {
    return DateFormat('hh:mm a', dateLocale).format(local);
  }
  final yesterday = now.subtract(const Duration(days: 1));
  if (_isSameDay(local, yesterday)) return 'chat.yesterday'.tr();
  return DateFormat('d MMM', dateLocale).format(local);
}

String formatChatDayLabel(String isoDate, {String? locale}) {
  final local = _parseLocal(isoDate);
  if (local == null) return '';
  final dateLocale = _dateLocale(locale);
  final now = DateTime.now();
  if (_isSameDay(local, now)) return 'chat.today'.tr();
  final yesterday = now.subtract(const Duration(days: 1));
  if (_isSameDay(local, yesterday)) return 'chat.yesterday'.tr();
  return DateFormat('EEEE, d MMM', dateLocale).format(local);
}

String formatChatMessageTime(String isoDate, {String? locale}) {
  final local = _parseLocal(isoDate);
  if (local == null) return '';
  return DateFormat('hh:mm a', _dateLocale(locale)).format(local);
}

bool isSameChatDay(String firstIso, String secondIso) {
  final first = _parseLocal(firstIso);
  final second = _parseLocal(secondIso);
  if (first == null || second == null) return false;
  return _isSameDay(first, second);
}

DateTime? _parseLocal(String isoDate) {
  if (isoDate.isEmpty) return null;
  return DateTime.tryParse(isoDate)?.toLocal();
}

bool _isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

String? _dateLocale(String? locale) {
  if (locale == null || locale.isEmpty) return null;
  final languageCode = locale.split(RegExp('[_-]')).first;
  return intlLocale(languageCode);
}
