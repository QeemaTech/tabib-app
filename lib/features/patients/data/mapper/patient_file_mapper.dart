import 'package:tabib_app/features/patients/data/models/response/patient_file_response.dart';
import 'package:tabib_app/features/patients/domain/entities/patient_file_appointment_entity.dart';
import 'package:tabib_app/features/patients/domain/entities/patient_file_entity.dart';
import 'package:tabib_app/features/patients/domain/entities/patient_file_medical_history_entity.dart';
import 'package:tabib_app/features/patients/domain/entities/patient_file_patient_entity.dart';

extension PatientFileResponseMapper on PatientFileResponse {
  PatientFileEntity toEntity() {
    final data = this.data;
    return PatientFileEntity(
      patient: data?.patient?.toEntity() ??
          const PatientFilePatientEntity(
            id: '',
            fullNameAr: '',
            gender: '',
            bloodType: '',
            allergies: '',
            chronicConditions: '',
            phone: '',
          ),
      appointment: data?.appointment?.toEntity() ??
          const PatientFileAppointmentEntity(
            id: '',
            date: '',
            startTime: '',
            endTime: '',
            status: '',
            consultationType: '',
            bookingPrice: 0,
            currency: '',
            notes: '',
          ),
      medicalHistory:
          data?.medicalHistory?.map((item) => item.toEntity()).toList() ??
              const [],
    );
  }
}

extension PatientFilePatientResponseMapper on PatientFilePatientResponse {
  PatientFilePatientEntity toEntity() {
    return PatientFilePatientEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
      gender: gender ?? '',
      bloodType: bloodType ?? '',
      allergies: allergies ?? '',
      chronicConditions: chronicConditions ?? '',
      phone: phone ?? '',
    );
  }
}

extension PatientFileAppointmentResponseMapper
    on PatientFileAppointmentResponse {
  PatientFileAppointmentEntity toEntity() {
    return PatientFileAppointmentEntity(
      id: id ?? '',
      date: date ?? '',
      startTime: startTime ?? '',
      endTime: endTime ?? '',
      status: status ?? '',
      consultationType: consultationType ?? '',
      bookingPrice: bookingPrice ?? 0,
      currency: currency ?? '',
      notes: notes ?? '',
    );
  }
}

extension PatientFileMedicalHistoryResponseMapper
    on PatientFileMedicalHistoryResponse {
  PatientFileMedicalHistoryEntity toEntity() {
    return PatientFileMedicalHistoryEntity(
      id: id ?? '',
      date: date ?? '',
      summaryAr: summaryAr ?? '',
      diagnoses: diagnoses ?? const [],
      prescriptions: prescriptions ?? 0,
    );
  }
}
