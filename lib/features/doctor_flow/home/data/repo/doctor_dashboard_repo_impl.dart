import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/home/data/data_source/doctor_dashboard_data_source.dart';
import 'package:tabib_app/features/doctor_flow/home/data/mapper/doctor_dashboard_mapper.dart';
import 'package:tabib_app/features/doctor_flow/home/data/models/response/doctor_dashboard_response.dart';
import 'package:tabib_app/features/doctor_flow/home/domain/entities/doctor_dashboard_entity.dart';
import 'package:tabib_app/features/doctor_flow/home/domain/repo/doctor_dashboard_repo.dart';

@LazySingleton(as: DoctorDashboardRepo)
class DoctorDashboardRepoImpl implements DoctorDashboardRepo {
  final DoctorDashboardDataSource dataSource;

  DoctorDashboardRepoImpl(this.dataSource);

  @override
  Future<Result<DoctorDashboardEntity>> getDoctorDashboard() async {
    final response = await dataSource.getDoctorDashboard();
    switch (response) {
      case Success<DoctorDashboardResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorDashboardResponse>():
        return Failure(response.errorMessage);
    }
  }
}
