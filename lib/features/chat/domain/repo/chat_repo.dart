import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/chat/domain/entities/consultation_entity.dart';
import 'package:tabib_app/features/chat/domain/entities/messages_page_entity.dart';
import 'package:tabib_app/features/chat/domain/entities/started_consultation_entity.dart';

abstract interface class ChatRepo {
  Future<Result<List<ConsultationEntity>>> getConsultations();

  Future<Result<StartedConsultationEntity>> startConsultation({
    required String appointmentId,
    String type = 'CHAT',
  });

  Future<Result<MessagesPageEntity>> getMessages({
    required String consultationId,
    required String currentRole,
    int limit = 30,
    String? before,
  });
}
