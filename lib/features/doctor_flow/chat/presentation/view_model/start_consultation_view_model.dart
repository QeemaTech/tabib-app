import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/chat/domain/entities/started_consultation_entity.dart';
import 'package:tabib_app/features/doctor_flow/chat/domain/repo/chat_repo.dart';
import 'package:tabib_app/features/doctor_flow/chat/presentation/view_model/start_consultation_state.dart';

@injectable
class DoctorStartConsultationViewModel extends Cubit<StartConsultationState> {
  final DoctorChatRepo chatRepo;

  DoctorStartConsultationViewModel({required this.chatRepo})
      : super(const StartConsultationState());

  Future<void> startChat(String appointmentId) async {
    if (state.startState.isLoading) return;

    emit(
      state.copyWith(
        appointmentId: appointmentId,
        startState: BaseState.loading(),
      ),
    );

    final result = await chatRepo.startConsultation(
      appointmentId: appointmentId,
    );

    switch (result) {
      case Success<StartedConsultationEntity>():
        emit(
          state.copyWith(
            startState: BaseState.loaded(result.data),
          ),
        );
      case Failure<StartedConsultationEntity>():
        emit(
          state.copyWith(
            startState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  void reset() {
    emit(const StartConsultationState());
  }
}
