import 'package:equatable/equatable.dart';

class DoctorReportEntity extends Equatable {
  final String appointmentId;
  final String medicalRecordId;
  final String visitTypeAr;
  final String bloodPressure;
  final String temperature;
  final String diagnosis;
  final List<DoctorReportMedicationEntity> medications;
  final List<DoctorReportTestEntity> requiredTests;
  final String followUpAr;
  final String medicalNotesAr;
  final String createdAt;

  const DoctorReportEntity({
    required this.appointmentId,
    required this.medicalRecordId,
    required this.visitTypeAr,
    required this.bloodPressure,
    required this.temperature,
    required this.diagnosis,
    required this.medications,
    required this.requiredTests,
    required this.followUpAr,
    required this.medicalNotesAr,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        appointmentId,
        medicalRecordId,
        visitTypeAr,
        bloodPressure,
        temperature,
        diagnosis,
        medications,
        requiredTests,
        followUpAr,
        medicalNotesAr,
        createdAt,
      ];
}

class DoctorReportMedicationEntity extends Equatable {
  final String id;
  final String drugNameAr;
  final String? drugNameEn;
  final String dosage;
  final String frequency;
  final String duration;
  final String? instructionsAr;

  const DoctorReportMedicationEntity({
    required this.id,
    required this.drugNameAr,
    required this.drugNameEn,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.instructionsAr,
  });

  @override
  List<Object?> get props => [
        id,
        drugNameAr,
        drugNameEn,
        dosage,
        frequency,
        duration,
        instructionsAr,
      ];
}

class DoctorReportTestEntity extends Equatable {
  final String id;
  final String titleAr;

  const DoctorReportTestEntity({
    required this.id,
    required this.titleAr,
  });

  @override
  List<Object?> get props => [id, titleAr];
}
