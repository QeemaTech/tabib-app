import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/data_source/calls_data_source.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/mapper/agora_token_mapper.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/mapper/end_call_mapper.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/models/request/agora_token_request.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/models/response/end_call_response.dart';
import 'package:tabib_app/features/doctor_flow/calls/domain/entities/agora_token_entity.dart';
import 'package:tabib_app/features/doctor_flow/calls/domain/entities/call_session_entity.dart';
import 'package:tabib_app/features/doctor_flow/calls/domain/repo/calls_repo.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/request/start_consultation_request.dart';

@LazySingleton(as: DoctorCallsRepo)
class DoctorCallsRepoImpl implements DoctorCallsRepo {
  final DoctorCallsDataSource dataSource;

  DoctorCallsRepoImpl(this.dataSource);

  @override
  Future<Result<CallSessionEntity>> startCall({
    required String appointmentId,
    required String type,
  }) async {
    final response = await dataSource.startCall(
      appointmentId: appointmentId,
      request: DoctorStartConsultationRequest(type: type),
    );
    switch (response) {
      case Success<DoctorEndCallResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorEndCallResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<AgoraTokenEntity>> getAgoraToken({
    required String channelName,
    String role = 'publisher',
  }) async {
    final response = await dataSource.getAgoraToken(
      request: DoctorAgoraTokenRequest(channelName: channelName, role: role),
    );
    switch (response) {
      case Success<DoctorAgoraTokenResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorAgoraTokenResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<CallSessionEntity>> endCall({required String callId}) async {
    final response = await dataSource.endCall(callId: callId);
    switch (response) {
      case Success<DoctorEndCallResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorEndCallResponse>():
        return Failure(response.errorMessage);
    }
  }
}
