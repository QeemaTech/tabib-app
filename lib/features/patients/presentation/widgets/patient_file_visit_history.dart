import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patients/domain/entities/patient_file_medical_history_entity.dart';
import 'package:tabib_app/features/patients/presentation/utils/patient_file_display.dart';

class PatientFileVisitHistory extends StatelessWidget {
  final List<PatientFileMedicalHistoryEntity> items;

  const PatientFileVisitHistory({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EBF1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: items.isEmpty
          ? const PatientFileVisitHistoryItem(
              title: '----',
              dateLabel: '----',
            )
          : Column(
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  if (i > 0) const Divider(),
                  PatientFileVisitHistoryItem(
                    title: patientFileDisplay(items[i].summaryAr),
                    dateLabel: _formatDate(context, items[i].date),
                  ),
                ],
              ],
            ),
    );
  }

  String _formatDate(BuildContext context, String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return '----';
    final parsed = DateTime.tryParse(trimmed);
    if (parsed == null) return trimmed;
    final locale = context.locale.toString();
    return DateFormat.yMMMEd(locale).format(parsed.toLocal());
  }
}

class PatientFileVisitHistoryItem extends StatelessWidget {
  final String title;
  final String dateLabel;

  const PatientFileVisitHistoryItem({
    super.key,
    required this.title,
    required this.dateLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.bold18.copyWith(fontSize: 14)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateLabel,
                style: theme.regular12.copyWith(color: theme.textColor300),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios, size: 14),
                label: Text('patients.details.viewDetails'.tr()),
                style: TextButton.styleFrom(
                  iconAlignment: IconAlignment.end,
                  foregroundColor: theme.primaryColor,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
