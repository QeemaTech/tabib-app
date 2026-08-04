import 'package:tabib_app/features/home/data/models/response/book_appointment_response.dart';
import 'package:tabib_app/features/home/domain/entities/appointment_entity.dart';

extension BookAppointmentResponseMapper on BookAppointmentResponse {
  AppointmentEntity toEntity() {
    final data = this.data;
    return AppointmentEntity(
      id: data?.id ?? '',
      status: data?.status ?? '',
      date: data?.date ?? '',
      startTime: data?.startTime ?? '',
      endTime: data?.endTime ?? '',
      consultationType: data?.consultationType ?? '',
      quotedFee: data?.quotedFee?.toDouble() ?? 0,
      durationMinutes: data?.durationMinutes ?? 0,
      platformFeePercent: data?.platformFeePercent?.toDouble() ?? 0,
      notes: data?.notes ?? '',
      cancelReason: data?.cancelReason ?? '',
      createdAt: data?.createdAt ?? '',
      doctor: data?.doctor?.toEntity() ??
          const AppointmentDoctorEntity(
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

extension BookAppointmentDoctorDataMapper on BookAppointmentDoctorData {
  AppointmentDoctorEntity toEntity() {
    return AppointmentDoctorEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
      fullNameEn: fullNameEn ?? '',
      avatarUrl: avatarUrl ?? '',
      consultationFee: consultationFee?.toDouble() ?? 0,
      specialties: specialties ?? const [],
    );
  }
}
