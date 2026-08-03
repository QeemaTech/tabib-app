import 'package:equatable/equatable.dart';

class PatientHealthProfileEntity extends Equatable {
  final String dateOfBirth;
  final String gender;
  final int heightCm;
  final int weightKg;
  final List<String> files;

  const PatientHealthProfileEntity({
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
