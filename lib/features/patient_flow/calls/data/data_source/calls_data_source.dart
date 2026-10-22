import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/calls/data/models/request/agora_token_request.dart';
import 'package:tabib_app/features/patient_flow/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/patient_flow/calls/data/models/response/end_call_response.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/request/start_consultation_request.dart';

abstract interface class PatientCallsDataSource {
  Future<Result<PatientEndCallResponse>> startCall({
    required String appointmentId,
    required PatientStartConsultationRequest request,
  });

  Future<Result<PatientAgoraTokenResponse>> getAgoraToken({
    required PatientAgoraTokenRequest request,
  });

  Future<Result<PatientEndCallResponse>> endCall({required String callId});
}
