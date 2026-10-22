import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/calls/data/data_source/calls_data_source.dart';
import 'package:tabib_app/features/patient_flow/calls/data/models/request/agora_token_request.dart';
import 'package:tabib_app/features/patient_flow/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/patient_flow/calls/data/models/response/end_call_response.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/request/start_consultation_request.dart';

@LazySingleton(as: PatientCallsDataSource)
class PatientCallsDataSourceImpl implements PatientCallsDataSource {
  final ApiClient apiClient;

  PatientCallsDataSourceImpl(this.apiClient);

  @override
  Future<Result<PatientEndCallResponse>> startCall({
    required String appointmentId,
    required PatientStartConsultationRequest request,
  }) {
    return executeApi(() => apiClient.startPatientCall(appointmentId, request));
  }

  @override
  Future<Result<PatientAgoraTokenResponse>> getAgoraToken({
    required PatientAgoraTokenRequest request,
  }) {
    return executeApi(() => apiClient.getPatientAgoraToken(request));
  }

  @override
  Future<Result<PatientEndCallResponse>> endCall({required String callId}) {
    return executeApi(() => apiClient.endPatientCall(callId));
  }
}
