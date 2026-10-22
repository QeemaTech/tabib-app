import 'package:tabib_app/features/patient_flow/chat/data/models/response/messages_response.dart';
import 'package:tabib_app/features/patient_flow/chat/domain/entities/message_entity.dart';
import 'package:tabib_app/features/patient_flow/chat/domain/entities/messages_page_entity.dart';

extension PatientMessagesResponseMapper on PatientMessagesResponse {
  MessagesPageEntity toEntity({required String currentRole}) {
    final items = data ?? const <MessageItemResponse>[];
    final messages = items
        .map((item) => item.toEntity(currentRole: currentRole))
        .toList();
    messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return MessagesPageEntity(
      messages: messages,
      hasMore: meta?.hasMore ?? false,
      nextBefore: meta?.nextBefore,
    );
  }
}

extension MessageItemResponseMapper on MessageItemResponse {
  MessageEntity toEntity({required String currentRole}) {
    final role = senderRole ?? '';
    return MessageEntity(
      id: id ?? '',
      senderId: senderId ?? '',
      senderRole: role,
      content: content ?? '',
      fileUrl: fileUrl,
      fileType: fileType,
      fileName: fileName,
      fileSize: fileSize,
      status: status ?? 'SENT',
      isRead: isRead ?? false,
      readAt: readAt,
      createdAt: createdAt ?? '',
      isMine: MessageEntity.isMineForRoles(
        senderRole: role,
        currentRole: currentRole,
      ),
    );
  }
}
