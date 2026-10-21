import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/records/domain/entities/patient_record_actions_entity.dart';
import 'package:tabib_app/features/records/domain/entities/patient_record_doctor_entity.dart';
import 'package:tabib_app/features/records/domain/entities/patient_record_medication_entity.dart';

class PatientPrescriptionDetailsEntity extends Equatable {
  final String screenTitleAr;
  final String screenTitleEn;
  final String referenceNumber;
  final String referenceLabelAr;
  final String referenceLabelEn;
  final PatientRecordDoctorEntity doctor;
  final String occurredAt;
  final String summaryAr;
  final String diagnosisAr;
  final List<PatientRecordMedicationEntity> medications;
  final PatientRecordActionsEntity actions;

  const PatientPrescriptionDetailsEntity({
    required this.screenTitleAr,
    required this.screenTitleEn,
    required this.referenceNumber,
    required this.referenceLabelAr,
    required this.referenceLabelEn,
    required this.doctor,
    required this.occurredAt,
    required this.summaryAr,
    required this.diagnosisAr,
    required this.medications,
    required this.actions,
  });

  String localizedScreenTitle(String languageCode) {
    if (languageCode == 'ar' && screenTitleAr.isNotEmpty) return screenTitleAr;
    if (screenTitleEn.isNotEmpty) return screenTitleEn;
    return screenTitleAr;
  }

  String localizedReferenceLabel(String languageCode) {
    if (languageCode == 'ar' && referenceLabelAr.isNotEmpty) {
      return referenceLabelAr;
    }
    if (referenceLabelEn.isNotEmpty) return referenceLabelEn;
    return referenceLabelAr;
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
    summaryAr,
    diagnosisAr,
    medications,
    actions,
  ];
}
