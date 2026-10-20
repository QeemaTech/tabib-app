import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/calls/domain/entities/agora_token_entity.dart';
import 'package:tabib_app/features/calls/domain/entities/call_session_entity.dart';

abstract interface class CallsRepo {
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
