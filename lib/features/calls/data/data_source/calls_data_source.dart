import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/calls/data/models/request/agora_token_request.dart';
import 'package:tabib_app/features/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/calls/data/models/response/end_call_response.dart';
import 'package:tabib_app/features/chat/data/models/request/start_consultation_request.dart';
import 'package:tabib_app/features/chat/data/models/response/start_consultation_response.dart';

abstract interface class CallsDataSource {
  Future<Result<StartConsultationResponse>> startConsultation({
    required String appointmentId,
    required StartConsultationRequest request,
  });

  Future<Result<AgoraTokenResponse>> getAgoraToken({
    required AgoraTokenRequest request,
  });

  Future<Result<EndCallResponse>> endCall({required String callId});
}
