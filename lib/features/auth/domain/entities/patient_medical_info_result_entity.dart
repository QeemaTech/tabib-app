import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/auth/domain/entities/health_profile_file_entity.dart';

class PatientMedicalInfoResultEntity extends Equatable {
  final String chronicConditions;
  final String currentMedications;
  final bool hasMedicationAllergy;
  final String allergyDetails;
  final List<HealthProfileFileEntity> files;

  const PatientMedicalInfoResultEntity({
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
