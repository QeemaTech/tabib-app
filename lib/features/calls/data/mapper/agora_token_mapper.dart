import 'package:tabib_app/features/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/calls/domain/entities/agora_token_entity.dart';

extension AgoraTokenResponseMapper on AgoraTokenResponse {
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
    );
  }
}
