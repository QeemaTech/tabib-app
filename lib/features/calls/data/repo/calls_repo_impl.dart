import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/calls/data/data_source/calls_data_source.dart';
import 'package:tabib_app/features/calls/data/mapper/agora_token_mapper.dart';
import 'package:tabib_app/features/calls/data/mapper/end_call_mapper.dart';
import 'package:tabib_app/features/calls/data/models/request/agora_token_request.dart';
import 'package:tabib_app/features/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/calls/data/models/response/end_call_response.dart';
import 'package:tabib_app/features/calls/domain/entities/agora_token_entity.dart';
import 'package:tabib_app/features/calls/domain/entities/call_session_entity.dart';
import 'package:tabib_app/features/calls/domain/repo/calls_repo.dart';
import 'package:tabib_app/features/chat/data/models/request/start_consultation_request.dart';

@LazySingleton(as: CallsRepo)
class CallsRepoImpl implements CallsRepo {
  final CallsDataSource dataSource;

  CallsRepoImpl(this.dataSource);

  @override
  Future<Result<CallSessionEntity>> startCall({
    required String appointmentId,
    required String type,
  }) async {
    final response = await dataSource.startCall(
      appointmentId: appointmentId,
      request: StartConsultationRequest(type: type),
    );
    switch (response) {
      case Success<EndCallResponse>():
        return Success(response.data.toEntity());
      case Failure<EndCallResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<AgoraTokenEntity>> getAgoraToken({
    required String channelName,
    String role = 'publisher',
  }) async {
    final response = await dataSource.getAgoraToken(
      request: AgoraTokenRequest(channelName: channelName, role: role),
    );
    switch (response) {
      case Success<AgoraTokenResponse>():
        return Success(response.data.toEntity());
      case Failure<AgoraTokenResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<CallSessionEntity>> endCall({required String callId}) async {
    final response = await dataSource.endCall(callId: callId);
    switch (response) {
      case Success<EndCallResponse>():
        return Success(response.data.toEntity());
      case Failure<EndCallResponse>():
        return Failure(response.errorMessage);
    }
  }
}
