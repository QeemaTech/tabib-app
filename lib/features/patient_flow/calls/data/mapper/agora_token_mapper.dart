import 'package:tabib_app/features/patient_flow/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/patient_flow/calls/domain/entities/agora_token_entity.dart';

extension PatientAgoraTokenResponseMapper on PatientAgoraTokenResponse {
  AgoraTokenEntity toEntity() {
    return data?.toEntity() ??
        const AgoraTokenEntity(
          token: '',
          channelName: '',
          appId: '',
          expiresAt: '',
        );
  }
}

extension AgoraTokenDataResponseMapper on AgoraTokenDataResponse {
  AgoraTokenEntity toEntity() {
    return AgoraTokenEntity(
      token: token ?? '',
      channelName: channelName ?? '',
      appId: appId ?? '',
      expiresAt: expiresAt ?? '',
      uid: uid,
    );
  }
}
