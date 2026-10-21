import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/records/domain/entities/patient_record_list_item_entity.dart';
import 'package:tabib_app/features/records/presentation/utils/record_date_format.dart';
import 'package:tabib_app/features/records/presentation/view_model/records_view_model.dart';
import 'package:tabib_app/features/records/presentation/widgets/medical_record_card.dart';
import 'package:tabib_app/features/records/presentation/widgets/records_empty_view.dart';

class RecordsList extends StatelessWidget {
  final List<PatientRecordListItemEntity> items;
  final bool isLoadingMore;
  final bool hasMore;

  const RecordsList({
    super.key,
    required this.items,
    required this.isLoadingMore,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const RecordsEmptyView();

    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 120 &&
            hasMore) {
          context.read<RecordsViewModel>().loadMore();
        }
        return false;
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: items.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          if (index >= items.length) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: CircularProgressIndicator(color: theme.primaryColor),
              ),
            );
          }
          final item = items[index];
          final when = formatRecordTimestamp(item.occurredAt);
          final isReport = item.kind == PatientRecordKind.report;
          return MedicalRecordCard(
            badgeText: isReport
                ? 'records.filters.reports'.tr()
                : 'records.filters.prescriptions'.tr(),
            doctorName: item.doctor.localizedName(languageCode),
            specialty: item.doctor.localizedSpecialty(languageCode),
            summary: item.summary,
            date: when.date,
            time: when.time,
            onViewTap: () {
              Navigator.of(context).pushNamed(
                isReport
                    ? AppRoutes.reportDetailsView
                    : AppRoutes.prescriptionDetailsView,
                arguments: item.id,
              );
            },
          );
        },
      ),
    );
  }
}
