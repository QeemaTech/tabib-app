import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_appointment_entity.dart';

enum DoctorAppointmentsFilter { all, confirm, holding, completed, cancel }

class DoctorAppointmentsState extends Equatable {
  final DoctorAppointmentsFilter filter;
  final BaseState<List<DoctorAppointmentEntity>> appointmentsState;

  const DoctorAppointmentsState({
    this.filter = DoctorAppointmentsFilter.all,
    this.appointmentsState = const BaseState(requestState: RequestState.init),
  });

  String? get apiStatus {
    switch (filter) {
      case DoctorAppointmentsFilter.all:
        return null;
      case DoctorAppointmentsFilter.confirm:
        return 'CONFIRMED';
      case DoctorAppointmentsFilter.holding:
        return 'PENDING';
      case DoctorAppointmentsFilter.completed:
        return 'COMPLETED';
      case DoctorAppointmentsFilter.cancel:
        return 'CANCELLED';
    }
  }

  DoctorAppointmentsState copyWith({
    DoctorAppointmentsFilter? filter,
    BaseState<List<DoctorAppointmentEntity>>? appointmentsState,
  }) {
    return DoctorAppointmentsState(
      filter: filter ?? this.filter,
      appointmentsState: appointmentsState ?? this.appointmentsState,
    );
  }

  @override
  List<Object?> get props => [filter, appointmentsState];
}
