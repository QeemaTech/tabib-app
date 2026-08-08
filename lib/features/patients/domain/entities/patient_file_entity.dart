import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/patients/domain/entities/patient_file_appointment_entity.dart';
import 'package:tabib_app/features/patients/domain/entities/patient_file_medical_history_entity.dart';
import 'package:tabib_app/features/patients/domain/entities/patient_file_patient_entity.dart';

class PatientFileEntity extends Equatable {
  final PatientFilePatientEntity patient;
  final PatientFileAppointmentEntity appointment;
  final List<PatientFileMedicalHistoryEntity> medicalHistory;

  const PatientFileEntity({
    required this.patient,
    required this.appointment,
    required this.medicalHistory,
  });

  @override
  List<Object?> get props => [patient, appointment, medicalHistory];
}
