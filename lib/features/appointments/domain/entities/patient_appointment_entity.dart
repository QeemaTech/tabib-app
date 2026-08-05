import 'package:equatable/equatable.dart';

class PatientAppointmentEntity extends Equatable {
  final String id;
  final String status;
  final String date;
  final String startTime;
  final String endTime;
  final String consultationType;
  final String notes;
  final String cancelReason;
  final String createdAt;
  final PatientAppointmentDoctorEntity doctor;

  const PatientAppointmentEntity({
    required this.id,
    required this.status,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.consultationType,
    required this.notes,
    required this.cancelReason,
    required this.createdAt,
    required this.doctor,
  });

  PatientAppointmentEntity copyWith({
    String? id,
    String? status,
    String? date,
    String? startTime,
    String? endTime,
    String? consultationType,
    String? notes,
    String? cancelReason,
    String? createdAt,
    PatientAppointmentDoctorEntity? doctor,
  }) {
    return PatientAppointmentEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      consultationType: consultationType ?? this.consultationType,
      notes: notes ?? this.notes,
      cancelReason: cancelReason ?? this.cancelReason,
      createdAt: createdAt ?? this.createdAt,
      doctor: doctor ?? this.doctor,
    );
  }

  @override
  List<Object?> get props => [
        id,
        status,
        date,
        startTime,
        endTime,
        consultationType,
        notes,
        cancelReason,
        createdAt,
        doctor,
      ];
}

class PatientAppointmentDoctorEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String fullNameEn;
  final String avatarUrl;
  final double consultationFee;
  final List<String> specialties;

  const PatientAppointmentDoctorEntity({
    required this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.avatarUrl,
    required this.consultationFee,
    required this.specialties,
  });

  String localizedName(String languageCode) {
    if (languageCode == 'ar' && fullNameAr.isNotEmpty) {
      return fullNameAr;
    }
    if (fullNameEn.isNotEmpty) {
      return fullNameEn;
    }
    return fullNameAr;
  }

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
