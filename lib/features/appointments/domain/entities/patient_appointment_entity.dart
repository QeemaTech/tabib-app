import 'package:equatable/equatable.dart';

class PatientAppointmentActionsEntity extends Equatable {
  final bool canCancel;
  final bool canPay;
  final bool canAccessChat;
  final bool canAccessCall;
  final bool canReview;

  const PatientAppointmentActionsEntity({
    required this.canCancel,
    required this.canPay,
    required this.canAccessChat,
    required this.canAccessCall,
    required this.canReview,
  });

  static const empty = PatientAppointmentActionsEntity(
    canCancel: false,
    canPay: false,
    canAccessChat: false,
    canAccessCall: false,
    canReview: false,
  );

  @override
  List<Object?> get props => [
        canCancel,
        canPay,
        canAccessChat,
        canAccessCall,
        canReview,
      ];
}

class PatientAppointmentEntity extends Equatable {
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
  final PatientAppointmentActionsEntity actions;
  final PatientAppointmentDoctorEntity doctor;

  const PatientAppointmentEntity({
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
    required this.actions,
    required this.doctor,
  });

  PatientAppointmentEntity copyWith({
    String? id,
    String? status,
    String? date,
    String? startTime,
    String? endTime,
    String? consultationType,
    double? bookingPrice,
    String? currency,
    int? durationChatHours,
    int? durationCallMinutes,
    String? complaint,
    String? symptoms,
    String? notes,
    String? cancelReason,
    String? createdAt,
    PatientAppointmentActionsEntity? actions,
    PatientAppointmentDoctorEntity? doctor,
  }) {
    return PatientAppointmentEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      consultationType: consultationType ?? this.consultationType,
      bookingPrice: bookingPrice ?? this.bookingPrice,
      currency: currency ?? this.currency,
      durationChatHours: durationChatHours ?? this.durationChatHours,
      durationCallMinutes: durationCallMinutes ?? this.durationCallMinutes,
      complaint: complaint ?? this.complaint,
      symptoms: symptoms ?? this.symptoms,
      notes: notes ?? this.notes,
      cancelReason: cancelReason ?? this.cancelReason,
      createdAt: createdAt ?? this.createdAt,
      actions: actions ?? this.actions,
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
        bookingPrice,
        currency,
        durationChatHours,
        durationCallMinutes,
        complaint,
        symptoms,
        notes,
        cancelReason,
        createdAt,
        actions,
        doctor,
      ];
}

class PatientAppointmentDoctorEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String fullNameEn;
  final String avatarUrl;
  final double bookingPrice;
  final List<String> specialties;

  const PatientAppointmentDoctorEntity({
    required this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.avatarUrl,
    required this.bookingPrice,
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
        bookingPrice,
        specialties,
      ];
}
