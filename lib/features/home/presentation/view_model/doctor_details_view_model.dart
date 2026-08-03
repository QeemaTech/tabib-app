import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/domain/entities/availability_slot_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_availability_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_details_entity.dart';
import 'package:tabib_app/features/home/domain/repo/doctor_details_repo.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_details_state.dart';

@injectable
class DoctorDetailsViewModel extends Cubit<DoctorDetailsState> {
  final DoctorDetailsRepo doctorDetailsRepo;
  String? _doctorId;

  DoctorDetailsViewModel({required this.doctorDetailsRepo})
      : super(DoctorDetailsState());

  Future<void> loadDoctorDetails(String id) async {
    _doctorId = id;
    emit(state.copyWith(doctorDetailsState: BaseState.loading()));
    final result = await doctorDetailsRepo.getDoctorDetails(id);
    switch (result) {
      case Success<DoctorDetailsEntity>():
        emit(
          state.copyWith(
            doctorDetailsState: BaseState.loaded(result.data),
          ),
        );
        await loadAvailability(state.selectedDate);
      case Failure<DoctorDetailsEntity>():
        emit(
          state.copyWith(
            doctorDetailsState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> selectDate(DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    emit(
      state.copyWith(
        selectedDate: normalizedDate,
        clearSelectedSlot: true,
      ),
    );
    await loadAvailability(normalizedDate);
  }

  Future<void> loadAvailability(DateTime date) async {
    final id = _doctorId;
    if (id == null) return;

    emit(state.copyWith(availabilityState: BaseState.loading()));
    final result = await doctorDetailsRepo.getDoctorAvailability(
      id: id,
      date: _formatDate(date),
    );
    switch (result) {
      case Success<DoctorAvailabilityEntity>():
        emit(
          state.copyWith(
            availabilityState: BaseState.loaded(result.data),
            clearSelectedSlot: true,
          ),
        );
      case Failure<DoctorAvailabilityEntity>():
        emit(
          state.copyWith(
            availabilityState: BaseState.error(result.errorMessage),
            clearSelectedSlot: true,
          ),
        );
    }
  }

  void selectSlot(AvailabilitySlotEntity slot) {
    if (!slot.available) return;
    emit(state.copyWith(selectedSlot: slot));
  }

  Future<void> retry() async {
    final id = _doctorId;
    if (id == null) return;
    await loadDoctorDetails(id);
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
