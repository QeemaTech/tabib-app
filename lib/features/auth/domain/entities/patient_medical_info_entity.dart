import 'package:equatable/equatable.dart';

class PatientMedicalInfoEntity extends Equatable {
  final String chronicConditions;
  final String currentMedications;
  final bool hasMedicationAllergy;
  final String allergyDetails;
  final List<String> files;

  const PatientMedicalInfoEntity({
    required this.chronicConditions,
    required this.currentMedications,
    required this.hasMedicationAllergy,
    required this.allergyDetails,
    required this.files,
  });

  @override
  List<Object?> get props => [
    chronicConditions,
    currentMedications,
    hasMedicationAllergy,
    allergyDetails,
    files,
  ];
}
