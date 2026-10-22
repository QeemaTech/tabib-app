import 'package:json_annotation/json_annotation.dart';

part 'doctor_documents_response.g.dart';

@JsonSerializable()
class DoctorDocumentsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final DoctorDocumentsDataResponse? data;

  DoctorDocumentsResponse({this.success, this.data});

  factory DoctorDocumentsResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorDocumentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDocumentsResponseToJson(this);
}

@JsonSerializable()
class DoctorDocumentsDataResponse {
  @JsonKey(name: 'verificationStatus')
  final String? verificationStatus;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'documentsSubmitted')
  final bool? documentsSubmitted;

  DoctorDocumentsDataResponse({
    this.verificationStatus,
    this.message,
    this.documentsSubmitted,
  });

  factory DoctorDocumentsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorDocumentsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDocumentsDataResponseToJson(this);
}
