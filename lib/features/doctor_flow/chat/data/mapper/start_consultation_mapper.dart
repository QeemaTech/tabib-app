import 'package:tabib_app/features/doctor_flow/chat/data/models/response/start_consultation_response.dart';
import 'package:tabib_app/features/doctor_flow/chat/domain/entities/started_consultation_entity.dart';

extension DoctorStartConsultationResponseMapper on DoctorStartConsultationResponse {
  StartedConsultationEntity toEntity() {
    return data?.toEntity() ??
        const StartedConsultationEntity(
          id: '',
          appointmentId: '',
          type: '',
          status: '',
          startedAt: '',
          endedAt: null,
          durationSec: 0,
          chatRoomId: '',
          videoCallId: null,
          videoRoomId: null,
          patient: StartedConsultationParticipantEntity.empty,
          doctor: StartedConsultationParticipantEntity.empty,
        );
  }
}

extension StartConsultationDataResponseMapper on StartConsultationDataResponse {
  StartedConsultationEntity toEntity() {
    return StartedConsultationEntity(
      id: id ?? '',
      appointmentId: appointmentId ?? '',
      type: type ?? '',
      status: status ?? '',
      startedAt: startedAt ?? '',
      endedAt: endedAt,
      durationSec: durationSec ?? 0,
      chatRoomId: chatRoomId ?? '',
      videoCallId: videoCallId,
      videoRoomId: videoRoomId,
      patient: patient?.toEntity() ?? StartedConsultationParticipantEntity.empty,
      doctor: doctor?.toEntity() ?? StartedConsultationParticipantEntity.empty,
    );
  }
}

extension StartConsultationParticipantResponseMapper
    on StartConsultationParticipantResponse {
  StartedConsultationParticipantEntity toEntity() {
    return StartedConsultationParticipantEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
    );
  }
}
