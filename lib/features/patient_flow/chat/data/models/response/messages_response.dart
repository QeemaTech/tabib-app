import 'package:json_annotation/json_annotation.dart';

part 'messages_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientMessagesResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<MessageItemResponse>? data;
  @JsonKey(name: 'meta')
  final MessagesMetaResponse? meta;

  PatientMessagesResponse({
    this.success,
    this.data,
    this.meta,
  });

  factory PatientMessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientMessagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientMessagesResponseToJson(this);
}

@JsonSerializable()
class MessageItemResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'senderId')
  final String? senderId;
  @JsonKey(name: 'senderRole')
  final String? senderRole;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'isRead')
  final bool? isRead;
  @JsonKey(name: 'readAt')
  final String? readAt;
  @JsonKey(name: 'fileUrl')
  final String? fileUrl;
  @JsonKey(name: 'fileType')
  final String? fileType;
  @JsonKey(name: 'fileName')
  final String? fileName;
  @JsonKey(name: 'fileSize')
  final int? fileSize;
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  MessageItemResponse({
    this.id,
    this.content,
    this.senderId,
    this.senderRole,
    this.status,
    this.isRead,
    this.readAt,
    this.fileUrl,
    this.fileType,
    this.fileName,
    this.fileSize,
    this.createdAt,
  });

  factory MessageItemResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageItemResponseToJson(this);
}

@JsonSerializable()
class MessagesMetaResponse {
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'limit')
  final int? limit;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'totalPages')
  final int? totalPages;
  @JsonKey(name: 'hasMore')
  final bool? hasMore;
  @JsonKey(name: 'nextBefore')
  final String? nextBefore;

  MessagesMetaResponse({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
    this.hasMore,
    this.nextBefore,
  });

  factory MessagesMetaResponse.fromJson(Map<String, dynamic> json) =>
      _$MessagesMetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesMetaResponseToJson(this);
}
