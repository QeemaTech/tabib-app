import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/calls/data/data_source/calls_data_source.dart';
import 'package:tabib_app/features/calls/data/models/request/agora_token_request.dart';
import 'package:tabib_app/features/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/calls/data/models/response/end_call_response.dart';
import 'package:tabib_app/features/chat/data/models/request/start_consultation_request.dart';

@LazySingleton(as: CallsDataSource)
class CallsDataSourceImpl implements CallsDataSource {
  final ApiClient apiClient;

  CallsDataSourceImpl(this.apiClient);

  @override
  Future<Result<EndCallResponse>> startCall({
    required String appointmentId,
    required StartConsultationRequest request,
  }) {
    return executeApi(() => apiClient.startCall(appointmentId, request));
  }

  @override
  Future<Result<AgoraTokenResponse>> getAgoraToken({
    required AgoraTokenRequest request,
  }) {
    return executeApi(() => apiClient.getAgoraToken(request));
  }

  @override
  Future<Result<EndCallResponse>> endCall({required String callId}) {
    return executeApi(() => apiClient.endCall(callId));
  }
}
