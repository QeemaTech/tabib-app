import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/profile/domain/entities/doctor_profile_entity.dart';
import 'package:tabib_app/features/profile/presentation/widgets/patient_profile_detail_row.dart';

class DoctorPersonalDetailsCard extends StatelessWidget {
  final DoctorProfileEntity profile;

  const DoctorPersonalDetailsCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final lang = context.locale.languageCode;
    final subSpecialties = profile.subSpecialties
        .map((e) => e.localizedName(lang))
        .where((e) => e.isNotEmpty)
        .join(', ');
    final clinic = profile.clinic;
    final bio = profile.localizedBio(lang);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.textColor100.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          PatientProfileDetailRow(
            label: 'profile.personal.fullNameAr'.tr(),
            value: profile.fullNameAr,
          ),
          PatientProfileDetailRow(
            label: 'profile.personal.fullNameEn'.tr(),
            value: profile.fullNameEn,
          ),
          PatientProfileDetailRow(
            label: 'profile.personal.phone'.tr(),
            value: profile.phone,
          ),
          PatientProfileDetailRow(
            label: 'profile.personal.email'.tr(),
            value: profile.email,
          ),
          PatientProfileDetailRow(
            label: 'profile.doctor.professionalTitle'.tr(),
            value: profile.localizedTitle(lang),
          ),
          PatientProfileDetailRow(
            label: 'profile.doctor.mainSpecialty'.tr(),
            value: profile.mainSpecialty?.localizedName(lang) ?? '',
          ),
          PatientProfileDetailRow(
            label: 'profile.doctor.subSpecialties'.tr(),
            value: subSpecialties,
          ),
          PatientProfileDetailRow(
            label: 'profile.doctor.experienceYears'.tr(),
            value: profile.experienceYears > 0
                ? '${profile.experienceYears} ${'profile.years'.tr()}'
                : '',
          ),
          PatientProfileDetailRow(
            label: 'profile.doctor.consultationFee'.tr(),
            value: profile.consultationFee > 0
                ? '${profile.consultationFee} ${'common.currency'.tr()}'
                : '',
          ),
          PatientProfileDetailRow(
            label: 'profile.doctor.verificationStatus'.tr(),
            value: _verificationLabel(profile.verificationStatus),
          ),
          PatientProfileDetailRow(
            label: 'profile.doctor.rating'.tr(),
            value: profile.ratingCount > 0
                ? '${profile.ratingAvg.toStringAsFixed(1)} (${profile.ratingCount})'
                : profile.ratingAvg > 0
                    ? profile.ratingAvg.toStringAsFixed(1)
                    : '',
          ),
          PatientProfileDetailRow(
            label: 'profile.doctor.clinic'.tr(),
            value: clinic?.nameAr ?? '',
          ),
          PatientProfileDetailRow(
            label: 'profile.doctor.clinicAddress'.tr(),
            value: clinic?.addressAr ?? '',
          ),
          PatientProfileDetailRow(
            label: 'profile.doctor.bio'.tr(),
            value: bio,
            showDivider: false,
          ),
        ],
      ),
    );
  }

  String _verificationLabel(String status) {
    switch (status.toUpperCase()) {
      case 'VERIFIED':
      case 'APPROVED':
        return 'profile.doctor.statusVerified'.tr();
      case 'REJECTED':
        return 'profile.doctor.statusRejected'.tr();
      case 'PENDING':
        return 'profile.doctor.statusPending'.tr();
      default:
        return status;
    }
  }
}
