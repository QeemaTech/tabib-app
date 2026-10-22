import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/data_source/chat_data_source.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/request/start_consultation_request.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/response/consultations_response.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/response/messages_response.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/response/start_consultation_response.dart';

@LazySingleton(as: DoctorChatDataSource)
class DoctorChatDataSourceImpl implements DoctorChatDataSource {
  final ApiClient apiClient;

  DoctorChatDataSourceImpl(this.apiClient);

  @override
  Future<Result<DoctorConsultationsResponse>> getConsultations() {
    return executeApi(() => apiClient.getDoctorConsultations());
  }

  @override
  Future<Result<DoctorStartConsultationResponse>> startConsultation({
    required String appointmentId,
    required DoctorStartConsultationRequest request,
  }) {
    return executeApi(
      () => apiClient.startDoctorConsultation(appointmentId, request),
    );
  }

  @override
  Future<Result<DoctorMessagesResponse>> getMessages({
    required String consultationId,
    int? limit,
    String? before,
  }) {
    return executeApi(
      () => apiClient.getDoctorConsultationMessages(
        consultationId,
        limit: limit,
        before: before,
      ),
    );
  }
}
