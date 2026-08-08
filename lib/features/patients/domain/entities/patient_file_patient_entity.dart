import 'package:equatable/equatable.dart';

class PatientFilePatientEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String gender;
  final String bloodType;
  final String allergies;
  final String chronicConditions;
  final String phone;

  const PatientFilePatientEntity({
    required this.id,
    required this.fullNameAr,
    required this.gender,
    required this.bloodType,
    required this.allergies,
    required this.chronicConditions,
    required this.phone,
  });

  @override
  List<Object?> get props => [
        id,
        fullNameAr,
        gender,
        bloodType,
        allergies,
        chronicConditions,
        phone,
      ];
}
