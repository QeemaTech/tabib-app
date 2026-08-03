import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/features/auth/presentation/view_model/patient/complete_patient_profile_state.dart';
import 'package:tabib_app/features/auth/presentation/view_model/patient/complete_patient_profile_view_model.dart';
import 'package:tabib_app/features/auth/presentation/widgets/drop_down_menu.dart';
import 'package:tabib_app/features/auth/presentation/widgets/uploads_widget.dart';

class CompletePatientProfileStepOne extends StatelessWidget {
  const CompletePatientProfileStepOne({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'auth.completePatientProfile.stepOne.dateOfBirth'.tr(),
          style: theme.medium16.copyWith(fontSize: 18),
        ),
        BlocBuilder<CompletePatientProfileViewModel, CompletePatientProfileState>(
          buildWhen: (previous, current) => previous.dateOfBirth != current.dateOfBirth,
          builder: (context, state) {
            final dateOfBirth = state.dateOfBirth;
            final formattedDate = dateOfBirth!=null? DateFormat('dd/MM/yyyy').format(dateOfBirth):null;
            return CustomTextFormField(
              style: dateOfBirth!=null? theme.medium16.copyWith(fontSize: 18):null,
              hintText:formattedDate?? 'auth.completePatientProfile.stepOne.chooseDateOfBirth'
                  .tr(),
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (date != null && context.mounted) {
                  context
                      .read<CompletePatientProfileViewModel>()
                      .updateDateOfBirth(date);
                }
              },
            );
          },
        ),
        Text(
          'auth.completePatientProfile.stepOne.sex'.tr(),
          style: theme.medium16.copyWith(fontSize: 18),
        ),
        CustomDropdownField(
          hintText: 'auth.completePatientProfile.stepOne.male'.tr(),
          items: [
            'auth.completePatientProfile.stepOne.male'.tr(),
            'auth.completePatientProfile.stepOne.female'.tr(),
          ],
          onChanged: (value) {
            if (value != null) {
              context.read<CompletePatientProfileViewModel>().updateSex(value);
            }
          },
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
                    'auth.completePatientProfile.stepOne.weight'.tr(),
                    style: theme.medium16.copyWith(fontSize: 18),
                  ),
                  CustomDropdownField(
                    hintText: 'auth.completePatientProfile.stepOne.weightHint'
                        .tr(),
                    items: List.generate(171, (index) => '${30 + index} kg'),
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<CompletePatientProfileViewModel>()
                            .updateWeight(value);
                      }
                    },
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
                    'auth.completePatientProfile.stepOne.height'.tr(),
                    style: theme.medium16.copyWith(fontSize: 18),
                  ),
                  CustomDropdownField(
                    hintText: 'auth.completePatientProfile.stepOne.heightHint'
                        .tr(),
                    items: List.generate(151, (index) => '${100 + index} cm'),
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<CompletePatientProfileViewModel>()
                            .updateHeight(value);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          'auth.completePatientProfile.stepOne.addReports'.tr(),
          style: theme.medium16.copyWith(fontSize: 18),
        ),
        BlocBuilder<
          CompletePatientProfileViewModel,
          CompletePatientProfileState
        >(
          builder: (context, state) {
            return UploadsWidget(
              hintText: 'auth.completePatientProfile.stepOne.uploadFiles'.tr(),
              widget: (state.reports ?? []).isNotEmpty
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () async {
                await context
                    .read<CompletePatientProfileViewModel>()
                    .pickImages(source: ImageSource.gallery);
              },
            );
          },
        ),
        const SizedBox(height: 40),
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
