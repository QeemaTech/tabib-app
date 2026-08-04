import 'package:equatable/equatable.dart';

class AppointmentEntity extends Equatable {
  final String id;
  final String status;
  final String date;
  final String startTime;
  final String endTime;
  final String consultationType;
  final double quotedFee;
  final int durationMinutes;
  final double platformFeePercent;
  final String notes;
  final String cancelReason;
  final String createdAt;
  final AppointmentDoctorEntity doctor;

  const AppointmentEntity({
    required this.id,
    required this.status,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.consultationType,
    required this.quotedFee,
    required this.durationMinutes,
    required this.platformFeePercent,
    required this.notes,
    required this.cancelReason,
    required this.createdAt,
    required this.doctor,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        date,
        startTime,
        endTime,
        consultationType,
        quotedFee,
        durationMinutes,
        platformFeePercent,
        notes,
        cancelReason,
        createdAt,
        doctor,
      ];
}

class AppointmentDoctorEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String fullNameEn;
  final String avatarUrl;
  final double consultationFee;
  final List<String> specialties;

  const AppointmentDoctorEntity({
    required this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.avatarUrl,
    required this.consultationFee,
    required this.specialties,
  });

  @override
  List<Object?> get props => [
        id,
        fullNameAr,
        fullNameEn,
        avatarUrl,
        consultationFee,
        specialties,
      ];
}
