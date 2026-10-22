import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/patient_flow/chat/domain/entities/consultation_entity.dart';

class ChatListState extends Equatable {
  final BaseState<List<ConsultationEntity>> consultationsState;

  const ChatListState({
    this.consultationsState = const BaseState(requestState: RequestState.init),
  });

  ChatListState copyWith({
    BaseState<List<ConsultationEntity>>? consultationsState,
  }) {
    return ChatListState(
      consultationsState: consultationsState ?? this.consultationsState,
    );
  }

  @override
  List<Object?> get props => [consultationsState];
}
