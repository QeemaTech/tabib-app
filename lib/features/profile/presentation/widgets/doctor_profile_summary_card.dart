import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/profile/domain/entities/doctor_profile_entity.dart';
import 'package:tabib_app/features/profile/presentation/widgets/patient_profile_detail_row.dart';

class DoctorProfileSummaryCard extends StatelessWidget {
  final DoctorProfileEntity profile;

  const DoctorProfileSummaryCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;
    final specialties = profile.specialties
        .map((item) => item.localizedName(languageCode))
        .where((name) => name.isNotEmpty)
        .join(', ');
    final clinic = profile.clinic;
    final rows = <({String label, String value})>[
      if (profile.experienceYears > 0)
        (
          label: 'profile.doctor.experienceYears'.tr(),
          value: '${profile.experienceYears} ${'profile.years'.tr()}',
        ),
      if (profile.consultationFee > 0)
        (
          label: 'profile.doctor.consultationFee'.tr(),
          value: _fee(profile.consultationFee),
        ),
      if (_hasFee(profile.feeChat))
        (
          label: 'profile.doctor.feeChat'.tr(),
          value: _fee(profile.feeChat!),
        ),
      if (_hasFee(profile.feeVoice))
        (
          label: 'profile.doctor.feeVoice'.tr(),
          value: _fee(profile.feeVoice!),
        ),
      if (_hasFee(profile.feeVideo))
        (
          label: 'profile.doctor.feeVideo'.tr(),
          value: _fee(profile.feeVideo!),
        ),
      if (clinic != null && clinic.nameAr.trim().isNotEmpty)
        (
          label: 'profile.doctor.clinic'.tr(),
          value: clinic.nameAr,
        ),
      if (clinic != null && clinic.addressAr.trim().isNotEmpty)
        (
          label: 'profile.doctor.clinicAddress'.tr(),
          value: clinic.addressAr,
        ),
      if (specialties.isNotEmpty)
        (
          label: 'profile.doctor.specialties'.tr(),
          value: specialties,
        ),
      if (profile.localizedBio(languageCode).trim().isNotEmpty)
        (
          label: 'profile.doctor.bio'.tr(),
          value: profile.localizedBio(languageCode),
        ),
    ];
    if (rows.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.textColor100.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++)
            PatientProfileDetailRow(
              label: rows[index].label,
              value: rows[index].value,
              showDivider: index < rows.length - 1,
            ),
        ],
      ),
    );
  }

  bool _hasFee(double? value) => value != null && value > 0;

  String _fee(double value) {
    final formatted = value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toString();
    return '$formatted ${'common.currency'.tr()}';
  }
}
