import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/data_source/calls_data_source.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/models/request/agora_token_request.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/models/response/end_call_response.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/request/start_consultation_request.dart';

@LazySingleton(as: DoctorCallsDataSource)
class DoctorCallsDataSourceImpl implements DoctorCallsDataSource {
  final ApiClient apiClient;

  DoctorCallsDataSourceImpl(this.apiClient);

  @override
  Future<Result<DoctorEndCallResponse>> startCall({
    required String appointmentId,
    required DoctorStartConsultationRequest request,
  }) {
    return executeApi(() => apiClient.startDoctorCall(appointmentId, request));
  }

  @override
  Future<Result<DoctorAgoraTokenResponse>> getAgoraToken({
    required DoctorAgoraTokenRequest request,
  }) {
    return executeApi(() => apiClient.getDoctorAgoraToken(request));
  }

  @override
  Future<Result<DoctorEndCallResponse>> endCall({required String callId}) {
    return executeApi(() => apiClient.endDoctorCall(callId));
  }
}
