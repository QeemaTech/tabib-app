import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/widgets/filter_chips.dart';
import 'package:tabib_app/core/widgets/reservation_card.dart';
import 'package:tabib_app/features/home/presentation/widgets/search_bar_widget.dart';
import 'package:tabib_app/features/patients/domain/entities/doctor_patient_entity.dart';
import 'package:tabib_app/features/patients/presentation/view_model/doctor_patients_state.dart';
import 'package:tabib_app/features/patients/presentation/view_model/doctor_patients_view_model.dart';
import 'package:tabib_app/features/patients/presentation/widgets/doctor_patient_list_card.dart';

const _filterValues = ['all', 'recent', 'follow_up', 'stable'];

class PatientsView extends StatelessWidget {
  const PatientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DoctorPatientsViewModel>()..loadPatients(),
      child: const _PatientsViewBody(),
    );
  }
}

class _PatientsViewBody extends StatelessWidget {
  const _PatientsViewBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(
          onChanged: (query) =>
              context.read<DoctorPatientsViewModel>().onSearchChanged(query),
        ),
        const SizedBox(height: 26),
        FilterChips(
          filters: [
            'patients.filters.all'.tr(),
            'patients.filters.recent'.tr(),
            'patients.filters.followUp'.tr(),
            'patients.filters.stable'.tr(),
          ],
          onSelected: (index) {
            context
                .read<DoctorPatientsViewModel>()
                .onFilterChanged(_filterValues[index]);
          },
        ),
        const SizedBox(height: 16),
        Expanded(
          child: BlocBuilder<DoctorPatientsViewModel, DoctorPatientsState>(
            buildWhen: (previous, current) =>
                previous.patientsState != current.patientsState,
            builder: (context, state) {
              final patientsState = state.patientsState;
              if (patientsState.isLoading || patientsState.isInitial) {
                return const _PatientsLoadingWidget();
              }
              if (patientsState.isError) {
                return _PatientsErrorWidget(
                  message: patientsState.errorMessage ?? '',
                );
              }
              final patients = patientsState.data ?? const [];
              if (patients.isEmpty) {
                return const _PatientsEmptyWidget();
              }
              return _PatientsSuccessWidget(patients: patients);
            },
          ),
        ),
      ],
    );
  }
}

class _PatientsLoadingWidget extends StatelessWidget {
  const _PatientsLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemCount: 5,
        itemBuilder: (_, _) => ReservationCard(
          status: 'patients.filters.stable'.tr(),
          doctorName: 'Patient Name',
          subTitle: 'common.yearsOldMale'.tr(args: ['25']),
          time: 'patients.lastVisitTime'.tr(args: ['08:30']),
          actions: [
            ReservationActionButton(
              label: 'patients.viewProfile'.tr(),
              iconPath: AssetsManager.report,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientsErrorWidget extends StatelessWidget {
  final String message;

  const _PatientsErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
          IconButton(
            onPressed: () => context.read<DoctorPatientsViewModel>().retry(),
            icon: Icon(Icons.refresh, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}

class _PatientsEmptyWidget extends StatelessWidget {
  const _PatientsEmptyWidget();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Text(
        'patients.empty'.tr(),
        style: theme.regular14.copyWith(color: theme.textColor300),
      ),
    );
  }
}

class _PatientsSuccessWidget extends StatelessWidget {
  final List<DoctorPatientEntity> patients;

  const _PatientsSuccessWidget({required this.patients});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: context.appTheme.primaryColor,
      onRefresh: () => context.read<DoctorPatientsViewModel>().refresh(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          return DoctorPatientListCard(patient: patients[index]);
        },
      ),
    );
  }
}
