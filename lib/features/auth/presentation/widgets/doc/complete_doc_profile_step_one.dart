import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/auth/presentation/widgets/drop_down_menu.dart';

class CompleteDocProfileStepOne extends StatelessWidget {
  const CompleteDocProfileStepOne({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'auth.completeProfile.stepOne.welcomeDoctor'.tr(),
          style: theme.bold24.copyWith(fontSize: 20, color: theme.textColor600),
        ),
        Text(
          'auth.completeProfile.stepOne.professionalData'.tr(),
          style: theme.medium16.copyWith(
            fontSize: 18,
            color: theme.textColor300,
          ),
        ),
        Text(
          'auth.completeProfile.stepOne.mainSpecialization'.tr(),
          style: theme.medium16.copyWith(fontSize: 18),
        ),
        CustomDropdownField(
          hintText: 'auth.completeProfile.stepOne.chooseMainSpecialization'.tr(),
           items: [],
        ),
        Text(
          'auth.completeProfile.stepOne.subSpecializations'.tr(),
          style: theme.medium16.copyWith(fontSize: 18),
        ),
        CustomDropdownField(
          hintText: 'auth.completeProfile.stepOne.chooseSubSpecializations'.tr(),
           items: [],
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
                    'auth.completeProfile.stepOne.professionalTitle'.tr(),
                    style: theme.medium16.copyWith(fontSize: 18),
                  ),
                  CustomDropdownField(
                    hintText: 'auth.completeProfile.stepOne.consultant'.tr(),
                     items: [],
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
                    'auth.completeProfile.stepOne.yearsOfExperience'.tr(),
                    style: theme.medium16.copyWith(fontSize: 18),
                  ),
                  CustomDropdownField(
                    hintText:
                        'auth.completeProfile.stepOne.yearsExperiencePlaceholder'
                            .tr(),
                             items: [],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Text('auth.completeProfile.next'.tr()),
          ),
        ),
      ],
    );
  }
}
