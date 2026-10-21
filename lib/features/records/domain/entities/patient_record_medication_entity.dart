import 'package:equatable/equatable.dart';

class PatientRecordMedicationEntity extends Equatable {
  final String id;
  final String drugNameAr;
  final String drugNameEn;
  final String formAr;
  final String doseAr;
  final String frequencyAr;
  final String timingAr;
  final String durationAr;
  final String noteAr;

  const PatientRecordMedicationEntity({
    required this.id,
    required this.drugNameAr,
    required this.drugNameEn,
    required this.formAr,
    required this.doseAr,
    required this.frequencyAr,
    required this.timingAr,
    required this.durationAr,
    required this.noteAr,
  });

  String localizedName(String languageCode) {
    if (languageCode == 'ar' && drugNameAr.isNotEmpty) return drugNameAr;
    if (drugNameEn.isNotEmpty) return drugNameEn;
    return drugNameAr;
  }

  @override
  List<Object?> get props => [
    id,
    drugNameAr,
    drugNameEn,
    formAr,
    doseAr,
    frequencyAr,
    timingAr,
    durationAr,
    noteAr,
  ];
}
