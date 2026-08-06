import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/create_report_state.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/create_report_view_model.dart';
import 'package:tabib_app/features/reservations/presentation/widgets/create_report_form_sections.dart';
import 'package:tabib_app/features/reservations/presentation/widgets/patient_report_header.dart';

class CreateReportForm extends StatefulWidget {
  final DoctorAppointmentEntity appointment;

  const CreateReportForm({super.key, required this.appointment});

  @override
  State<CreateReportForm> createState() => _CreateReportFormState();
}

class _CreateReportFormState extends State<CreateReportForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _visitTypeController;
  late final TextEditingController _bloodPressureController;
  late final TextEditingController _temperatureController;
  late final TextEditingController _diagnosisController;
  late final TextEditingController _drugNameController;
  late final TextEditingController _dosageController;
  late final TextEditingController _frequencyController;
  late final TextEditingController _durationController;
  late final TextEditingController _testsController;
  late final TextEditingController _followUpController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _visitTypeController = TextEditingController();
    _bloodPressureController = TextEditingController();
    _temperatureController = TextEditingController();
    _diagnosisController = TextEditingController();
    _drugNameController = TextEditingController();
    _dosageController = TextEditingController();
    _frequencyController = TextEditingController();
    _durationController = TextEditingController();
    _testsController = TextEditingController();
    _followUpController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _visitTypeController.dispose();
    _bloodPressureController.dispose();
    _temperatureController.dispose();
    _diagnosisController.dispose();
    _drugNameController.dispose();
    _dosageController.dispose();
    _frequencyController.dispose();
    _durationController.dispose();
    _testsController.dispose();
    _followUpController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      // show error message
      CustomToast.show(
        context,
        message: 'Please fill all fields',
        status: ToastStatus.error,
      );
      return;
    }

    context.read<CreateReportViewModel>().submit(
      visitTypeAr: _visitTypeController.text,
      bloodPressure: _bloodPressureController.text,
      temperature: _temperatureController.text,
      diagnosis: _diagnosisController.text,
      drugNameAr: _drugNameController.text,
      dosage: _dosageController.text,
      frequency: _frequencyController.text,
      duration: _durationController.text,
      requiredTestsText: _testsController.text,
      followUpAr: _followUpController.text,
      medicalNotesAr: _notesController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;
    final appointment = widget.appointment;
    final name = appointment.patient.localizedFullName(languageCode);

    return BlocBuilder<CreateReportViewModel, CreateReportState>(
      buildWhen: (previous, current) =>
          previous.submitState != current.submitState,
      builder: (context, state) {
        final isSubmitting = state.submitState.isLoading;
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                PatientReportHeader(
                  name: name,
                  id: appointment.patient.id,
                  date: appointment.date,
                  time: appointment.startTime,
                  image: appointment.patient.avatarUrl,
                ),
                const SizedBox(height: 16),
                CreateReportFormSections(
                  visitTypeController: _visitTypeController,
                  bloodPressureController: _bloodPressureController,
                  temperatureController: _temperatureController,
                  diagnosisController: _diagnosisController,
                  drugNameController: _drugNameController,
                  dosageController: _dosageController,
                  frequencyController: _frequencyController,
                  durationController: _durationController,
                  testsController: _testsController,
                  followUpController: _followUpController,
                  notesController: _notesController,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isSubmitting ? null : _onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: isSubmitting
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: theme.whiteColor,
                            ),
                          )
                        : Text(
                            'reservations.createReportBtn'.tr(),
                            style: theme.bold18.copyWith(
                              color: theme.whiteColor,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
