import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_appointment_entity.dart';

enum DoctorAppointmentsFilter { all, confirm, holding, completed, cancel }

DateTime _dateOnly(DateTime date) =>
    DateTime(date.year, date.month, date.day);

class DoctorAppointmentsState extends Equatable {
  final DoctorAppointmentsFilter filter;
  final DateTime selectedDate;
  final BaseState<List<DoctorAppointmentEntity>> appointmentsState;

  DoctorAppointmentsState({
    this.filter = DoctorAppointmentsFilter.all,
    DateTime? selectedDate,
    this.appointmentsState = const BaseState(requestState: RequestState.init),
  }) : selectedDate = _dateOnly(selectedDate ?? DateTime.now());

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
    DateTime? selectedDate,
    BaseState<List<DoctorAppointmentEntity>>? appointmentsState,
  }) {
    return DoctorAppointmentsState(
      filter: filter ?? this.filter,
      selectedDate: selectedDate ?? this.selectedDate,
      appointmentsState: appointmentsState ?? this.appointmentsState,
    );
  }

  @override
  List<Object?> get props => [filter, selectedDate, appointmentsState];
}
