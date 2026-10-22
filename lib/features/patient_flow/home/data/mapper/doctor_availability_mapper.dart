import 'package:tabib_app/features/patient_flow/home/data/models/response/doctor_availability_response.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/availability_slot_entity.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/doctor_availability_entity.dart';

extension DoctorAvailabilityResponseMapper on DoctorAvailabilityResponse {
  DoctorAvailabilityEntity toEntity() {
    final data = this.data;
    return DoctorAvailabilityEntity(
      date: data?.date ?? '',
      slots: data?.slots?.map((slot) => slot.toEntity()).toList() ?? const [],
    );
  }
}

extension AvailabilitySlotResponseMapper on AvailabilitySlotResponse {
  AvailabilitySlotEntity toEntity() {
    return AvailabilitySlotEntity(
      startTime: startTime ?? '',
      endTime: endTime ?? '',
      available: available ?? false,
    );
  }
}
