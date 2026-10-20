import 'package:equatable/equatable.dart';

class CallSessionEntity extends Equatable {
  final String id;
  final String appointmentId;
  final String channelName;
  final String callType;
  final String status;
  final String startedAt;
  final int durationSeconds;

  const CallSessionEntity({
    required this.id,
    required this.appointmentId,
    required this.channelName,
    required this.callType,
    required this.status,
    required this.startedAt,
    required this.durationSeconds,
  });

  @override
  List<Object?> get props => [
        id,
        appointmentId,
        channelName,
        callType,
        status,
        startedAt,
        durationSeconds,
      ];
}
