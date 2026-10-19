import 'package:equatable/equatable.dart';

class AgoraTokenEntity extends Equatable {
  final String token;
  final String channelName;
  final String appId;
  final String expiresAt;

  const AgoraTokenEntity({
    required this.token,
    required this.channelName,
    required this.appId,
    required this.expiresAt,
  });

  @override
  List<Object?> get props => [token, channelName, appId, expiresAt];
}
