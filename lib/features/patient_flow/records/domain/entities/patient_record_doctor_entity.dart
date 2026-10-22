import 'package:equatable/equatable.dart';

class PatientRecordDoctorEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String fullNameEn;
  final String avatarUrl;
  final String specialtyAr;
  final String specialtyEn;

  const PatientRecordDoctorEntity({
    required this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.avatarUrl,
    required this.specialtyAr,
    required this.specialtyEn,
  });

  const PatientRecordDoctorEntity.empty()
    : id = '',
      fullNameAr = '',
      fullNameEn = '',
      avatarUrl = '',
      specialtyAr = '',
      specialtyEn = '';

  String localizedName(String languageCode) {
    if (languageCode == 'ar' && fullNameAr.isNotEmpty) return fullNameAr;
    if (fullNameEn.isNotEmpty) return fullNameEn;
    return fullNameAr;
  }

  String localizedSpecialty(String languageCode) {
    if (languageCode == 'ar' && specialtyAr.isNotEmpty) return specialtyAr;
    if (specialtyEn.isNotEmpty) return specialtyEn;
    return specialtyAr;
  }

  @override
  List<Object?> get props => [
    id,
    fullNameAr,
    fullNameEn,
    avatarUrl,
    specialtyAr,
    specialtyEn,
  ];
}
