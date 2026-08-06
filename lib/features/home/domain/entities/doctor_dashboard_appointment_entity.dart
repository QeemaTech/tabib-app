import 'package:equatable/equatable.dart';

class DoctorDashboardAppointmentEntity extends Equatable {
  final String id;
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final String consultationType;
  final double bookingPrice;
  final String currency;
  final String sessionStartsAt;
  final int durationChatHours;
  final int durationCallMinutes;
  final DoctorDashboardAccessWindowsEntity accessWindows;
  final DoctorDashboardActionsEntity actions;
  final String createdAt;
  final DoctorDashboardPatientEntity patient;

  const DoctorDashboardAppointmentEntity({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.consultationType,
    required this.bookingPrice,
    required this.currency,
    required this.sessionStartsAt,
    required this.durationChatHours,
    required this.durationCallMinutes,
    required this.accessWindows,
    required this.actions,
    required this.createdAt,
    required this.patient,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        startTime,
        endTime,
        status,
        consultationType,
        bookingPrice,
        currency,
        sessionStartsAt,
        durationChatHours,
        durationCallMinutes,
        accessWindows,
        actions,
        createdAt,
        patient,
      ];
}

class DoctorDashboardPatientEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String avatarUrl;
  final String phone;
  final String countryCode;

  const DoctorDashboardPatientEntity({
    required this.id,
    required this.fullNameAr,
    required this.avatarUrl,
    required this.phone,
    required this.countryCode,
  });

  @override
  List<Object?> get props => [id, fullNameAr, avatarUrl, phone, countryCode];
}

class DoctorDashboardAccessWindowsEntity extends Equatable {
  final DoctorDashboardChatAccessEntity chat;
  final DoctorDashboardCallAccessEntity call;

  const DoctorDashboardAccessWindowsEntity({
    required this.chat,
    required this.call,
  });

  @override
  List<Object?> get props => [chat, call];
}

class DoctorDashboardChatAccessEntity extends Equatable {
  final bool isActive;
  final double remainingHours;

  const DoctorDashboardChatAccessEntity({
    required this.isActive,
    required this.remainingHours,
  });

  @override
  List<Object?> get props => [isActive, remainingHours];
}

class DoctorDashboardCallAccessEntity extends Equatable {
  final bool isActive;
  final int durationMinutes;
  final int usedSeconds;
  final int remainingSeconds;

  const DoctorDashboardCallAccessEntity({
    required this.isActive,
    required this.durationMinutes,
    required this.usedSeconds,
    required this.remainingSeconds,
  });

  @override
  List<Object?> get props => [
        isActive,
        durationMinutes,
        usedSeconds,
        remainingSeconds,
      ];
}

class DoctorDashboardActionsEntity extends Equatable {
  final bool canAccessChat;
  final bool canAccessCall;

  const DoctorDashboardActionsEntity({
    required this.canAccessChat,
    required this.canAccessCall,
  });

  @override
  List<Object?> get props => [canAccessChat, canAccessCall];
}
