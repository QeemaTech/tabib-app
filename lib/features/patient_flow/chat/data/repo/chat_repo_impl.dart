import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/chat/data/data_source/chat_data_source.dart';
import 'package:tabib_app/features/patient_flow/chat/data/mapper/consultations_mapper.dart';
import 'package:tabib_app/features/patient_flow/chat/data/mapper/messages_mapper.dart';
import 'package:tabib_app/features/patient_flow/chat/data/mapper/start_consultation_mapper.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/request/start_consultation_request.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/response/consultations_response.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/response/messages_response.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/response/start_consultation_response.dart';
import 'package:tabib_app/features/patient_flow/chat/domain/entities/consultation_entity.dart';
import 'package:tabib_app/features/patient_flow/chat/domain/entities/messages_page_entity.dart';
import 'package:tabib_app/features/patient_flow/chat/domain/entities/started_consultation_entity.dart';
import 'package:tabib_app/features/patient_flow/chat/domain/repo/chat_repo.dart';

@LazySingleton(as: PatientChatRepo)
class PatientChatRepoImpl implements PatientChatRepo {
  final PatientChatDataSource dataSource;

  PatientChatRepoImpl(this.dataSource);

  @override
  Future<Result<List<ConsultationEntity>>> getConsultations() async {
    final response = await dataSource.getConsultations();
    switch (response) {
      case Success<PatientConsultationsResponse>():
        return Success(response.data.toEntityList());
      case Failure<PatientConsultationsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<StartedConsultationEntity>> startConsultation({
    required String appointmentId,
    String type = 'CHAT',
  }) async {
    final response = await dataSource.startConsultation(
      appointmentId: appointmentId,
      request: PatientStartConsultationRequest(type: type),
    );
    switch (response) {
      case Success<PatientStartConsultationResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientStartConsultationResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<MessagesPageEntity>> getMessages({
    required String consultationId,
    required String currentRole,
    int limit = 30,
    String? before,
  }) async {
    final response = await dataSource.getMessages(
      consultationId: consultationId,
      limit: limit,
      before: before,
    );
    switch (response) {
      case Success<PatientMessagesResponse>():
        return Success(
          response.data.toEntity(currentRole: currentRole),
        );
      case Failure<PatientMessagesResponse>():
        return Failure(response.errorMessage);
    }
  }
}
