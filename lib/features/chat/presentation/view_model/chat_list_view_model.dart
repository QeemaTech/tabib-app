import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/chat/domain/entities/consultation_entity.dart';
import 'package:tabib_app/features/chat/domain/repo/chat_repo.dart';
import 'package:tabib_app/features/chat/presentation/view_model/chat_list_state.dart';

@injectable
class ChatListViewModel extends Cubit<ChatListState> {
  final ChatRepo chatRepo;

  ChatListViewModel({required this.chatRepo}) : super(const ChatListState());

  Future<void> loadConsultations({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(consultationsState: BaseState.loading()));
    }
    final result = await chatRepo.getConsultations();
    switch (result) {
      case Success<List<ConsultationEntity>>():
        emit(
          state.copyWith(
            consultationsState: BaseState.loaded(result.data),
          ),
        );
      case Failure<List<ConsultationEntity>>():
        emit(
          state.copyWith(
            consultationsState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> retry() => loadConsultations();

  Future<void> refreshConsultations() => loadConsultations(showLoading: false);
}
