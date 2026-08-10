import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String senderId;
  final String senderRole;
  final String content;
  final String? fileUrl;
  final String? fileType;
  final String? fileName;
  final int? fileSize;
  final String status;
  final bool isRead;
  final String? readAt;
  final String createdAt;
  final bool isMine;
  final bool isPending;

  const MessageEntity({
    required this.id,
    required this.senderId,
    required this.senderRole,
    required this.content,
    this.fileUrl,
    this.fileType,
    this.fileName,
    this.fileSize,
    required this.status,
    required this.isRead,
    this.readAt,
    required this.createdAt,
    required this.isMine,
    this.isPending = false,
  });

  factory MessageEntity.fromSocketMap(
    Map<String, dynamic> map, {
    required String currentRole,
  }) {
    final senderRole = (map['senderRole'] as String?) ?? '';
    return MessageEntity(
      id: (map['id'] as String?) ?? '',
      senderId: (map['senderId'] as String?) ?? '',
      senderRole: senderRole,
      content: (map['content'] as String?) ?? '',
      fileUrl: map['fileUrl'] as String?,
      fileType: map['fileType'] as String?,
      fileName: map['fileName'] as String?,
      fileSize: (map['fileSize'] as num?)?.toInt(),
      status: (map['status'] as String?) ?? 'SENT',
      isRead: map['isRead'] == true,
      readAt: map['readAt'] as String?,
      createdAt:
          (map['createdAt'] as String?) ?? DateTime.now().toIso8601String(),
      isMine: isMineForRoles(senderRole: senderRole, currentRole: currentRole),
    );
  }

  factory MessageEntity.pending({
    required String tempId,
    required String content,
    required String currentRole,
  }) {
    return MessageEntity(
      id: tempId,
      senderId: '',
      senderRole: normalizeRole(currentRole),
      content: content,
      status: 'PENDING',
      isRead: false,
      createdAt: DateTime.now().toIso8601String(),
      isMine: true,
      isPending: true,
    );
  }

  /// Maps UI roles (`user`/`doctor`) and API roles (`PATIENT`/`DOCTOR`) to one form.
  static String normalizeRole(String role) {
    final normalized = role.trim().toUpperCase();
    if (normalized == 'DOCTOR' || normalized == 'DOC') {
      return 'DOCTOR';
    }
    if (normalized == 'PATIENT' ||
        normalized == 'USER' ||
        normalized == 'PATIENT_USER') {
      return 'PATIENT';
    }
    return normalized;
  }

  static bool isMineForRoles({
    required String senderRole,
    required String currentRole,
  }) {
    final normalizedSender = normalizeRole(senderRole);
    final normalizedCurrent = normalizeRole(currentRole);
    if (normalizedCurrent.isEmpty || normalizedSender.isEmpty) {
      return false;
    }
    return normalizedSender == normalizedCurrent;
  }

  MessageEntity copyWith({
    String? id,
    String? senderId,
    String? senderRole,
    String? content,
    String? fileUrl,
    String? fileType,
    String? fileName,
    int? fileSize,
    String? status,
    bool? isRead,
    String? readAt,
    String? createdAt,
    bool? isMine,
    bool? isPending,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderRole: senderRole ?? this.senderRole,
      content: content ?? this.content,
      fileUrl: fileUrl ?? this.fileUrl,
      fileType: fileType ?? this.fileType,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize,
      status: status ?? this.status,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
      isMine: isMine ?? this.isMine,
      isPending: isPending ?? this.isPending,
    );
  }

  @override
  List<Object?> get props => [
        id,
        senderId,
        senderRole,
        content,
        fileUrl,
        fileType,
        fileName,
        fileSize,
        status,
        isRead,
        readAt,
        createdAt,
        isMine,
        isPending,
      ];
}
