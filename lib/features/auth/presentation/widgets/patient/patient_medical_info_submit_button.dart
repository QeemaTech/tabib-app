import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/features/auth/presentation/view_model/patient/complete_patient_profile_state.dart';
import 'package:tabib_app/features/auth/presentation/view_model/patient/complete_patient_profile_view_model.dart';

class PatientMedicalInfoSubmitButton extends StatelessWidget {
  const PatientMedicalInfoSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      CompletePatientProfileViewModel,
      CompletePatientProfileState
    >(
      buildWhen: (previous, current) =>
          previous.medicalInfoState != current.medicalInfoState,
      builder: (context, state) {
        final isLoading = state.medicalInfoState.isLoading;
        return ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  context
                      .read<CompletePatientProfileViewModel>()
                      .submitMedicalInfo();
                },
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text('auth.completeProfile.stepTwo.submitForReview'.tr()),
        );
      },
    );
  }
}
