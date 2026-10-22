import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/request/start_consultation_request.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/response/consultations_response.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/response/messages_response.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/response/start_consultation_response.dart';

abstract interface class DoctorChatDataSource {
  Future<Result<DoctorConsultationsResponse>> getConsultations();

  Future<Result<DoctorStartConsultationResponse>> startConsultation({
    required String appointmentId,
    required DoctorStartConsultationRequest request,
  });

  Future<Result<DoctorMessagesResponse>> getMessages({
    required String consultationId,
    int? limit,
    String? before,
  });
}
