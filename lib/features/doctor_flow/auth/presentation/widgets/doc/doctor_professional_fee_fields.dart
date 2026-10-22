import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/doc/complete_doc_profile_cubit.dart';

class DoctorProfessionalFeeFields extends StatelessWidget {
  const DoctorProfessionalFeeFields({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final cubit = context.read<CompleteDocProfileCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'auth.completeProfile.stepOne.consultationFee'.tr(),
          style: theme.medium16.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          hintText: 'auth.completeProfile.stepOne.consultationFeeHint'.tr(),
          keyboardType: TextInputType.number,
          onChanged: cubit.updateConsultationFee,
        ),
        const SizedBox(height: 12),
        Text(
          'auth.completeProfile.stepOne.durationChat'.tr(),
          style: theme.medium16.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          hintText: 'auth.completeProfile.stepOne.durationHint'.tr(),
          keyboardType: TextInputType.number,
          onChanged: cubit.updateDurationChat,
        ),
        const SizedBox(height: 12),
        Text(
          'auth.completeProfile.stepOne.durationVoice'.tr(),
          style: theme.medium16.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          hintText: 'auth.completeProfile.stepOne.durationHint'.tr(),
          keyboardType: TextInputType.number,
          onChanged: cubit.updateDurationVoice,
        ),
        const SizedBox(height: 12),
        Text(
          'auth.completeProfile.stepOne.durationVideo'.tr(),
          style: theme.medium16.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          hintText: 'auth.completeProfile.stepOne.durationHint'.tr(),
          keyboardType: TextInputType.number,
          onChanged: cubit.updateDurationVideo,
        ),
      ],
    );
  }
}
