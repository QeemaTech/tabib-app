import 'package:tabib_app/features/appointments/data/mapper/patient_appointments_mapper.dart';
import 'package:tabib_app/features/appointments/data/mapper/patient_invoice_mapper.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_appointment_details_response.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_details_entity.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_entity.dart';

extension PatientAppointmentDetailsResponseMapper
    on PatientAppointmentDetailsResponse {
  PatientAppointmentDetailsEntity toEntity() {
    final item = data;
    return PatientAppointmentDetailsEntity(
      id: item?.id ?? '',
      status: item?.status ?? '',
      date: item?.date ?? '',
      startTime: item?.startTime ?? '',
      endTime: item?.endTime ?? '',
      bookingPrice: item?.bookingPrice?.toDouble() ?? 0,
      currency: item?.currency ?? '',
      complaint: item?.complaint ?? '',
      symptoms: item?.symptoms ?? '',
      notes: item?.notes ?? '',
      channels: item?.channels?.map((channel) => channel.toEntity()).toList() ??
          const [],
      doctor: item?.doctor?.toEntity() ?? AppointmentDetailsDoctorEntity.empty,
      actions: item?.actions?.toEntity() ?? PatientAppointmentActionsEntity.empty,
      invoice: item?.invoice?.toEntity(),
    );
  }
}

extension PatientAppointmentChannelResponseMapper
    on PatientAppointmentChannelResponse {
  AppointmentChannelEntity toEntity() {
    return AppointmentChannelEntity(
      type: type ?? '',
      labelAr: labelAr ?? '',
      labelEn: labelEn ?? '',
      duration: duration?.toInt() ?? 0,
      unit: unit ?? '',
    );
  }
}

extension PatientAppointmentDetailsDoctorResponseMapper
    on PatientAppointmentDetailsDoctorResponse {
  AppointmentDetailsDoctorEntity toEntity() {
    return AppointmentDetailsDoctorEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
      fullNameEn: fullNameEn ?? '',
      avatarUrl: avatarUrl ?? '',
      ratingAvg: ratingAvg?.toDouble() ?? 0,
      ratingCount: ratingCount?.toInt() ?? 0,
      specialties:
          specialties?.map((specialty) => specialty.toEntity()).toList() ??
          const [],
      clinic: clinic?.toEntity() ?? AppointmentClinicEntity.empty,
    );
  }
}

extension PatientAppointmentSpecialtyResponseMapper
    on PatientAppointmentSpecialtyResponse {
  AppointmentSpecialtyEntity toEntity() {
    return AppointmentSpecialtyEntity(
      id: id ?? '',
      nameAr: nameAr ?? '',
      nameEn: nameEn ?? '',
    );
  }
}

extension PatientAppointmentClinicResponseMapper
    on PatientAppointmentClinicResponse {
  AppointmentClinicEntity toEntity() {
    return AppointmentClinicEntity(
      nameAr: nameAr ?? '',
      addressAr: addressAr ?? '',
      phone: phone ?? '',
      city: city ?? '',
    );
  }
}
