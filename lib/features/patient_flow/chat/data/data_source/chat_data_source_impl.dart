import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/chat/data/data_source/chat_data_source.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/request/start_consultation_request.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/response/consultations_response.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/response/messages_response.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/response/start_consultation_response.dart';

@LazySingleton(as: PatientChatDataSource)
class PatientChatDataSourceImpl implements PatientChatDataSource {
  final ApiClient apiClient;

  PatientChatDataSourceImpl(this.apiClient);

  @override
  Future<Result<PatientConsultationsResponse>> getConsultations() {
    return executeApi(() => apiClient.getPatientConsultations());
  }

  @override
  Future<Result<PatientStartConsultationResponse>> startConsultation({
    required String appointmentId,
    required PatientStartConsultationRequest request,
  }) {
    return executeApi(
      () => apiClient.startPatientConsultation(appointmentId, request),
    );
  }

  @override
  Future<Result<PatientMessagesResponse>> getMessages({
    required String consultationId,
    int? limit,
    String? before,
  }) {
    return executeApi(
      () => apiClient.getPatientConsultationMessages(
        consultationId,
        limit: limit,
        before: before,
      ),
    );
  }
}
