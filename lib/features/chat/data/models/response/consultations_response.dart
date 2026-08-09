import 'package:json_annotation/json_annotation.dart';

part 'consultations_response.g.dart';

@JsonSerializable()
class ConsultationsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<ConsultationItemResponse>? data;

  ConsultationsResponse({
    this.success,
    this.data,
  });

  factory ConsultationsResponse.fromJson(Map<String, dynamic> json) =>
      _$ConsultationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultationsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ConsultationItemResponse {
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
  @JsonKey(name: 'participant')
  final ConsultationParticipantResponse? participant;
  @JsonKey(name: 'lastMessage')
  final ConsultationLastMessageResponse? lastMessage;
  @JsonKey(name: 'unreadCount')
  final int? unreadCount;
  @JsonKey(name: 'isMine')
  final bool? isMine;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  ConsultationItemResponse({
    this.id,
    this.appointmentId,
    this.type,
    this.status,
    this.startedAt,
    this.endedAt,
    this.participant,
    this.lastMessage,
    this.unreadCount,
    this.isMine,
    this.updatedAt,
  });

  factory ConsultationItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ConsultationItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultationItemResponseToJson(this);
}

@JsonSerializable()
class ConsultationParticipantResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;
  @JsonKey(name: 'fullNameEn')
  final String? fullNameEn;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'countryCode')
  final String? countryCode;

  ConsultationParticipantResponse({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.phone,
    this.countryCode,
  });

  factory ConsultationParticipantResponse.fromJson(Map<String, dynamic> json) =>
      _$ConsultationParticipantResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ConsultationParticipantResponseToJson(this);
}

@JsonSerializable()
class ConsultationLastMessageResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'isMine')
  final bool? isMine;

  ConsultationLastMessageResponse({
    this.id,
    this.content,
    this.createdAt,
    this.isMine,
  });

  factory ConsultationLastMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ConsultationLastMessageResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ConsultationLastMessageResponseToJson(this);
}
