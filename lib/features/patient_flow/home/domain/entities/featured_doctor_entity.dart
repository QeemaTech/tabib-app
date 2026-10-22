import 'package:equatable/equatable.dart';

class FeaturedDoctorEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String fullNameEn;
  final String avatarUrl;
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
  final List<String> specialties;
  final String clinicName;
  final String? city;

  const FeaturedDoctorEntity({
    required this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.avatarUrl,
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
    required this.clinicName,
    this.city,
  });

  String localizedFullName(String languageCode) =>
      languageCode == 'ar' ? fullNameAr : fullNameEn;

  @override
  List<Object?> get props => [
        id,
        fullNameAr,
        fullNameEn,
        avatarUrl,
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
        clinicName,
        city,
      ];
}
