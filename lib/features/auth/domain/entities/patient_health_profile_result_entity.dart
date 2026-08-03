import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/auth/domain/entities/health_profile_file_entity.dart';

class PatientHealthProfileResultEntity extends Equatable {
  final String dateOfBirth;
  final String gender;
  final int heightCm;
  final int weightKg;
  final List<HealthProfileFileEntity> files;

  const PatientHealthProfileResultEntity({
    required this.dateOfBirth,
    required this.gender,
    required this.heightCm,
    required this.weightKg,
    required this.files,
  });

  @override
  List<Object?> get props => [
    dateOfBirth,
    gender,
    heightCm,
    weightKg,
    files,
  ];
}
