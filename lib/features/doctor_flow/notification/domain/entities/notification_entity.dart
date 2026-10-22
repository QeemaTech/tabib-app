import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String body;
  final String type;
  final String appointmentId;
  final bool isRead;
  final String sentAt;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.appointmentId,
    required this.isRead,
    required this.sentAt,
  });

  NotificationEntity copyWith({bool? isRead}) {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      type: type,
      appointmentId: appointmentId,
      isRead: isRead ?? this.isRead,
      sentAt: sentAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    body,
    type,
    appointmentId,
    isRead,
    sentAt,
  ];
}
