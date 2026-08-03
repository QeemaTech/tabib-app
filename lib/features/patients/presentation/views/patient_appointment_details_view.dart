import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patients/presentation/widgets/appointment_info_details.dart';
import 'package:tabib_app/features/patients/presentation/widgets/expandable_section.dart';
import 'package:tabib_app/features/patients/presentation/widgets/medical_note_card.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_card.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_details.dart';

class PatientsAppointmentDetailsView extends StatelessWidget {
  const PatientsAppointmentDetailsView({super.key});

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
          'patients.appointmentDetails.title'.tr(),
          style: theme.bold18.copyWith(color: theme.textColor600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            PatientInfoCard(
              name: 'appointments.drName'.tr(),
              id: '232345',
            ),
            const SizedBox(height: 16),
            ExpandableSection(
              title: 'patients.appointmentDetails.patientInfo'.tr(),
              backgroundColor: const Color(0xFFE9EBF1),
              iconPath: AssetsManager.patientsActive,
              child: PatientInfoDetails(
                gender: 'profile.female'.tr(),
                birthDate: '1 يناير (26 سنة)',
                height: '155 ${'patients.details.cm'.tr()}',
                weight: '60 ${'patients.details.kg'.tr()}',
              ),
            ),
            ExpandableSection(
              title: 'patients.appointmentDetails.appointmentTime'.tr(),
              backgroundColor: const Color(0xFFE9EBF1),
              iconPath: AssetsManager.appointmentsActive,
              child: const AppointmentInfoDetails(
                date: '15 فبراير 2026',
                time: '10:00 صباحاً',
                day: 'السبت',
                month: 'فبراير',
                dayNumber: '15',
              ),
            ),
            ExpandableSection(
              title: 'patients.appointmentDetails.symptoms'.tr(),
              isExpanded: true,
              backgroundColor: const Color(0xFFFEF9F0),
              iconPath: AssetsManager.document,
              child: Column(
                children: [
                  MedicalNoteCard(
                    note: 'patients.details.dummyNotes'.tr(),
                    date: '18 يناير، الاثنين • 10:30 م',
                  ),
                  MedicalNoteCard(
                    note: 'patients.details.dummyNotes'.tr(),
                    date: '18 يناير، الاثنين • 10:30 م',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
