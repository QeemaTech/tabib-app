import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/utilities/app_validator.dart';
import 'package:tabib_app/features/reservations/presentation/widgets/custom_expansion_tile.dart';
import 'package:tabib_app/features/reservations/presentation/widgets/report_input_widgets.dart';

class CreateReportFormSections extends StatelessWidget {
  final TextEditingController visitTypeController;
  final TextEditingController bloodPressureController;
  final TextEditingController temperatureController;
  final TextEditingController diagnosisController;
  final TextEditingController drugNameController;
  final TextEditingController dosageController;
  final TextEditingController frequencyController;
  final TextEditingController durationController;
  final TextEditingController testsController;
  final TextEditingController followUpController;
  final TextEditingController notesController;

  const CreateReportFormSections({
    super.key,
    required this.visitTypeController,
    required this.bloodPressureController,
    required this.temperatureController,
    required this.diagnosisController,
    required this.drugNameController,
    required this.dosageController,
    required this.frequencyController,
    required this.durationController,
    required this.testsController,
    required this.followUpController,
    required this.notesController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomExpansionTile(
          title: 'reservations.visitInfo'.tr(),
          iconPath: AssetsManager.stethoscope,
          children: [
            ReportFieldLabel(label: 'reservations.visitType'.tr()),
            ReportTextField(
              hint: 'reservations.consultation',
              controller: visitTypeController,
              validator: AppValidator.shouldEnter,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReportFieldLabel(
                        label: 'reservations.bloodPressure'.tr(),
                      ),
                      ReportTextField(
                        hint: '120/80',
                        controller: bloodPressureController,
                        validator: AppValidator.shouldEnter,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReportFieldLabel(
                        label: 'reservations.temperature'.tr(),
                      ),
                      ReportTextField(
                        hint: '36.6',
                        controller: temperatureController,
                        validator: AppValidator.shouldEnter,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        CustomExpansionTile(
          title: 'reservations.diagnosis'.tr(),
          iconPath: AssetsManager.health,
          children: [
            ReportFieldLabel(label: 'reservations.finalDiagnosis'.tr()),
            ReportTextField(
              hint: 'reservations.diagnosisDetails'.tr(),
              maxLines: 4,
              controller: diagnosisController,
              validator: AppValidator.shouldEnter,
            ),
          ],
        ),
        const SizedBox(height: 12),
        CustomExpansionTile(
          title: 'reservations.treatmentPlan'.tr(),
          iconPath: AssetsManager.alba,
          children: [
            ReportFieldLabel(label: 'reservations.addMedications'.tr()),
            ReportTextField(
              hint: 'reservations.itemName'.tr(),
              controller: drugNameController,
              validator: AppValidator.shouldEnter,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReportFieldLabel(label: 'reservations.dose'.tr()),
                      ReportTextField(
                        hint: 'reservations.dose'.tr(),
                        controller: dosageController,
                        validator: AppValidator.shouldEnter,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReportFieldLabel(label: 'reservations.frequency'.tr()),
                      ReportTextField(
                        hint: 'reservations.frequency'.tr(),
                        controller: frequencyController,
                        validator: AppValidator.shouldEnter,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ReportFieldLabel(label: 'reservations.duration'.tr()),
            ReportTextField(
              hint: 'reservations.duration'.tr(),
              controller: durationController,
              validator: AppValidator.shouldEnter,
            ),
          ],
        ),
        const SizedBox(height: 12),
        CustomExpansionTile(
          title: 'reservations.requiredTests'.tr(),
          iconPath: AssetsManager.document,
          children: [
            ReportTextField(
              hint: 'reservations.tests'.tr(),
              controller: testsController,
              maxLines: 3,
              validator: AppValidator.shouldEnter,
            ),
          ],
        ),
        const SizedBox(height: 12),
        CustomExpansionTile(
          title: 'reservations.followUpDate'.tr(),
          iconPath: AssetsManager.appointments,
          children: [
            ReportTextField(
              hint: 'reservations.chooseDate'.tr(),
              controller: followUpController,
              validator: AppValidator.shouldEnter,
            ),
          ],
        ),
        const SizedBox(height: 12),
        CustomExpansionTile(
          title: 'reservations.medicalNotes'.tr(),
          iconPath: AssetsManager.report,
          children: [
            ReportTextField(
              hint: 'reservations.notes'.tr(),
              maxLines: 3,
              controller: notesController,
              validator: AppValidator.shouldEnter,
            ),
          ],
        ),
      ],
    );
  }
}
