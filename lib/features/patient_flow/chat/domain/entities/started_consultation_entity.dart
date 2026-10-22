import 'package:equatable/equatable.dart';

class StartedConsultationEntity extends Equatable {
  final String id;
  final String appointmentId;
  final String type;
  final String status;
  final String startedAt;
  final String? endedAt;
  final int durationSec;
  final String chatRoomId;
  final String? videoCallId;
  final String? videoRoomId;
  final StartedConsultationParticipantEntity patient;
  final StartedConsultationParticipantEntity doctor;

  const StartedConsultationEntity({
    required this.id,
    required this.appointmentId,
    required this.type,
    required this.status,
    required this.startedAt,
    required this.endedAt,
    required this.durationSec,
    required this.chatRoomId,
    required this.videoCallId,
    required this.videoRoomId,
    required this.patient,
    required this.doctor,
  });

  @override
  List<Object?> get props => [
        id,
        appointmentId,
        type,
        status,
        startedAt,
        endedAt,
        durationSec,
        chatRoomId,
        videoCallId,
        videoRoomId,
        patient,
        doctor,
      ];
}

class StartedConsultationParticipantEntity extends Equatable {
  final String id;
  final String fullNameAr;

  const StartedConsultationParticipantEntity({
    required this.id,
    required this.fullNameAr,
  });

  static const empty = StartedConsultationParticipantEntity(
    id: '',
    fullNameAr: '',
  );

  @override
  List<Object?> get props => [id, fullNameAr];
}
