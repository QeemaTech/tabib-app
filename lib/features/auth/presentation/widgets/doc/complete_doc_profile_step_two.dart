import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/auth/presentation/view_model/doc/complete_doc_profile_cubit.dart';
import 'package:tabib_app/features/auth/presentation/view_model/doc/complete_doc_profile_state.dart';
import 'package:tabib_app/features/auth/presentation/widgets/doc/doctor_documents_submit_button.dart';
import 'package:tabib_app/features/auth/presentation/widgets/uploads_widget.dart';

class CompleteDocProfileStepTwo extends StatelessWidget {
  const CompleteDocProfileStepTwo({super.key});

  void _goToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.mainLayoutView,
      (route) => false,
      arguments: 'doctor',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocListener<CompleteDocProfileCubit, CompleteDocProfileState>(
      listenWhen: (previous, current) =>
          previous.submitDocumentsState != current.submitDocumentsState,
      listener: (context, state) {
        if (state.submitDocumentsState.isLoaded) {
          _goToHome(context);
        } else if (state.submitDocumentsState.isError) {
          CustomToast.error(
            context,
            state.submitDocumentsState.errorMessage ?? '',
          );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'auth.completeProfile.stepTwo.completeYourProfile'.tr(),
              style: theme.bold24.copyWith(
                fontSize: 20,
                color: theme.textColor600,
              ),
            ),
            Text(
              'auth.completeProfile.stepTwo.completeToActivate'.tr(),
              style: theme.medium16.copyWith(
                fontSize: 18,
                color: theme.textColor300,
              ),
            ),
            Text(
              'auth.completeProfile.stepTwo.documents'.tr(),
              style: theme.medium16.copyWith(fontSize: 18),
            ),
            Text(
              'auth.completeProfile.stepTwo.documentsDescription'.tr(),
              textAlign: TextAlign.start,
              style: theme.regular14.copyWith(color: theme.textColor200),
            ),
            _DocumentUploadField(
              titleKey: 'auth.completeProfile.stepTwo.academicCertificates',
              fileSelector: (state) => state.academicCertificateImage,
              onTap: (context) => context
                  .read<CompleteDocProfileCubit>()
                  .updateAcademicCertificateImage(),
            ),
            _DocumentUploadField(
              titleKey: 'auth.completeProfile.stepTwo.idProof',
              fileSelector: (state) => state.idProofImage,
              onTap: (context) => context
                  .read<CompleteDocProfileCubit>()
                  .updateIdProofImage(),
            ),
            _DocumentUploadField(
              titleKey: 'auth.completeProfile.stepTwo.medicalLicenseImage',
              fileSelector: (state) => state.medicalLicenseImage,
              onTap: (context) => context
                  .read<CompleteDocProfileCubit>()
                  .updateMedicalLicenseImage(),
            ),
            _DocumentUploadField(
              titleKey: 'auth.completeProfile.stepTwo.professionalPhoto',
              hintKey: 'auth.completeProfile.stepTwo.uploadPhoto',
              fileSelector: (state) => state.professionalPhoto,
              onTap: (context) => context
                  .read<CompleteDocProfileCubit>()
                  .updateProfessionalPhoto(),
            ),
            const SizedBox(height: 49),
            const DoctorDocumentsSubmitButton(),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'auth.completeProfile.stepTwo.canEditLater'.tr(),
                textAlign: TextAlign.center,
                style: theme.regular14.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.textColor200,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _DocumentUploadField extends StatelessWidget {
  const _DocumentUploadField({
    required this.titleKey,
    required this.fileSelector,
    required this.onTap,
    this.hintKey,
  });

  final String titleKey;
  final String? hintKey;
  final XFile? Function(CompleteDocProfileState state) fileSelector;
  final void Function(BuildContext context) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(titleKey.tr(), style: theme.bold18.copyWith(fontSize: 16)),
        BlocBuilder<CompleteDocProfileCubit, CompleteDocProfileState>(
          buildWhen: (previous, current) =>
              fileSelector(previous) != fileSelector(current),
          builder: (context, state) {
            final file = fileSelector(state);
            return UploadsWidget(
              onTap: () => onTap(context),
              hintText: file?.name ??
                  (hintKey ?? 'auth.completeProfile.stepTwo.uploadFile').tr(),
              widget: file != null
                  ? Icon(Icons.check, color: theme.primaryColor)
                  : null,
            );
          },
        ),
      ],
    );
  }
}
