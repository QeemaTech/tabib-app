import 'package:equatable/equatable.dart';

class DoctorSpecialtyRefEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;

  const DoctorSpecialtyRefEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}

class DoctorProfessionalEntity extends Equatable {
  final int experienceYears;
  final String professionalTitle;
  final String professionalTitleAr;
  final DoctorSpecialtyRefEntity? mainSpecialty;
  final List<DoctorSpecialtyRefEntity> subSpecialties;
  final double consultationFee;
  final double? feeChat;
  final double? feeVoice;
  final double? feeVideo;
  final int? durationChat;
  final int? durationVoice;
  final int? durationVideo;

  const DoctorProfessionalEntity({
    required this.experienceYears,
    required this.professionalTitle,
    required this.professionalTitleAr,
    this.mainSpecialty,
    required this.subSpecialties,
    required this.consultationFee,
    this.feeChat,
    this.feeVoice,
    this.feeVideo,
    this.durationChat,
    this.durationVoice,
    this.durationVideo,
  });

  @override
  List<Object?> get props => [
        experienceYears,
        professionalTitle,
        professionalTitleAr,
        mainSpecialty,
        subSpecialties,
        consultationFee,
        feeChat,
        feeVoice,
        feeVideo,
        durationChat,
        durationVoice,
        durationVideo,
      ];
}
