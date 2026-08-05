import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/features/auth/presentation/view_model/doc/complete_doc_profile_cubit.dart';
import 'package:tabib_app/features/auth/presentation/view_model/doc/complete_doc_profile_state.dart';

class DoctorDocumentsSubmitButton extends StatelessWidget {
  const DoctorDocumentsSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteDocProfileCubit, CompleteDocProfileState>(
      buildWhen: (previous, current) =>
          previous.submitDocumentsState != current.submitDocumentsState,
      builder: (context, state) {
        final isLoading = state.submitDocumentsState.isLoading;
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () => context.read<CompleteDocProfileCubit>().submitDocuments(),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text('auth.completeProfile.stepTwo.submitForReview'.tr()),
          ),
        );
      },
    );
  }
}
