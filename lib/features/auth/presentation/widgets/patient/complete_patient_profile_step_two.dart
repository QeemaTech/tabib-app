import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/auth/presentation/view_model/patient/complete_patient_profile_state.dart';
import 'package:tabib_app/features/auth/presentation/view_model/patient/complete_patient_profile_view_model.dart';
import 'package:tabib_app/features/auth/presentation/widgets/custom_radio_button.dart';
import 'package:tabib_app/features/auth/presentation/widgets/drop_down_menu.dart';
import 'package:tabib_app/features/auth/presentation/widgets/uploads_widget.dart';

class CompletepatientProfileStepTwo extends StatefulWidget {
  const CompletepatientProfileStepTwo({super.key});

  @override
  State<CompletepatientProfileStepTwo> createState() =>
      _CompletepatientProfileStepTwoState();
}

class _CompletepatientProfileStepTwoState
    extends State<CompletepatientProfileStepTwo> {
  late TextEditingController essentialMedicationsHint;
  late TextEditingController allergyHint;
  late TextEditingController chronicIllnessesHint;
  @override
  void initState() {
    super.initState();
    essentialMedicationsHint = TextEditingController();
    chronicIllnessesHint = TextEditingController();
    allergyHint = TextEditingController();
  }

  @override
  void dispose() {
    essentialMedicationsHint.dispose();
    allergyHint.dispose();
    chronicIllnessesHint.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocListener<
      CompletePatientProfileViewModel,
      CompletePatientProfileState
    >(
      listenWhen: (previous, current) =>
          previous.medicalInfoState != current.medicalInfoState,
      listener: (context, state) {
        if (state.medicalInfoState.isLoaded) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.mainLayoutView,
            (route) => false,
            arguments: 'user',
          );
        } else if (state.medicalInfoState.isError) {
          CustomToast.error(
            context,
            state.medicalInfoState.errorMessage ?? '',
          );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'auth.completePatientProfile.stepTwo.chronicIllnesses'.tr(),
              style: theme.medium16.copyWith(fontSize: 18),
            ),
            
            CustomTextFormField(
              hintText: 'auth.completePatientProfile.stepTwo.chronicHint'.tr(),
              controller: chronicIllnessesHint,
              onChanged: (value) {
                context
                    .read<CompletePatientProfileViewModel>()
                    .updateChronicIllnesses(value);
              },
            ),
            Text(
              'auth.completePatientProfile.stepTwo.essentialMedications'.tr(),
              style: theme.medium16.copyWith(fontSize: 18),
            ),
            CustomTextFormField(
              hintText:
                  'auth.completePatientProfile.stepTwo.essentialMedicationsHint'
                      .tr(),
              controller: essentialMedicationsHint,
              onChanged: (value) {
                context
                    .read<CompletePatientProfileViewModel>()
                    .updateEssentialMedications(value);
              },
            ),
            Text(
              'auth.completePatientProfile.stepTwo.allergyQuestion'.tr(),
              style: theme.medium16.copyWith(fontSize: 18),
            ),
            BlocBuilder<
              CompletePatientProfileViewModel,
              CompletePatientProfileState
            >(
              buildWhen: (previous, current) =>
                  previous.areHaveAnyAllergies != current.areHaveAnyAllergies,
              builder: (context, state) {
                return CustomRadioGroup(
                  value: state.areHaveAnyAllergies ?? false,
                  onChanged: (value) {
                    context
                        .read<CompletePatientProfileViewModel>()
                        .updateAreHaveAnyAllergies(value);
                  },
                );
              },
            ),
            CustomTextFormField(
              hintText: 'auth.completePatientProfile.stepTwo.allergyHint'.tr(),
              controller: allergyHint,
              onChanged: (value) {
                context
                    .read<CompletePatientProfileViewModel>()
                    .updateAllergyDetails(value);
              },
            ),
            Text(
              'auth.completePatientProfile.stepTwo.addReports'.tr(),
              style: theme.medium16.copyWith(fontSize: 18),
            ),
            BlocBuilder<
              CompletePatientProfileViewModel,
              CompletePatientProfileState
            >(
              buildWhen: (previous, current) =>
                  previous.reportesAndrays != current.reportesAndrays,
              builder: (context, state) {
                return UploadsWidget(
                  hintText:
                      'auth.completePatientProfile.stepTwo.uploadFiles'.tr(),
                  widget: (state.reportesAndrays ?? []).isNotEmpty
                      ? Icon(Icons.check, color: theme.primaryColor)
                      : null,
                  onTap: () async {
                    await context
                        .read<CompletePatientProfileViewModel>()
                        .pickMedicalInfoFiles(source: ImageSource.gallery);
                  },
                );
              },
            ),
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<
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
                        : Text(
                            'auth.completeProfile.stepTwo.submitForReview'
                                .tr(),
                          ),
                  );
                },
              ),
            ),
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
