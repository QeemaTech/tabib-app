import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/features/auth/presentation/view_model/patient/complete_patient_profile_state.dart';
import 'package:tabib_app/features/auth/presentation/view_model/patient/complete_patient_profile_view_model.dart';

class PatientHealthProfileNextButton extends StatelessWidget {
  const PatientHealthProfileNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      CompletePatientProfileViewModel,
      CompletePatientProfileState
    >(
      buildWhen: (previous, current) =>
          previous.healthProfileState != current.healthProfileState,
      builder: (context, state) {
        final isLoading = state.healthProfileState.isLoading;
        return ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  context
                      .read<CompletePatientProfileViewModel>()
                      .submitHealthProfile();
                },
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text('auth.completeProfile.next'.tr()),
        );
      },
    );
  }
}
