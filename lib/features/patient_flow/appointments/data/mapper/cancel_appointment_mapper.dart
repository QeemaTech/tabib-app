import 'package:tabib_app/features/patient_flow/appointments/data/models/response/cancel_appointment_response.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_appointment_entity.dart';

extension CancelAppointmentResponseMapper on CancelAppointmentResponse {
  PatientAppointmentEntity toEntity() {
    final data = this.data;
    return PatientAppointmentEntity(
      id: data?.id ?? '',
      status: data?.status ?? '',
      date: data?.date ?? '',
      startTime: data?.startTime ?? '',
      endTime: data?.endTime ?? '',
      consultationType: data?.consultationType ?? '',
      bookingPrice: 0,
      currency: '',
      durationChatHours: 0,
      durationCallMinutes: 0,
      complaint: '',
      symptoms: '',
      notes: data?.notes ?? '',
      cancelReason: data?.cancelReason ?? '',
      createdAt: data?.createdAt ?? '',
      actions: PatientAppointmentActionsEntity.empty,
      doctor: data?.doctor?.toEntity() ??
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

extension CancelAppointmentDoctorDataMapper on CancelAppointmentDoctorData {
  PatientAppointmentDoctorEntity toEntity() {
    return PatientAppointmentDoctorEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
      fullNameEn: fullNameEn ?? '',
      avatarUrl: avatarUrl ?? '',
      bookingPrice: consultationFee?.toDouble() ?? 0,
      specialties: specialties ?? const [],
    );
  }
}
