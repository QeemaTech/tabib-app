import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/chat/domain/entities/consultation_entity.dart';

abstract interface class ChatRepo {
  Future<Result<List<ConsultationEntity>>> getConsultations();
}
