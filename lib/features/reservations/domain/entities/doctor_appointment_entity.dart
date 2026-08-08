import 'package:equatable/equatable.dart';

class DoctorAppointmentEntity extends Equatable {
  final String id;
  final String status;
  final String date;
  final String startTime;
  final String endTime;
  final String consultationType;
  final double bookingPrice;
  final String currency;
  final int durationChatHours;
  final int durationCallMinutes;
  final String complaint;
  final String symptoms;
  final String notes;
  final String cancelReason;
  final String createdAt;
  final String sessionStartsAt;
  final DoctorAppointmentAccessWindowsEntity accessWindows;
  final DoctorAppointmentPatientEntity patient;
  final DoctorAppointmentActionsEntity actions;
  final String cancelledBy;
  final String updatedAt;

  const DoctorAppointmentEntity({
    required this.id,
    required this.status,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.consultationType,
    required this.bookingPrice,
    required this.currency,
    required this.durationChatHours,
    required this.durationCallMinutes,
    required this.complaint,
    required this.symptoms,
    required this.notes,
    required this.cancelReason,
    required this.createdAt,
    required this.sessionStartsAt,
    required this.accessWindows,
    required this.patient,
    required this.actions,
    required this.cancelledBy,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        date,
        startTime,
        endTime,
        consultationType,
        bookingPrice,
        currency,
        durationChatHours,
        durationCallMinutes,
        complaint,
        symptoms,
        notes,
        cancelReason,
        createdAt,
        sessionStartsAt,
        accessWindows,
        patient,
        actions,
        cancelledBy,
        updatedAt,
      ];
}

class DoctorAppointmentPatientEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String fullNameEn;
  final String? avatarUrl;
  final String phone;
  final String countryCode;
  final String email;
  final String gender;
  final double? heightCm;
  final double? weightKg;
  final String medicalComplaint;
  final String medicalSymptoms;

  const DoctorAppointmentPatientEntity({
    required this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.avatarUrl,
    required this.phone,
    required this.countryCode,
    required this.email,
    required this.gender,
    this.heightCm,
    this.weightKg,
    required this.medicalComplaint,
    required this.medicalSymptoms,
  });

  bool get hasAvatar => avatarUrl != null && avatarUrl!.trim().isNotEmpty;

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
        phone,
        countryCode,
        email,
        gender,
        heightCm,
        weightKg,
        medicalComplaint,
        medicalSymptoms,
      ];
}

class DoctorAppointmentAccessWindowsEntity extends Equatable {
  final String sessionStartsAt;
  final DoctorAppointmentChatAccessEntity chat;
  final DoctorAppointmentCallAccessEntity call;

  const DoctorAppointmentAccessWindowsEntity({
    required this.sessionStartsAt,
    required this.chat,
    required this.call,
  });

  @override
  List<Object?> get props => [sessionStartsAt, chat, call];
}

class DoctorAppointmentChatAccessEntity extends Equatable {
  final String availableFrom;
  final String availableUntil;
  final bool isActive;
  final double remainingHours;

  const DoctorAppointmentChatAccessEntity({
    required this.availableFrom,
    required this.availableUntil,
    required this.isActive,
    required this.remainingHours,
  });

  @override
  List<Object?> get props => [
        availableFrom,
        availableUntil,
        isActive,
        remainingHours,
      ];
}

class DoctorAppointmentCallAccessEntity extends Equatable {
  final String availableFrom;
  final String availableUntil;
  final bool isActive;
  final int durationMinutes;
  final int usedSeconds;
  final int remainingSeconds;

  const DoctorAppointmentCallAccessEntity({
    required this.availableFrom,
    required this.availableUntil,
    required this.isActive,
    required this.durationMinutes,
    required this.usedSeconds,
    required this.remainingSeconds,
  });

  @override
  List<Object?> get props => [
        availableFrom,
        availableUntil,
        isActive,
        durationMinutes,
        usedSeconds,
        remainingSeconds,
      ];
}

class DoctorAppointmentActionsEntity extends Equatable {
  final bool canAccessChat;
  final bool canAccessCall;

  const DoctorAppointmentActionsEntity({
    required this.canAccessChat,
    required this.canAccessCall,
  });

  @override
  List<Object?> get props => [canAccessChat, canAccessCall];
}
