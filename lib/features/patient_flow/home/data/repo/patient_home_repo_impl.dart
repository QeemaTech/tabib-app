import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/home/data/data_source/patient_home_data_source.dart';
import 'package:tabib_app/features/patient_flow/home/data/mapper/patient_home_mapper.dart';
import 'package:tabib_app/features/patient_flow/home/data/models/response/patient_home_response.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/patient_home_entity.dart';
import 'package:tabib_app/features/patient_flow/home/domain/repo/patient_home_repo.dart';

@LazySingleton(as: PatientHomeRepo)
class PatientHomeRepoImpl implements PatientHomeRepo {
  final PatientHomeDataSource dataSource;

  PatientHomeRepoImpl(this.dataSource);

  @override
  Future<Result<PatientHomeEntity>> getPatientHome() async {
    final response = await dataSource.getPatientHome();
    switch (response) {
      case Success<PatientHomeResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientHomeResponse>():
        return Failure(response.errorMessage);
    }
  }
}
