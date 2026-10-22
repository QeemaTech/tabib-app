import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/widgets/reservation_card.dart';
import 'package:tabib_app/features/doctor_flow/patients/domain/entities/doctor_patient_entity.dart';

class DoctorPatientListCard extends StatelessWidget {
  final DoctorPatientEntity patient;

  const DoctorPatientListCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    final lastVisitTime = patient.lastVisit?.startTime;
    final statusStyle = _statusStyle(context, patient.status);

    return ReservationCard(
      status: _statusLabel(patient, languageCode),
      statusColor: statusStyle.$1,
      statusBackgroundColor: statusStyle.$2,
      doctorName: patient.localizedFullName(languageCode),
      imageUrl: patient.hasAvatar ? patient.avatarUrl : null,
      subTitle: _subtitle(patient, languageCode),
      time: lastVisitTime == null || lastVisitTime.isEmpty
          ? null
          : 'patients.lastVisitTime'.tr(args: [lastVisitTime]),
      showTime: lastVisitTime != null && lastVisitTime.isNotEmpty,
      actions: [
        ReservationActionButton(
          label: 'patients.viewProfile'.tr(),
          iconPath: AssetsManager.report,
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.patientDetailsView,
              arguments: patient.lastVisit?.appointmentId ?? '',
            );
          },
        ),
      ],
    );
  }

  String _subtitle(DoctorPatientEntity patient, String languageCode) {
    if (languageCode.startsWith('ar') && patient.genderLabelAr.isNotEmpty) {
      return 'patients.ageGender'.tr(
        args: [patient.age.toString(), patient.genderLabelAr],
      );
    }
    final isFemale = patient.gender.toUpperCase() == 'FEMALE';
    return (isFemale ? 'common.yearsOldFemale' : 'common.yearsOldMale').tr(
      args: [patient.age.toString()],
    );
  }

  String _statusLabel(DoctorPatientEntity patient, String languageCode) {
    if (languageCode.startsWith('ar') && patient.statusLabelAr.isNotEmpty) {
      return patient.statusLabelAr;
    }
    switch (patient.status.toUpperCase()) {
      case 'STABLE':
        return 'patients.filters.stable'.tr();
      case 'FOLLOW_UP':
        return 'patients.filters.followUp'.tr();
      case 'RECENT':
        return 'patients.filters.recent'.tr();
      default:
        return patient.statusLabelAr.isNotEmpty
            ? patient.statusLabelAr
            : patient.status;
    }
  }

  (Color, Color) _statusStyle(BuildContext context, String status) {
    final theme = context.appTheme;
    switch (status.toUpperCase()) {
      case 'FOLLOW_UP':
        return (const Color(0xFFDCB263), const Color(0xFFFEF9F0));
      case 'RECENT':
        return (theme.primaryColor500, const Color(0xFFE9EBF1));
      case 'STABLE':
      default:
        return (const Color(0xFF2E7D32), const Color(0xFFE8F5E9));
    }
  }
}
