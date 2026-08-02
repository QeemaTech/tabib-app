import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/features/auth/presentation/widgets/custom_radio_button.dart';
import 'package:tabib_app/features/auth/presentation/widgets/drop_down_menu.dart';
import 'package:tabib_app/features/auth/presentation/widgets/uploads_widget.dart';

class CompletepatientProfileStepTwo extends StatelessWidget {
  const CompletepatientProfileStepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SingleChildScrollView(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Do you have any chronic illnesses?'.tr(),
            style: theme.medium16.copyWith(fontSize: 18),
          ),

          CustomDropdownField(hintText: "sensitive"),
          Text(
            "Are you taking any essential medications?",
            style: theme.medium16.copyWith(fontSize: 18),
          ),
          CustomTextFormField(hintText: "Choose the essential medications you take"),
          Text(
            "Are you allergic to any certain medications?",
            style: theme.medium16.copyWith(fontSize: 18),
          ),

          CustomRadioGroup(),
          CustomTextFormField(hintText: "Write the type of allergy or the name of the medication."),

          Text(
            "Do you want to add reports/rays?",
            style: theme.medium16.copyWith(fontSize: 18),
          ),
        UploadsWidget(hintText:"Upload files" ),



















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
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _UploadFiles extends StatelessWidget {
  const _UploadFiles({required this.title, this.hintText, this.onTap});
  final String title;
  final String? hintText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(title, style: theme.bold18.copyWith(fontSize: 16)),
        UploadsWidget(
          onTap:onTap ,
          hintText: hintText ?? 'auth.completeProfile.stepTwo.uploadFile'.tr(),
        ),
      ],
    );
  }
}
