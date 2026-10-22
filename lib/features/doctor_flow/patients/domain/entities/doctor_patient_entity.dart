import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/doctor_flow/patients/domain/entities/doctor_patient_last_visit_entity.dart';

class DoctorPatientEntity extends Equatable {
  final String id;
  final String displayId;
  final String fullNameAr;
  final String fullNameEn;
  final String? avatarUrl;
  final int age;
  final String gender;
  final String genderLabelAr;
  final String status;
  final String statusLabelAr;
  final DoctorPatientLastVisitEntity? lastVisit;
  final bool hasReport;

  const DoctorPatientEntity({
    required this.id,
    required this.displayId,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.avatarUrl,
    required this.age,
    required this.gender,
    required this.genderLabelAr,
    required this.status,
    required this.statusLabelAr,
    required this.lastVisit,
    required this.hasReport,
  });

  bool get hasAvatar => avatarUrl != null && avatarUrl!.trim().isNotEmpty;

  String localizedFullName(String languageCode) =>
      languageCode.startsWith('ar') && fullNameAr.isNotEmpty
          ? fullNameAr
          : (fullNameEn.isNotEmpty ? fullNameEn : fullNameAr);

  @override
  List<Object?> get props => [
        id,
        displayId,
        fullNameAr,
        fullNameEn,
        avatarUrl,
        age,
        gender,
        genderLabelAr,
        status,
        statusLabelAr,
        lastVisit,
        hasReport,
      ];
}
