import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/features/auth/presentation/widgets/drop_down_menu.dart';
import 'package:tabib_app/features/auth/presentation/widgets/uploads_widget.dart';

class CompletePatientProfileStepOne extends StatelessWidget {
  const CompletePatientProfileStepOne({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          'date of birth'.tr(),
          style: theme.medium16.copyWith(fontSize: 18),
        ),
        CustomTextFormField(hintText: "Choose date of birth"),
        Text('sex'.tr(),
          style: theme.medium16.copyWith(fontSize: 18),
        ),
        CustomDropdownField(
          hintText: 'mala'.tr(),
        ),
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'weight'.tr(),
                    style: theme.medium16.copyWith(fontSize: 18),
                  ),
                  CustomDropdownField(
                    hintText: '74'.tr(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'height'.tr(),
                    style: theme.medium16.copyWith(fontSize: 18),
                  ),
                  CustomDropdownField(
                    hintText:
                        '128cm'
                            .tr(),
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          'Do you want to add reports/ Radiation'.tr(),
          style: theme.medium16.copyWith(fontSize: 18),
        ),
        UploadsWidget(hintText:"Upload files" ),
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Text('auth.completeProfile.next'.tr()),
        ),
      ],
    );
  }
}
