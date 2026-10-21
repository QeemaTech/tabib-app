import 'package:equatable/equatable.dart';

class PatientProfileEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String fullNameEn;
  final String fullNameSo;
  final String dateOfBirth;
  final String gender;
  final int heightCm;
  final int weightKg;
  final String avatarUrl;
  final String bloodType;
  final String allergies;
  final String chronicConditions;
  final String currentMedications;
  final bool hasMedicationAllergy;
  final String phone;
  final String email;
  final bool isVerified;

  const PatientProfileEntity({
    required this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.fullNameSo,
    required this.dateOfBirth,
    required this.gender,
    required this.heightCm,
    required this.weightKg,
    required this.avatarUrl,
    required this.bloodType,
    required this.allergies,
    required this.chronicConditions,
    required this.currentMedications,
    required this.hasMedicationAllergy,
    required this.phone,
    required this.email,
    required this.isVerified,
  });

  bool get hasAvatar => avatarUrl.trim().isNotEmpty;

  String localizedName(String languageCode) {
    if (languageCode.startsWith('ar') && fullNameAr.isNotEmpty) {
      return fullNameAr;
    }
    if (languageCode.startsWith('so') && fullNameSo.isNotEmpty) {
      return fullNameSo;
    }
    if (fullNameEn.isNotEmpty) return fullNameEn;
    if (fullNameAr.isNotEmpty) return fullNameAr;
    if (fullNameSo.isNotEmpty) return fullNameSo;
    return '';
  }

  int? get age {
    if (dateOfBirth.isEmpty) return null;
    final birthDate = DateTime.tryParse(dateOfBirth);
    if (birthDate == null) return null;
    final now = DateTime.now();
    var years = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      years--;
    }
    return years;
  }

  PatientProfileEntity copyWith({
    String? id,
    String? fullNameAr,
    String? fullNameEn,
    String? fullNameSo,
    String? dateOfBirth,
    String? gender,
    int? heightCm,
    int? weightKg,
    String? avatarUrl,
    String? bloodType,
    String? allergies,
    String? chronicConditions,
    String? currentMedications,
    bool? hasMedicationAllergy,
    String? phone,
    String? email,
    bool? isVerified,
  }) {
    return PatientProfileEntity(
      id: id ?? this.id,
      fullNameAr: fullNameAr ?? this.fullNameAr,
      fullNameEn: fullNameEn ?? this.fullNameEn,
      fullNameSo: fullNameSo ?? this.fullNameSo,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bloodType: bloodType ?? this.bloodType,
      allergies: allergies ?? this.allergies,
      chronicConditions: chronicConditions ?? this.chronicConditions,
      currentMedications: currentMedications ?? this.currentMedications,
      hasMedicationAllergy:
          hasMedicationAllergy ?? this.hasMedicationAllergy,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullNameAr,
        fullNameEn,
        fullNameSo,
        dateOfBirth,
        gender,
        heightCm,
        weightKg,
        avatarUrl,
        bloodType,
        allergies,
        chronicConditions,
        currentMedications,
        hasMedicationAllergy,
        phone,
        email,
        isVerified,
      ];
}
