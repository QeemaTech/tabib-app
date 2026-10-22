import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/calls/domain/entities/agora_token_entity.dart';
import 'package:tabib_app/features/patient_flow/calls/domain/entities/call_session_entity.dart';

abstract interface class PatientCallsRepo {
  Future<Result<CallSessionEntity>> startCall({
    required String appointmentId,
    required String type,
  });

  Future<Result<AgoraTokenEntity>> getAgoraToken({
    required String channelName,
    String role = 'publisher',
  });

  Future<Result<CallSessionEntity>> endCall({required String callId});
}
