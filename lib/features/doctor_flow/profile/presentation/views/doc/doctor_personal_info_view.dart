import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/profile/domain/entities/doctor_profile_entity.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/view_model/doctor_profile_state.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/view_model/doctor_profile_view_model.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/doctor_personal_details_card.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/doctor_profile_header_card.dart';

class DoctorPersonalInfoView extends StatelessWidget {
  const DoctorPersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DoctorProfileViewModel>()..loadProfile(),
      child: const _DoctorPersonalInfoBody(),
    );
  }
}

class _DoctorPersonalInfoBody extends StatelessWidget {
  const _DoctorPersonalInfoBody();

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
      body: BlocBuilder<DoctorProfileViewModel, DoctorProfileState>(
        buildWhen: (previous, current) =>
            previous.profileState != current.profileState,
        builder: (context, state) {
          final profileState = state.profileState;
          if (profileState.isLoading || profileState.isInitial) {
            return const _DoctorPersonalInfoLoadingWidget();
          }
          if (profileState.isError) {
            return _DoctorPersonalInfoErrorWidget(
              message: profileState.errorMessage ?? '',
            );
          }
          return _DoctorPersonalInfoSuccessWidget(
            profile: profileState.data!,
          );
        },
      ),
    );
  }
}

class _DoctorPersonalInfoLoadingWidget extends StatelessWidget {
  const _DoctorPersonalInfoLoadingWidget();

  @override
  Widget build(BuildContext context) {
    const placeholder = DoctorProfileEntity(
      id: '',
      fullNameAr: 'Doctor Name',
      fullNameEn: 'Doctor Name',
      avatarUrl: '',
      bioAr: 'Bio placeholder text',
      bioEn: '',
      experienceYears: 10,
      professionalTitle: 'CONSULTANT',
      professionalTitleAr: 'Consultant',
      consultationFee: 200,
      verificationStatus: 'PENDING',
      isOnline: false,
      ratingAvg: 4.5,
      ratingCount: 10,
      phone: '00000000',
      email: '',
      subSpecialties: [],
      specialties: [],
      documents: [],
    );
    return const Skeletonizer(
      enabled: true,
      child: _DoctorPersonalInfoSuccessWidget(profile: placeholder),
    );
  }
}

class _DoctorPersonalInfoErrorWidget extends StatelessWidget {
  final String message;

  const _DoctorPersonalInfoErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () => context.read<DoctorProfileViewModel>().refreshProfile(),
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
                        context.read<DoctorProfileViewModel>().retry(),
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

class _DoctorPersonalInfoSuccessWidget extends StatelessWidget {
  final DoctorProfileEntity profile;

  const _DoctorPersonalInfoSuccessWidget({required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () => context.read<DoctorProfileViewModel>().refreshProfile(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          DoctorProfileHeaderCard(profile: profile),
          const SizedBox(height: 16),
          DoctorPersonalDetailsCard(profile: profile),
        ],
      ),
    );
  }
}
