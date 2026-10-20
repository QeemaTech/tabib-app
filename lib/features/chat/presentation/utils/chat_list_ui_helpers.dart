import 'package:easy_localization/easy_localization.dart';

String formatChatListTime(String isoDate) {
  if (isoDate.isEmpty) return '';
  final parsed = DateTime.tryParse(isoDate);
  if (parsed == null) return '';
  return DateFormat('hh:mm a').format(parsed.toLocal());
}
