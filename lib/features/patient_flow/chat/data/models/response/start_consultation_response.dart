import 'package:json_annotation/json_annotation.dart';

part 'start_consultation_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientStartConsultationResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final StartConsultationDataResponse? data;

  PatientStartConsultationResponse({
    this.success,
    this.data,
  });

  factory PatientStartConsultationResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientStartConsultationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientStartConsultationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StartConsultationDataResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'appointmentId')
  final String? appointmentId;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'startedAt')
  final String? startedAt;
  @JsonKey(name: 'endedAt')
  final String? endedAt;
  @JsonKey(name: 'durationSec')
  final int? durationSec;
  @JsonKey(name: 'chatRoomId')
  final String? chatRoomId;
  @JsonKey(name: 'videoCallId')
  final String? videoCallId;
  @JsonKey(name: 'videoRoomId')
  final String? videoRoomId;
  @JsonKey(name: 'patient')
  final StartConsultationParticipantResponse? patient;
  @JsonKey(name: 'doctor')
  final StartConsultationParticipantResponse? doctor;

  StartConsultationDataResponse({
    this.id,
    this.appointmentId,
    this.type,
    this.status,
    this.startedAt,
    this.endedAt,
    this.durationSec,
    this.chatRoomId,
    this.videoCallId,
    this.videoRoomId,
    this.patient,
    this.doctor,
  });

  factory StartConsultationDataResponse.fromJson(Map<String, dynamic> json) =>
      _$StartConsultationDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StartConsultationDataResponseToJson(this);
}

@JsonSerializable()
class StartConsultationParticipantResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;

  StartConsultationParticipantResponse({
    this.id,
    this.fullNameAr,
  });

  factory StartConsultationParticipantResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$StartConsultationParticipantResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$StartConsultationParticipantResponseToJson(this);
}
