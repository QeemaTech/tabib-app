import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/theme/app_theme/theme_extension.dart';
import 'package:tabib_app/features/patients/presentation/widgets/expandable_section.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_card.dart';

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
        title: Text(
          'patients.details.title'.tr(),
          style: theme.bold18.copyWith(color: theme.textColor600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const PatientInfoCard(name: "أ. أحمد رمضان", id: "232345"),
            const SizedBox(height: 24),
            ExpandableSection(
              title: 'patients.details.patientInfo'.tr(),
              backgroundColor: const Color(0xFFE9EBF1),
              iconPath: AssetsManager.patientsActive,
              child: _buildPatientInfo(theme, const Color(0xFFE9EBF1)),
            ),
            ExpandableSection(
              title: 'patients.details.medicalOverview'.tr(),
              iconPath: AssetsManager.stethoscope,
              backgroundColor: const Color(0xFFE9EBF1),
              child: _buildMedicalOverview(theme, const Color(0xFFE9EBF1)),
            ),
            ExpandableSection(
              title: 'patients.details.visitHistory'.tr(),
              iconPath: AssetsManager.history,
              backgroundColor: const Color(0xFFE9EBF1),
              child: _buildVisitHistory(theme, const Color(0xFFE9EBF1)),
            ),
            ExpandableSection(
              title: 'patients.details.latestExaminations'.tr(),
              iconPath: AssetsManager.health,
              backgroundColor: const Color(0xFFEAF8F6),
              child: _buildLatestExaminations(theme, const Color(0xFFEAF8F6)),
            ),
            ExpandableSection(
              title: 'patients.details.medicalNotes'.tr(),
              backgroundColor: const Color(0xFFFEF9F0),
              iconPath: AssetsManager.document,
              child: _buildMedicalNotes(theme, const Color(0xFFFEF9F0)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfo(AppThemeExtension theme, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildInfoRow('patients.details.gender'.tr(), 'profile.male'.tr(), theme),
          _buildInfoRow('patients.details.birthDate'.tr(), "1 يناير (25 سنة)", theme),
          _buildInfoRow('patients.details.height'.tr(), "155 ${'patients.details.cm'.tr()}", theme),
          _buildInfoRow('patients.details.weight'.tr(), "60 ${'patients.details.kg'.tr()}", theme),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, AppThemeExtension theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
          Text(
            value,
            style: theme.medium16.copyWith(color: theme.textColor600),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalOverview(AppThemeExtension theme, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'patients.details.previousDiagnoses'.tr(),
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: [
              _buildChip('patients.details.highBloodPressure'.tr(), theme),
              _buildChip('patients.details.highBloodPressure'.tr(), theme),
              _buildChip('patients.details.asthma'.tr(), theme),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                "${'patients.details.bloodGroup'.tr()}: ",
                style: theme.regular14.copyWith(color: theme.textColor300),
              ),
              Text(
                "O+",
                style: theme.medium16.copyWith(color: theme.textColor600),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'patients.details.allergies'.tr(),
                style: theme.regular14.copyWith(color: theme.textColor300),
              ),
              const SizedBox(width: 8),
              Text(
                "${'patients.details.penicillin'.tr()}، ${'patients.details.latex'.tr()}",
                style: theme.medium16.copyWith(color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, AppThemeExtension theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: theme.medium13.copyWith(color: theme.primaryColor),
      ),
    );
  }

  Widget _buildVisitHistory(AppThemeExtension theme, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildVisitItem(
            'patients.details.annualCheckup'.tr(),
            '18 مايو، الاثنين',
            '10:30 م',
            theme,
          ),
          const Divider(),
          _buildVisitItem(
            'patients.details.annualCheckup'.tr(),
            '18 مايو، الاثنين',
            '10:30 م',
            theme,
          ),
        ],
      ),
    );
  }

  Widget _buildVisitItem(String title, String date, String time, AppThemeExtension theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.bold18.copyWith(fontSize: 14.0)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                "$date - $time",
                style: theme.regular12.copyWith(color: theme.textColor300),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios, size: 14),
                label: Text('patients.details.viewDetails'.tr()),
                style: TextButton.styleFrom(
                  iconAlignment: IconAlignment.end,
                  foregroundColor: theme.primaryColor,
                  padding: EdgeInsets.zero,
                ),
              ),
             
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLatestExaminations(AppThemeExtension theme, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: _buildVisitItem(
        'patients.details.mriScan'.tr(),
        '18 مايو، الاثنين',
        '10:30 م',
        theme,
      ),
    );
  }

  Widget _buildMedicalNotes(AppThemeExtension theme, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'patients.details.dummyNotes'.tr(),
        textAlign: TextAlign.start,
        style: theme.regular14.copyWith(color: theme.textColor600),
      ),
    );
  }
}
