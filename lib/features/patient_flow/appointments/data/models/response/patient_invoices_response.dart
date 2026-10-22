import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/response/patient_invoice_response.dart';

part 'patient_invoices_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientInvoicesResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<PatientInvoiceDataResponse>? data;
  @JsonKey(name: 'meta')
  final PatientInvoicesMetaResponse? meta;

  PatientInvoicesResponse({this.success, this.data, this.meta});

  factory PatientInvoicesResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientInvoicesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientInvoicesResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientInvoicesMetaResponse {
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'limit')
  final int? limit;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'totalPages')
  final int? totalPages;

  PatientInvoicesMetaResponse({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });

  factory PatientInvoicesMetaResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientInvoicesMetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientInvoicesMetaResponseToJson(this);
}
