import 'package:equatable/equatable.dart';

class PatientRecordDiagnosisEntity extends Equatable {
  final String id;
  final String code;
  final String descriptionAr;
  final String descriptionEn;

  const PatientRecordDiagnosisEntity({
    required this.id,
    required this.code,
    required this.descriptionAr,
    required this.descriptionEn,
  });

  String localizedDescription(String languageCode) {
    if (languageCode == 'ar' && descriptionAr.isNotEmpty) return descriptionAr;
    if (descriptionEn.isNotEmpty) return descriptionEn;
    return descriptionAr;
  }

  @override
  List<Object?> get props => [id, code, descriptionAr, descriptionEn];
}

class PatientRequestedTestEntity extends Equatable {
  final String id;
  final String titleAr;

  const PatientRequestedTestEntity({required this.id, required this.titleAr});

  @override
  List<Object?> get props => [id, titleAr];
}
