import 'package:tabib_app/features/appointments/data/models/response/patient_invoice_response.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_invoice_entity.dart';

extension PatientInvoiceResponseMapper on PatientInvoiceResponse {
  PatientInvoiceEntity toEntity() {
    return data?.toEntity() ?? PatientInvoiceEntity.empty;
  }
}

extension PatientInvoiceDataResponseMapper on PatientInvoiceDataResponse {
  PatientInvoiceEntity toEntity() {
    return PatientInvoiceEntity(
      id: id ?? '',
      invoiceNumber: invoiceNumber ?? '',
      pdfUrl: pdfUrl ?? '',
      htmlUrl: htmlUrl ?? '',
      downloadPath: downloadPath ?? '',
      issuedAt: issuedAt ?? '',
      amount: amount?.toDouble() ?? 0,
      currency: currency ?? '',
      appointmentId: appointmentId ?? '',
      appointmentDate: appointmentDate ?? '',
      appointmentTime: appointmentTime ?? '',
      appointmentStatus: appointmentStatus ?? '',
      doctorName: doctorName ?? '',
    );
  }
}
