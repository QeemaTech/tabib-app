import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_dashboard_entity.dart';
import 'package:tabib_app/features/home/domain/repo/doctor_dashboard_repo.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_dashboard_state.dart';

@injectable
class DoctorDashboardViewModel extends Cubit<DoctorDashboardState> {
  final DoctorDashboardRepo doctorDashboardRepo;

  DoctorDashboardViewModel({required this.doctorDashboardRepo})
      : super(const DoctorDashboardState());

  Future<void> loadDashboard() async {
    emit(state.copyWith(dashboardState: BaseState.loading()));
    final result = await doctorDashboardRepo.getDoctorDashboard();
    switch (result) {
      case Success<DoctorDashboardEntity>():
        emit(
          state.copyWith(
            dashboardState: BaseState.loaded(result.data),
          ),
        );
      case Failure<DoctorDashboardEntity>():
        emit(
          state.copyWith(
            dashboardState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }
}
