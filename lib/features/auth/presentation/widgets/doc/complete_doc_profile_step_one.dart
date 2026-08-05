import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/auth/presentation/view_model/doc/complete_doc_profile_cubit.dart';
import 'package:tabib_app/features/auth/presentation/view_model/doc/complete_doc_profile_state.dart';
import 'package:tabib_app/features/auth/presentation/widgets/doc/doctor_professional_fee_fields.dart';
import 'package:tabib_app/features/auth/presentation/widgets/doc/doctor_professional_next_button.dart';
import 'package:tabib_app/features/auth/presentation/widgets/doc/doctor_title_experience_row.dart';
import 'package:tabib_app/features/auth/presentation/widgets/doc/sub_specialty_chips.dart';
import 'package:tabib_app/features/auth/presentation/widgets/onboarding_dropdown_field.dart';

class CompleteDocProfileStepOne extends StatefulWidget {
  const CompleteDocProfileStepOne({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<CompleteDocProfileStepOne> createState() =>
      _CompleteDocProfileStepOneState();
}

class _CompleteDocProfileStepOneState extends State<CompleteDocProfileStepOne> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<CompleteDocProfileCubit>().initStepOne();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;

    return BlocListener<CompleteDocProfileCubit, CompleteDocProfileState>(
      listenWhen: (previous, current) =>
          previous.submitProfessionalState != current.submitProfessionalState,
      listener: (context, state) {
        if (state.submitProfessionalState.isLoaded) {
          widget.pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else if (state.submitProfessionalState.isError) {
          CustomToast.error(
            context,
            state.submitProfessionalState.errorMessage ?? '',
          );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'auth.completeProfile.stepOne.welcomeDoctor'.tr(),
              style: theme.bold24.copyWith(
                fontSize: 20,
                color: theme.textColor600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'auth.completeProfile.stepOne.professionalData'.tr(),
              style: theme.medium16.copyWith(
                fontSize: 18,
                color: theme.textColor300,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'auth.completeProfile.stepOne.mainSpecialization'.tr(),
              style: theme.medium16.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            BlocBuilder<CompleteDocProfileCubit, CompleteDocProfileState>(
              buildWhen: (p, c) =>
                  p.mainSpecialtiesState != c.mainSpecialtiesState ||
                  p.mainSpecialtyId != c.mainSpecialtyId,
              builder: (context, state) {
                final items = state.mainSpecialtiesState.data ?? const [];
                return OnboardingDropdownField(
                  hintText:
                      'auth.completeProfile.stepOne.chooseMainSpecialization'
                          .tr(),
                  value: state.mainSpecialtyId,
                  items: items
                      .map(
                        (item) => DropdownMenuItem(
                          value: item.id,
                          child: Text(item.localizedName(languageCode)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context
                          .read<CompleteDocProfileCubit>()
                          .selectMainSpecialty(value);
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 12),
            Text(
              'auth.completeProfile.stepOne.subSpecializations'.tr(),
              style: theme.medium16.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            BlocBuilder<CompleteDocProfileCubit, CompleteDocProfileState>(
              buildWhen: (p, c) =>
                  p.subSpecialtiesState != c.subSpecialtiesState ||
                  p.subSpecialtyIds != c.subSpecialtyIds ||
                  p.mainSpecialtyId != c.mainSpecialtyId,
              builder: (context, state) {
                if (state.mainSpecialtyId == null) {
                  return Text(
                    'auth.completeProfile.stepOne.chooseMainFirst'.tr(),
                    style: theme.regular14.copyWith(color: theme.textColor300),
                  );
                }
                if (state.subSpecialtiesState.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: theme.primaryColor),
                  );
                }
                return SubSpecialtyChips(
                  specialties: state.subSpecialtiesState.data ?? const [],
                  selectedIds: state.subSpecialtyIds,
                  onToggle: context
                      .read<CompleteDocProfileCubit>()
                      .toggleSubSpecialty,
                );
              },
            ),
            const SizedBox(height: 12),
            const DoctorTitleExperienceRow(),
            const SizedBox(height: 12),
            const DoctorProfessionalFeeFields(),
            const SizedBox(height: 24),
            const DoctorProfessionalNextButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
