import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/chat/domain/entities/message_entity.dart';

class MessagesPageEntity extends Equatable {
  final List<MessageEntity> messages;
  final bool hasMore;
  final String? nextBefore;

  const MessagesPageEntity({
    required this.messages,
    required this.hasMore,
    this.nextBefore,
  });

  @override
  List<Object?> get props => [messages, hasMore, nextBefore];
}
