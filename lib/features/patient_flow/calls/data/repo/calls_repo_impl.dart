import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/calls/data/data_source/calls_data_source.dart';
import 'package:tabib_app/features/patient_flow/calls/data/mapper/agora_token_mapper.dart';
import 'package:tabib_app/features/patient_flow/calls/data/mapper/end_call_mapper.dart';
import 'package:tabib_app/features/patient_flow/calls/data/models/request/agora_token_request.dart';
import 'package:tabib_app/features/patient_flow/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/patient_flow/calls/data/models/response/end_call_response.dart';
import 'package:tabib_app/features/patient_flow/calls/domain/entities/agora_token_entity.dart';
import 'package:tabib_app/features/patient_flow/calls/domain/entities/call_session_entity.dart';
import 'package:tabib_app/features/patient_flow/calls/domain/repo/calls_repo.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/request/start_consultation_request.dart';

@LazySingleton(as: PatientCallsRepo)
class PatientCallsRepoImpl implements PatientCallsRepo {
  final PatientCallsDataSource dataSource;

  PatientCallsRepoImpl(this.dataSource);

  @override
  Future<Result<CallSessionEntity>> startCall({
    required String appointmentId,
    required String type,
  }) async {
    final response = await dataSource.startCall(
      appointmentId: appointmentId,
      request: PatientStartConsultationRequest(type: type),
    );
    switch (response) {
      case Success<PatientEndCallResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientEndCallResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<AgoraTokenEntity>> getAgoraToken({
    required String channelName,
    String role = 'publisher',
  }) async {
    final response = await dataSource.getAgoraToken(
      request: PatientAgoraTokenRequest(channelName: channelName, role: role),
    );
    switch (response) {
      case Success<PatientAgoraTokenResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientAgoraTokenResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<CallSessionEntity>> endCall({required String callId}) async {
    final response = await dataSource.endCall(callId: callId);
    switch (response) {
      case Success<PatientEndCallResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientEndCallResponse>():
        return Failure(response.errorMessage);
    }
  }
}
