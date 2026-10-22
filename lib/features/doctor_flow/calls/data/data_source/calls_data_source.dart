import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/models/request/agora_token_request.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/models/response/end_call_response.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/request/start_consultation_request.dart';

abstract interface class DoctorCallsDataSource {
  Future<Result<DoctorEndCallResponse>> startCall({
    required String appointmentId,
    required DoctorStartConsultationRequest request,
  });

  Future<Result<DoctorAgoraTokenResponse>> getAgoraToken({
    required DoctorAgoraTokenRequest request,
  });

  Future<Result<DoctorEndCallResponse>> endCall({required String callId});
}
