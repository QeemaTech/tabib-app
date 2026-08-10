import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/chat/data/models/request/start_consultation_request.dart';
import 'package:tabib_app/features/chat/data/models/response/consultations_response.dart';
import 'package:tabib_app/features/chat/data/models/response/start_consultation_response.dart';

abstract interface class ChatDataSource {
  Future<Result<ConsultationsResponse>> getConsultations();

  Future<Result<StartConsultationResponse>> startConsultation({
    required String appointmentId,
    required StartConsultationRequest request,
  });
}
