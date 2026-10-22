import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/auth/data/data_source/doctor_onboarding_data_source.dart';
import 'package:tabib_app/features/patient_flow/auth/data/mapper/doctor_onboarding_mapper.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/specialties_response.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/specialty_entity.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/repo/doctor_onboarding_repo.dart';

@LazySingleton(as: PatientCatalogRepo)
class PatientCatalogRepoImpl implements PatientCatalogRepo {
  final PatientCatalogDataSource dataSource;

  PatientCatalogRepoImpl(this.dataSource);

  @override
  Future<Result<List<SpecialtyEntity>>> getSpecialties({
    String? parentId,
  }) async {
    final response = await dataSource.getSpecialties(parentId: parentId);
    switch (response) {
      case Success<PatientSpecialtiesResponse>():
        return Success(response.data.toEntityList());
      case Failure<PatientSpecialtiesResponse>():
        return Failure(response.errorMessage);
    }
  }
}
