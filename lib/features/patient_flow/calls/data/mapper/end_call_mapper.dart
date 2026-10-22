import 'package:tabib_app/features/patient_flow/calls/data/models/response/end_call_response.dart';
import 'package:tabib_app/features/patient_flow/calls/domain/entities/call_session_entity.dart';

extension PatientEndCallResponseMapper on PatientEndCallResponse {
  CallSessionEntity toEntity() {
    return data?.toEntity() ??
        const CallSessionEntity(
          id: '',
          appointmentId: '',
          channelName: '',
          callType: '',
          status: '',
          startedAt: '',
          durationSeconds: 0,
        );
  }
}

extension EndCallDataResponseMapper on EndCallDataResponse {
  CallSessionEntity toEntity() {
    return CallSessionEntity(
      id: id ?? '',
      appointmentId: appointmentId ?? '',
      channelName: channelName ?? '',
      callType: callType ?? '',
      status: status ?? '',
      startedAt: startedAt ?? '',
      durationSeconds: durationSeconds ?? 0,
    );
  }
}
