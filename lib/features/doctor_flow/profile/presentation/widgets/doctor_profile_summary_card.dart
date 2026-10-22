import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/profile/domain/entities/doctor_profile_entity.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/doctor_profile_fee_chip.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/patient_profile_detail_row.dart';

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
    final bio = profile.localizedBio(languageCode).trim();
    final rows = <({String label, String value})>[
      if (specialties.isNotEmpty)
        (
          label: 'profile.doctor.specialties'.tr(),
          value: specialties,
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
    ];
    final fees = <({String label, String value, IconData icon})>[
      if (profile.consultationFee > 0)
        (
          label: 'profile.doctor.consultationFee'.tr(),
          value: _fee(profile.consultationFee),
          icon: Icons.payments_outlined,
        ),
      if (_hasFee(profile.feeChat))
        (
          label: 'profile.doctor.feeChat'.tr(),
          value: _fee(profile.feeChat!),
          icon: Icons.chat_bubble_outline,
        ),
      if (_hasFee(profile.feeVoice))
        (
          label: 'profile.doctor.feeVoice'.tr(),
          value: _fee(profile.feeVoice!),
          icon: Icons.call_outlined,
        ),
      if (_hasFee(profile.feeVideo))
        (
          label: 'profile.doctor.feeVideo'.tr(),
          value: _fee(profile.feeVideo!),
          icon: Icons.videocam_outlined,
        ),
    ];
    if (bio.isEmpty && rows.isEmpty && fees.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.textColor100.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: theme.blackColor.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bio.isNotEmpty) ...[
            Text(
              'profile.doctor.bio'.tr(),
              style: theme.bold12.copyWith(color: theme.textColor300),
            ),
            const SizedBox(height: 6),
            Text(
              bio,
              style: theme.regular14.copyWith(color: theme.textColor600),
            ),
            if (rows.isNotEmpty || fees.isNotEmpty) const SizedBox(height: 8),
          ],
          for (var index = 0; index < rows.length; index++)
            PatientProfileDetailRow(
              label: rows[index].label,
              value: rows[index].value,
              showDivider: index < rows.length - 1 || fees.isNotEmpty,
            ),
          if (fees.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Text(
                'profile.doctor.fees'.tr(),
                style: theme.bold12.copyWith(color: theme.textColor300),
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final fee in fees)
                  DoctorProfileFeeChip(
                    label: fee.label,
                    value: fee.value,
                    icon: fee.icon,
                  ),
              ],
            ),
            const SizedBox(height: 12),
          ],
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
