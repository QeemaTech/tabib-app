import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/features/auth/presentation/view_model/patient/complete_patient_profile_view_model.dart';
import 'package:tabib_app/features/auth/presentation/widgets/custom_radio_button.dart';
import 'package:tabib_app/features/auth/presentation/widgets/drop_down_menu.dart';
import 'package:tabib_app/features/auth/presentation/widgets/uploads_widget.dart';

class CompletepatientProfileStepTwo extends StatefulWidget {
  const CompletepatientProfileStepTwo({super.key});

  @override
  State<CompletepatientProfileStepTwo> createState() => _CompletepatientProfileStepTwoState();
}

class _CompletepatientProfileStepTwoState extends State<CompletepatientProfileStepTwo> {
  late TextEditingController essentialMedicationsHint;
  late TextEditingController allergyHint; 
  @override
  void initState() {
    super.initState();
    essentialMedicationsHint = TextEditingController();
    allergyHint = TextEditingController();
  }
  @override
  void dispose() {
    essentialMedicationsHint.dispose();
    allergyHint.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SingleChildScrollView(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'auth.completePatientProfile.stepTwo.chronicIllnesses'.tr(),
            style: theme.medium16.copyWith(fontSize: 18),
          ),
          CustomDropdownField(
            hintText: 'auth.completePatientProfile.stepTwo.chronicHint'.tr(),
            items: ['x',"x2"],
            onChanged: (value) {
              if (value != null) {
                context.read<CompletePatientProfileViewModel>().updateChronicIllnesses(value);
              }
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
          ),
          Text(
            'auth.completePatientProfile.stepTwo.allergyQuestion'.tr(),
            style: theme.medium16.copyWith(fontSize: 18),
          ),
          const CustomRadioGroup(),
          CustomTextFormField(
            hintText: 'auth.completePatientProfile.stepTwo.allergyHint'.tr(),
            controller: allergyHint,
          ),
          Text(
            'auth.completePatientProfile.stepTwo.addReports'.tr(),
            style: theme.medium16.copyWith(fontSize: 18),
          ),
          UploadsWidget(
            hintText: 'auth.completePatientProfile.stepTwo.uploadFiles'.tr(),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('auth.completeProfile.stepTwo.submitForReview'.tr()),
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
    );
  }
}
