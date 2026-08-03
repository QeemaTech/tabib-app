import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_certificate_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_clinic_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_review_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_specialty_entity.dart';

class DoctorDetailsEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String fullNameEn;
  final String avatarUrl;
  final String bioAr;
  final String bioEn;
  final int experienceYears;
  final double consultationFee;
  final double? feeChat;
  final double? feeVoice;
  final double? feeVideo;
  final int? durationChat;
  final int? durationVoice;
  final int? durationVideo;
  final double ratingAvg;
  final int ratingCount;
  final bool isOnline;
  final List<DoctorSpecialtyEntity> specialties;
  final DoctorClinicEntity? clinic;
  final List<DoctorCertificateEntity> certificates;
  final List<DoctorReviewEntity> reviews;

  const DoctorDetailsEntity({
    required this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.avatarUrl,
    required this.bioAr,
    required this.bioEn,
    required this.experienceYears,
    required this.consultationFee,
    this.feeChat,
    this.feeVoice,
    this.feeVideo,
    this.durationChat,
    this.durationVoice,
    this.durationVideo,
    required this.ratingAvg,
    required this.ratingCount,
    required this.isOnline,
    required this.specialties,
    this.clinic,
    required this.certificates,
    required this.reviews,
  });

  String localizedFullName(String languageCode) =>
      languageCode == 'ar' ? fullNameAr : fullNameEn;

  String localizedBio(String languageCode) {
    if (languageCode == 'ar') {
      return bioAr.isNotEmpty ? bioAr : bioEn;
    }
    return bioEn.isNotEmpty ? bioEn : bioAr;
  }

  @override
  List<Object?> get props => [
        id,
        fullNameAr,
        fullNameEn,
        avatarUrl,
        bioAr,
        bioEn,
        experienceYears,
        consultationFee,
        feeChat,
        feeVoice,
        feeVideo,
        durationChat,
        durationVoice,
        durationVideo,
        ratingAvg,
        ratingCount,
        isOnline,
        specialties,
        clinic,
        certificates,
        reviews,
      ];
}
