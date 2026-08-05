import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/auth/presentation/view_model/doc/complete_doc_profile_cubit.dart';
import 'package:tabib_app/features/auth/presentation/view_model/doc/complete_doc_profile_state.dart';
import 'package:tabib_app/features/auth/presentation/widgets/onboarding_dropdown_field.dart';

class DoctorTitleExperienceRow extends StatelessWidget {
  const DoctorTitleExperienceRow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'auth.completeProfile.stepOne.professionalTitle'.tr(),
                style: theme.medium16.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 8),
              BlocBuilder<CompleteDocProfileCubit, CompleteDocProfileState>(
                buildWhen: (p, c) =>
                    p.professionalTitlesState != c.professionalTitlesState ||
                    p.professionalTitle != c.professionalTitle,
                builder: (context, state) {
                  final items = state.professionalTitlesState.data ?? const [];
                  return OnboardingDropdownField(
                    hintText: 'auth.completeProfile.stepOne.consultant'.tr(),
                    value: state.professionalTitle,
                    items: items
                        .map(
                          (item) => DropdownMenuItem(
                            value: item.value,
                            child: Text(item.localizedName(languageCode)),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<CompleteDocProfileCubit>()
                            .selectProfessionalTitle(value);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'auth.completeProfile.stepOne.yearsOfExperience'.tr(),
                style: theme.medium16.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 8),
              BlocBuilder<CompleteDocProfileCubit, CompleteDocProfileState>(
                buildWhen: (p, c) => p.experienceYears != c.experienceYears,
                builder: (context, state) {
                  return OnboardingDropdownField(
                    hintText:
                        'auth.completeProfile.stepOne.yearsExperiencePlaceholder'
                            .tr(),
                    value: state.experienceYears?.toString(),
                    items: List.generate(50, (index) {
                      final year = index + 1;
                      return DropdownMenuItem(
                        value: year.toString(),
                        child: Text(
                          'auth.completeProfile.stepOne.yearsCount'
                              .tr(args: ['$year']),
                        ),
                      );
                    }),
                    onChanged: (value) {
                      final years = int.tryParse(value ?? '');
                      if (years != null) {
                        context
                            .read<CompleteDocProfileCubit>()
                            .selectExperienceYears(years);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
