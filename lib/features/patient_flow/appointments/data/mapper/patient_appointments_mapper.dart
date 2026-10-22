import 'package:tabib_app/features/patient_flow/appointments/data/models/response/patient_appointments_response.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_appointment_entity.dart';

extension PatientAppointmentsResponseMapper on PatientAppointmentsResponse {
  List<PatientAppointmentEntity> toEntityList() {
    return data?.map((item) => item.toEntity()).toList() ?? const [];
  }
}

extension PatientAppointmentItemResponseMapper
    on PatientAppointmentItemResponse {
  PatientAppointmentEntity toEntity() {
    return PatientAppointmentEntity(
      id: id ?? '',
      status: status ?? '',
      date: date ?? '',
      startTime: startTime ?? '',
      endTime: endTime ?? '',
      consultationType: consultationType ?? '',
      bookingPrice: bookingPrice?.toDouble() ?? 0,
      currency: currency ?? '',
      durationChatHours: durationChatHours?.toInt() ?? 0,
      durationCallMinutes: durationCallMinutes?.toInt() ?? 0,
      complaint: complaint ?? '',
      symptoms: symptoms ?? '',
      notes: notes ?? '',
      cancelReason: cancelReason ?? '',
      createdAt: createdAt ?? '',
      actions: actions?.toEntity() ?? PatientAppointmentActionsEntity.empty,
      doctor: doctor?.toEntity() ??
          const PatientAppointmentDoctorEntity(
            id: '',
            fullNameAr: '',
            fullNameEn: '',
            avatarUrl: '',
            bookingPrice: 0,
            specialties: [],
          ),
    );
  }
}

extension PatientAppointmentDoctorResponseMapper
    on PatientAppointmentDoctorResponse {
  PatientAppointmentDoctorEntity toEntity() {
    return PatientAppointmentDoctorEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
      fullNameEn: fullNameEn ?? '',
      avatarUrl: avatarUrl ?? '',
      bookingPrice: bookingPrice?.toDouble() ?? 0,
      specialties: specialties ?? const [],
    );
  }
}

extension PatientAppointmentActionsResponseMapper
    on PatientAppointmentActionsResponse {
  PatientAppointmentActionsEntity toEntity() {
    return PatientAppointmentActionsEntity(
      canCancel: canCancel ?? false,
      canPay: canPay ?? false,
      canAccessChat: canAccessChat ?? false,
      canAccessCall: canAccessCall ?? false,
      canReview: canReview ?? false,
    );
  }
}
