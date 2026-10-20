import 'package:tabib_app/features/chat/data/models/response/consultations_response.dart';
import 'package:tabib_app/features/chat/domain/entities/consultation_entity.dart';

extension ConsultationsResponseMapper on ConsultationsResponse {
  List<ConsultationEntity> toEntityList() {
    return data?.map((item) => item.toEntity()).toList() ?? const [];
  }
}

extension ConsultationItemResponseMapper on ConsultationItemResponse {
  ConsultationEntity toEntity() {
    return ConsultationEntity(
      id: id ?? '',
      appointmentId: appointmentId ?? '',
      type: type ?? '',
      status: status ?? '',
      startedAt: startedAt ?? '',
      endedAt: endedAt,
      participant:
          participant?.toEntity() ?? ConsultationParticipantEntity.empty,
      lastMessage: lastMessage?.toEntity(),
      unreadCount: unreadCount ?? 0,
      isMine: isMine ?? false,
      updatedAt: updatedAt ?? '',
    );
  }
}

extension ConsultationParticipantResponseMapper
    on ConsultationParticipantResponse {
  ConsultationParticipantEntity toEntity() {
    return ConsultationParticipantEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
      fullNameEn: fullNameEn ?? '',
      avatarUrl: avatarUrl ?? '',
      phone: phone ?? '',
      countryCode: countryCode ?? '',
    );
  }
}

extension ConsultationLastMessageResponseMapper
    on ConsultationLastMessageResponse {
  ConsultationLastMessageEntity toEntity() {
    return ConsultationLastMessageEntity(
      id: id ?? '',
      content: content ?? '',
      createdAt: createdAt ?? '',
      isMine: isMine ?? false,
    );
  }
}
