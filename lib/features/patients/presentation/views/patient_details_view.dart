import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patients/presentation/view_model/patient_file_state.dart';
import 'package:tabib_app/features/patients/presentation/view_model/patient_file_view_model.dart';
import 'package:tabib_app/features/patients/presentation/widgets/expandable_section.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_details_content.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_card.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_details.dart';

class PatientDetailsView extends StatelessWidget {
  const PatientDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.textColor600, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'patients.details.title'.tr(),
          style: theme.bold18.copyWith(color: theme.textColor600),
        ),
      ),
      body: BlocBuilder<PatientFileViewModel, PatientFileState>(
        builder: (context, state) {
          final fileState = state.fileState;
          if (fileState.isLoading || fileState.isInitial) {
            return const _PatientDetailsLoadingWidget();
          }
          if (fileState.isError) {
            return _PatientDetailsErrorWidget(
              message: fileState.errorMessage ?? '----',
            );
          }
          final data = fileState.data;
          if (data == null) {
            return const _PatientDetailsErrorWidget(message: '----');
          }
          return PatientDetailsContent(file: data);
        },
      ),
    );
  }
}

class _PatientDetailsLoadingWidget extends StatelessWidget {
  const _PatientDetailsLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const PatientInfoCard(name: '----', id: '----'),
            const SizedBox(height: 24),
            ExpandableSection(
              title: 'patients.details.patientInfo'.tr(),
              backgroundColor: const Color(0xFFE9EBF1),
              iconPath: AssetsManager.patientsActive,
              child: const PatientInfoDetails(
                gender: '----',
                birthDate: '----',
                height: '----',
                weight: '----',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientDetailsErrorWidget extends StatelessWidget {
  final String message;

  const _PatientDetailsErrorWidget({required this.message});

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
            onPressed: () => context.read<PatientFileViewModel>().retry(),
            icon: Icon(Icons.refresh, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
