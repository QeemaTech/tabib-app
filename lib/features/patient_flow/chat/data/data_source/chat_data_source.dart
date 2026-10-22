import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/request/start_consultation_request.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/response/consultations_response.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/response/messages_response.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/response/start_consultation_response.dart';

abstract interface class PatientChatDataSource {
  Future<Result<PatientConsultationsResponse>> getConsultations();

  Future<Result<PatientStartConsultationResponse>> startConsultation({
    required String appointmentId,
    required PatientStartConsultationRequest request,
  });

  Future<Result<PatientMessagesResponse>> getMessages({
    required String consultationId,
    int? limit,
    String? before,
  });
}
