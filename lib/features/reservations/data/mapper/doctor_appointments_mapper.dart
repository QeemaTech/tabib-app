import 'package:tabib_app/features/reservations/data/models/response/doctor_appointments_response.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_appointment_entity.dart';

extension DoctorAppointmentsResponseMapper on DoctorAppointmentsResponse {
  List<DoctorAppointmentEntity> toEntity() {
    return data?.map((item) => item.toEntity()).toList() ?? const [];
  }
}

extension DoctorAppointmentDetailsResponseMapper
    on DoctorAppointmentDetailsResponse {
  DoctorAppointmentEntity toEntity() {
    return data?.toEntity() ??
        const DoctorAppointmentEntity(
          id: '',
          status: '',
          date: '',
          startTime: '',
          endTime: '',
          consultationType: '',
          bookingPrice: 0,
          currency: '',
          durationChatHours: 0,
          durationCallMinutes: 0,
          notes: '',
          cancelReason: '',
          createdAt: '',
          sessionStartsAt: '',
          accessWindows: DoctorAppointmentAccessWindowsEntity(
            sessionStartsAt: '',
            chat: DoctorAppointmentChatAccessEntity(
              availableFrom: '',
              availableUntil: '',
              isActive: false,
              remainingHours: 0,
            ),
            call: DoctorAppointmentCallAccessEntity(
              availableFrom: '',
              availableUntil: '',
              isActive: false,
              durationMinutes: 0,
              usedSeconds: 0,
              remainingSeconds: 0,
            ),
          ),
          patient: DoctorAppointmentPatientEntity(
            id: '',
            fullNameAr: '',
            fullNameEn: '',
            avatarUrl: null,
            phone: '',
            countryCode: '',
            email: '',
          ),
          actions: DoctorAppointmentActionsEntity(
            canAccessChat: false,
            canAccessCall: false,
          ),
          cancelledBy: '',
          updatedAt: '',
        );
  }
}

extension DoctorAppointmentItemResponseMapper on DoctorAppointmentItemResponse {
  DoctorAppointmentEntity toEntity() {
    return DoctorAppointmentEntity(
      id: id ?? '',
      status: status ?? '',
      date: date ?? '',
      startTime: startTime ?? '',
      endTime: endTime ?? '',
      consultationType: consultationType ?? '',
      bookingPrice: bookingPrice?.toDouble() ?? 0,
      currency: currency ?? '',
      durationChatHours: durationChatHours ?? 0,
      durationCallMinutes: durationCallMinutes ?? 0,
      notes: notes ?? '',
      cancelReason: cancelReason ?? '',
      createdAt: createdAt ?? '',
      sessionStartsAt: sessionStartsAt ?? '',
      accessWindows: accessWindows?.toEntity() ??
          const DoctorAppointmentAccessWindowsEntity(
            sessionStartsAt: '',
            chat: DoctorAppointmentChatAccessEntity(
              availableFrom: '',
              availableUntil: '',
              isActive: false,
              remainingHours: 0,
            ),
            call: DoctorAppointmentCallAccessEntity(
              availableFrom: '',
              availableUntil: '',
              isActive: false,
              durationMinutes: 0,
              usedSeconds: 0,
              remainingSeconds: 0,
            ),
          ),
      patient: patient?.toEntity() ??
          const DoctorAppointmentPatientEntity(
            id: '',
            fullNameAr: '',
            fullNameEn: '',
            avatarUrl: null,
            phone: '',
            countryCode: '',
            email: '',
          ),
      actions: actions?.toEntity() ??
          const DoctorAppointmentActionsEntity(
            canAccessChat: false,
            canAccessCall: false,
          ),
      cancelledBy: cancelledBy ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}

extension DoctorAppointmentPatientResponseMapper
    on DoctorAppointmentPatientResponse {
  DoctorAppointmentPatientEntity toEntity() {
    return DoctorAppointmentPatientEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
      fullNameEn: fullNameEn ?? '',
      avatarUrl: avatarUrl,
      phone: phone ?? '',
      countryCode: countryCode ?? '',
      email: email ?? '',
    );
  }
}

extension DoctorAppointmentAccessWindowsResponseMapper
    on DoctorAppointmentAccessWindowsResponse {
  DoctorAppointmentAccessWindowsEntity toEntity() {
    return DoctorAppointmentAccessWindowsEntity(
      sessionStartsAt: sessionStartsAt ?? '',
      chat: chat?.toEntity() ??
          const DoctorAppointmentChatAccessEntity(
            availableFrom: '',
            availableUntil: '',
            isActive: false,
            remainingHours: 0,
          ),
      call: call?.toEntity() ??
          const DoctorAppointmentCallAccessEntity(
            availableFrom: '',
            availableUntil: '',
            isActive: false,
            durationMinutes: 0,
            usedSeconds: 0,
            remainingSeconds: 0,
          ),
    );
  }
}

extension DoctorAppointmentChatAccessResponseMapper
    on DoctorAppointmentChatAccessResponse {
  DoctorAppointmentChatAccessEntity toEntity() {
    return DoctorAppointmentChatAccessEntity(
      availableFrom: availableFrom ?? '',
      availableUntil: availableUntil ?? '',
      isActive: isActive ?? false,
      remainingHours: remainingHours?.toDouble() ?? 0,
    );
  }
}

extension DoctorAppointmentCallAccessResponseMapper
    on DoctorAppointmentCallAccessResponse {
  DoctorAppointmentCallAccessEntity toEntity() {
    return DoctorAppointmentCallAccessEntity(
      availableFrom: availableFrom ?? '',
      availableUntil: availableUntil ?? '',
      isActive: isActive ?? false,
      durationMinutes: durationMinutes ?? 0,
      usedSeconds: usedSeconds ?? 0,
      remainingSeconds: remainingSeconds ?? 0,
    );
  }
}

extension DoctorAppointmentActionsResponseMapper
    on DoctorAppointmentActionsResponse {
  DoctorAppointmentActionsEntity toEntity() {
    return DoctorAppointmentActionsEntity(
      canAccessChat: canAccessChat ?? false,
      canAccessCall: canAccessCall ?? false,
    );
  }
}
