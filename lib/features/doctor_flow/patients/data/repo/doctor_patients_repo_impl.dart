import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/patients/data/data_source/doctor_patients_data_source.dart';
import 'package:tabib_app/features/doctor_flow/patients/data/mapper/doctor_patients_mapper.dart';
import 'package:tabib_app/features/doctor_flow/patients/data/models/response/doctor_patients_response.dart';
import 'package:tabib_app/features/doctor_flow/patients/domain/entities/doctor_patient_entity.dart';
import 'package:tabib_app/features/doctor_flow/patients/domain/repo/doctor_patients_repo.dart';

@LazySingleton(as: DoctorPatientsRepo)
class DoctorPatientsRepoImpl implements DoctorPatientsRepo {
  final DoctorPatientsDataSource dataSource;

  DoctorPatientsRepoImpl(this.dataSource);

  @override
  Future<Result<List<DoctorPatientEntity>>> getPatients({
    String? search,
    required String filter,
  }) async {
    final response = await dataSource.getPatients(
      search: search,
      filter: filter,
    );
    switch (response) {
      case Success<DoctorPatientsResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorPatientsResponse>():
        return Failure(response.errorMessage);
    }
  }
}
