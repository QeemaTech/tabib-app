import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/specialty_entity.dart';

abstract interface class PatientCatalogRepo {
  Future<Result<List<SpecialtyEntity>>> getSpecialties({String? parentId});
}
