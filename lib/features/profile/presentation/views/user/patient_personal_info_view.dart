import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/profile/domain/entities/patient_profile_entity.dart';
import 'package:tabib_app/features/profile/presentation/view_model/patient_profile_state.dart';
import 'package:tabib_app/features/profile/presentation/view_model/patient_profile_view_model.dart';
import 'package:tabib_app/features/profile/presentation/widgets/patient_personal_details_card.dart';
import 'package:tabib_app/features/profile/presentation/widgets/patient_profile_header_card.dart';

class PatientPersonalInfoView extends StatelessWidget {
  const PatientPersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PatientProfileViewModel>()..loadProfile(),
      child: const _PatientPersonalInfoBody(),
    );
  }
}

class _PatientPersonalInfoBody extends StatelessWidget {
  const _PatientPersonalInfoBody();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.whiteColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'profile.personalInfo'.tr(),
          style: theme.bold18.copyWith(color: theme.textColor600),
        ),
      ),
      body: BlocBuilder<PatientProfileViewModel, PatientProfileState>(
        builder: (context, state) {
          final profileState = state.profileState;
          if (profileState.isLoading || profileState.isInitial) {
            return const _PatientPersonalInfoLoadingWidget();
          }
          if (profileState.isError) {
            return _PatientPersonalInfoErrorWidget(
              message: profileState.errorMessage ?? '',
            );
          }
          return _PatientPersonalInfoSuccessWidget(
            profile: profileState.data!,
          );
        },
      ),
    );
  }
}

class _PatientPersonalInfoLoadingWidget extends StatelessWidget {
  const _PatientPersonalInfoLoadingWidget();

  @override
  Widget build(BuildContext context) {
    const placeholder = PatientProfileEntity(
      id: '',
      fullNameAr: 'Patient Name',
      fullNameEn: 'Patient Name',
      fullNameSo: '',
      dateOfBirth: '1998-01-15',
      gender: 'MALE',
      heightCm: 178,
      weightKg: 74,
      avatarUrl: '',
      bloodType: 'A+',
      allergies: '',
      chronicConditions: '',
      currentMedications: '',
      hasMedicationAllergy: false,
      phone: '69999999',
      email: 'email@example.com',
      isVerified: true,
    );

    return const Skeletonizer(
      enabled: true,
      child: _PatientPersonalInfoSuccessWidget(profile: placeholder),
    );
  }
}

class _PatientPersonalInfoErrorWidget extends StatelessWidget {
  final String message;

  const _PatientPersonalInfoErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () => context.read<PatientProfileViewModel>().refreshProfile(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: theme.regular14.copyWith(color: theme.textColor300),
                  ),
                  IconButton(
                    onPressed: () =>
                        context.read<PatientProfileViewModel>().retry(),
                    icon: Icon(Icons.refresh, color: theme.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientPersonalInfoSuccessWidget extends StatelessWidget {
  final PatientProfileEntity profile;

  const _PatientPersonalInfoSuccessWidget({required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () => context.read<PatientProfileViewModel>().refreshProfile(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          PatientProfileHeaderCard(profile: profile),
          const SizedBox(height: 16),
          PatientPersonalDetailsCard(profile: profile),
        ],
      ),
    );
  }
}
