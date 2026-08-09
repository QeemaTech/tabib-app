import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/chat/data/models/response/consultations_response.dart';

abstract interface class ChatDataSource {
  Future<Result<ConsultationsResponse>> getConsultations();
}
