import 'package:equatable/equatable.dart';

class SearchDoctorEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String fullNameEn;
  final String avatarUrl;
  final int experienceYears;
  final double bookingPrice;
  final double consultationFee;
  final String currency;
  final int durationChatHours;
  final int durationCallMinutes;
  final List<String> channels;
  final double ratingAvg;
  final int ratingCount;
  final bool isOnline;
  final List<String> specialties;
  final String clinicName;
  final String city;

  const SearchDoctorEntity({
    required this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.avatarUrl,
    required this.experienceYears,
    required this.bookingPrice,
    required this.consultationFee,
    required this.currency,
    required this.durationChatHours,
    required this.durationCallMinutes,
    required this.channels,
    required this.ratingAvg,
    required this.ratingCount,
    required this.isOnline,
    required this.specialties,
    required this.clinicName,
    required this.city,
  });

  bool get hasAvatar => avatarUrl.trim().isNotEmpty;

  String localizedFullName(String languageCode) =>
      languageCode.startsWith('ar') && fullNameAr.isNotEmpty
          ? fullNameAr
          : (fullNameEn.isNotEmpty ? fullNameEn : fullNameAr);

  @override
  List<Object?> get props => [
        id,
        fullNameAr,
        fullNameEn,
        avatarUrl,
        experienceYears,
        bookingPrice,
        consultationFee,
        currency,
        durationChatHours,
        durationCallMinutes,
        channels,
        ratingAvg,
        ratingCount,
        isOnline,
        specialties,
        clinicName,
        city,
      ];
}

class SearchDoctorsResultEntity extends Equatable {
  final List<SearchDoctorEntity> doctors;
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  const SearchDoctorsResultEntity({
    required this.doctors,
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  @override
  List<Object?> get props => [doctors, page, limit, total, totalPages];
}
