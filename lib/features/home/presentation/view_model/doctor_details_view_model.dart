import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_details_entity.dart';
import 'package:tabib_app/features/home/domain/repo/doctor_details_repo.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_details_state.dart';

@injectable
class DoctorDetailsViewModel extends Cubit<DoctorDetailsState> {
  final DoctorDetailsRepo doctorDetailsRepo;
  String? _doctorId;

  DoctorDetailsViewModel({required this.doctorDetailsRepo})
      : super(const DoctorDetailsState());

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
      case Failure<DoctorDetailsEntity>():
        emit(
          state.copyWith(
            doctorDetailsState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> retry() async {
    final id = _doctorId;
    if (id == null) return;
    await loadDoctorDetails(id);
  }
}
