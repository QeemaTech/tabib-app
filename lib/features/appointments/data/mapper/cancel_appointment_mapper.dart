import 'package:tabib_app/features/appointments/data/models/response/cancel_appointment_response.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_entity.dart';

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
      notes: data?.notes ?? '',
      cancelReason: data?.cancelReason ?? '',
      createdAt: data?.createdAt ?? '',
      doctor: data?.doctor?.toEntity() ??
          const PatientAppointmentDoctorEntity(
            id: '',
            fullNameAr: '',
            fullNameEn: '',
            avatarUrl: '',
            consultationFee: 0,
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
      consultationFee: consultationFee?.toDouble() ?? 0,
      specialties: specialties ?? const [],
    );
  }
}
