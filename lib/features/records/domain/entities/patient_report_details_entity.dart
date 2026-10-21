import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/records/domain/entities/patient_record_actions_entity.dart';
import 'package:tabib_app/features/records/domain/entities/patient_record_diagnosis_entity.dart';
import 'package:tabib_app/features/records/domain/entities/patient_record_doctor_entity.dart';

class PatientReportDetailsEntity extends Equatable {
  final String screenTitleAr;
  final String screenTitleEn;
  final String referenceNumber;
  final String referenceLabelAr;
  final String referenceLabelEn;
  final PatientRecordDoctorEntity doctor;
  final String occurredAt;
  final String diagnosisAr;
  final List<PatientRecordDiagnosisEntity> diagnoses;
  final String visitTypeAr;
  final String bloodPressure;
  final String temperature;
  final String followUpAr;
  final String medicalNotesAr;
  final List<PatientRequestedTestEntity> requestedTests;
  final int prescriptionsCount;
  final PatientRecordActionsEntity actions;

  const PatientReportDetailsEntity({
    required this.screenTitleAr,
    required this.screenTitleEn,
    required this.referenceNumber,
    required this.referenceLabelAr,
    required this.referenceLabelEn,
    required this.doctor,
    required this.occurredAt,
    required this.diagnosisAr,
    required this.diagnoses,
    required this.visitTypeAr,
    required this.bloodPressure,
    required this.temperature,
    required this.followUpAr,
    required this.medicalNotesAr,
    required this.requestedTests,
    required this.prescriptionsCount,
    required this.actions,
  });

  String localizedScreenTitle(String languageCode) {
    return _localized(languageCode, screenTitleAr, screenTitleEn);
  }

  String localizedReferenceLabel(String languageCode) {
    return _localized(languageCode, referenceLabelAr, referenceLabelEn);
  }

  String displayDiagnosis(String languageCode) {
    if (diagnosisAr.isNotEmpty) return diagnosisAr;
    if (diagnoses.isEmpty) return '';
    return diagnoses.first.localizedDescription(languageCode);
  }

  @override
  List<Object?> get props => [
    screenTitleAr,
    screenTitleEn,
    referenceNumber,
    referenceLabelAr,
    referenceLabelEn,
    doctor,
    occurredAt,
    diagnosisAr,
    diagnoses,
    visitTypeAr,
    bloodPressure,
    temperature,
    followUpAr,
    medicalNotesAr,
    requestedTests,
    prescriptionsCount,
    actions,
  ];
}

String _localized(String languageCode, String arabic, String english) {
  if (languageCode == 'ar' && arabic.isNotEmpty) return arabic;
  if (english.isNotEmpty) return english;
  return arabic;
}
