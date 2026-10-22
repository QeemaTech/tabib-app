import 'package:json_annotation/json_annotation.dart';

part 'patient_invoice_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientInvoiceResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final PatientInvoiceDataResponse? data;

  PatientInvoiceResponse({this.success, this.data});

  factory PatientInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientInvoiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientInvoiceResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientInvoiceDataResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'invoiceNumber')
  final String? invoiceNumber;
  @JsonKey(name: 'pdfUrl')
  final String? pdfUrl;
  @JsonKey(name: 'htmlUrl')
  final String? htmlUrl;
  @JsonKey(name: 'downloadPath')
  final String? downloadPath;
  @JsonKey(name: 'issuedAt')
  final String? issuedAt;
  @JsonKey(name: 'amount')
  final num? amount;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'appointmentId')
  final String? appointmentId;
  @JsonKey(name: 'appointmentDate')
  final String? appointmentDate;
  @JsonKey(name: 'appointmentTime')
  final String? appointmentTime;
  @JsonKey(name: 'appointmentStatus')
  final String? appointmentStatus;
  @JsonKey(name: 'doctorName')
  final String? doctorName;

  PatientInvoiceDataResponse({
    this.id,
    this.invoiceNumber,
    this.pdfUrl,
    this.htmlUrl,
    this.downloadPath,
    this.issuedAt,
    this.amount,
    this.currency,
    this.appointmentId,
    this.appointmentDate,
    this.appointmentTime,
    this.appointmentStatus,
    this.doctorName,
  });

  factory PatientInvoiceDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientInvoiceDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientInvoiceDataResponseToJson(this);
}
