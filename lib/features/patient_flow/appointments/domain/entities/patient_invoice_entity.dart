import 'package:equatable/equatable.dart';

class PatientInvoiceEntity extends Equatable {
  final String id;
  final String invoiceNumber;
  final String pdfUrl;
  final String htmlUrl;
  final String downloadPath;
  final String issuedAt;
  final double amount;
  final String currency;
  final String appointmentId;
  final String appointmentDate;
  final String appointmentTime;
  final String appointmentStatus;
  final String doctorName;

  const PatientInvoiceEntity({
    required this.id,
    required this.invoiceNumber,
    required this.pdfUrl,
    required this.htmlUrl,
    required this.downloadPath,
    required this.issuedAt,
    required this.amount,
    required this.currency,
    required this.appointmentId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentStatus,
    required this.doctorName,
  });

  static const empty = PatientInvoiceEntity(
    id: '',
    invoiceNumber: '',
    pdfUrl: '',
    htmlUrl: '',
    downloadPath: '',
    issuedAt: '',
    amount: 0,
    currency: '',
    appointmentId: '',
    appointmentDate: '',
    appointmentTime: '',
    appointmentStatus: '',
    doctorName: '',
  );

  @override
  List<Object?> get props => [
    id,
    invoiceNumber,
    pdfUrl,
    htmlUrl,
    downloadPath,
    issuedAt,
    amount,
    currency,
    appointmentId,
    appointmentDate,
    appointmentTime,
    appointmentStatus,
    doctorName,
  ];
}
