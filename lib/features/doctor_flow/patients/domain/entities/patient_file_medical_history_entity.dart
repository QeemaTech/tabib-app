import 'package:equatable/equatable.dart';

class PatientFileMedicalHistoryEntity extends Equatable {
  final String id;
  final String date;
  final String summaryAr;
  final List<String> diagnoses;
  final int prescriptions;

  const PatientFileMedicalHistoryEntity({
    required this.id,
    required this.date,
    required this.summaryAr,
    required this.diagnoses,
    required this.prescriptions,
  });

  @override
  List<Object?> get props => [id, date, summaryAr, diagnoses, prescriptions];
}
