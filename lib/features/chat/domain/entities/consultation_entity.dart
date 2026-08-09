import 'package:equatable/equatable.dart';

class ConsultationEntity extends Equatable {
  final String id;
  final String appointmentId;
  final String type;
  final String status;
  final String startedAt;
  final String? endedAt;
  final ConsultationParticipantEntity participant;
  final ConsultationLastMessageEntity? lastMessage;
  final int unreadCount;
  final bool isMine;
  final String updatedAt;

  const ConsultationEntity({
    required this.id,
    required this.appointmentId,
    required this.type,
    required this.status,
    required this.startedAt,
    required this.endedAt,
    required this.participant,
    required this.lastMessage,
    required this.unreadCount,
    required this.isMine,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        appointmentId,
        type,
        status,
        startedAt,
        endedAt,
        participant,
        lastMessage,
        unreadCount,
        isMine,
        updatedAt,
      ];
}

class ConsultationParticipantEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String fullNameEn;
  final String avatarUrl;
  final String phone;
  final String countryCode;

  const ConsultationParticipantEntity({
    required this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.avatarUrl,
    required this.phone,
    required this.countryCode,
  });

  static const empty = ConsultationParticipantEntity(
    id: '',
    fullNameAr: '',
    fullNameEn: '',
    avatarUrl: '',
    phone: '',
    countryCode: '',
  );

  String localizedFullName(String languageCode) =>
      languageCode.startsWith('ar') && fullNameAr.isNotEmpty
          ? fullNameAr
          : (fullNameEn.isNotEmpty ? fullNameEn : fullNameAr);

  @override
  List<Object?> get props => [
        id,
        fullNameAr,
        fullNameEn,
        avatarUrl,
        phone,
        countryCode,
      ];
}

class ConsultationLastMessageEntity extends Equatable {
  final String id;
  final String content;
  final String createdAt;
  final bool isMine;

  const ConsultationLastMessageEntity({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.isMine,
  });

  @override
  List<Object?> get props => [id, content, createdAt, isMine];
}
