import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/profile/domain/entities/patient_profile_entity.dart';
import 'package:tabib_app/features/profile/presentation/view_model/patient_profile_state.dart';
import 'package:tabib_app/features/profile/presentation/view_model/patient_profile_view_model.dart';
import 'package:tabib_app/features/profile/presentation/widgets/patient_personal_details_card.dart';
import 'package:tabib_app/features/profile/presentation/widgets/patient_personal_info_edit_form.dart';
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

class _PatientPersonalInfoBody extends StatefulWidget {
  const _PatientPersonalInfoBody();

  @override
  State<_PatientPersonalInfoBody> createState() =>
      _PatientPersonalInfoBodyState();
}

class _PatientPersonalInfoBodyState extends State<_PatientPersonalInfoBody> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocListener<PatientProfileViewModel, PatientProfileState>(
      listenWhen: (previous, current) =>
          previous.updateProfileState != current.updateProfileState,
      listener: (context, state) {
        final updateState = state.updateProfileState;
        if (updateState.isLoaded) {
          CustomToast.success(context, 'profile.personal.updateSuccess'.tr());
          context.read<PatientProfileViewModel>().resetUpdateState();
          setState(() => _isEditing = false);
        } else if (updateState.isError) {
          CustomToast.error(context, updateState.errorMessage ?? '');
        }
      },
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: theme.whiteColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            _isEditing
                ? 'profile.personal.editTitle'.tr()
                : 'profile.personalInfo'.tr(),
            style: theme.bold18.copyWith(color: theme.textColor600),
          ),
          actions: [
            if (!_isEditing)
              IconButton(
                onPressed: () {
                  final loaded = context
                      .read<PatientProfileViewModel>()
                      .state
                      .profileState
                      .isLoaded;
                  if (loaded) setState(() => _isEditing = true);
                },
                icon: Icon(Icons.edit_outlined, color: theme.primaryColor),
              ),
          ],
        ),
        body: BlocBuilder<PatientProfileViewModel, PatientProfileState>(
          buildWhen: (previous, current) =>
              previous.profileState != current.profileState,
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
            final profile = profileState.data!;
            if (_isEditing) {
              return PatientPersonalInfoEditForm(
                profile: profile,
                onCancel: () => setState(() => _isEditing = false),
              );
            }
            return _PatientPersonalInfoSuccessWidget(profile: profile);
          },
        ),
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
      heightCm: 170,
      weightKg: 70,
      avatarUrl: '',
      bloodType: 'A+',
      allergies: '',
      chronicConditions: '',
      currentMedications: '',
      hasMedicationAllergy: false,
      phone: '00000000',
      email: '',
      isVerified: false,
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
