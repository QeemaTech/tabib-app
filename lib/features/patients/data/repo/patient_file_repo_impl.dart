import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patients/data/data_source/patient_file_data_source.dart';
import 'package:tabib_app/features/patients/data/mapper/patient_file_mapper.dart';
import 'package:tabib_app/features/patients/data/models/response/patient_file_response.dart';
import 'package:tabib_app/features/patients/domain/entities/patient_file_entity.dart';
import 'package:tabib_app/features/patients/domain/repo/patient_file_repo.dart';

@LazySingleton(as: PatientFileRepo)
class PatientFileRepoImpl implements PatientFileRepo {
  final PatientFileDataSource dataSource;

  PatientFileRepoImpl(this.dataSource);

  @override
  Future<Result<PatientFileEntity>> getPatientFile(
    String appointmentId,
  ) async {
    final response = await dataSource.getPatientFile(appointmentId);
    switch (response) {
      case Success<PatientFileResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientFileResponse>():
        return Failure(response.errorMessage);
    }
  }
}
