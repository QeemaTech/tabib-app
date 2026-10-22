import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/specialties_response.dart';

abstract interface class PatientCatalogDataSource {
  Future<Result<PatientSpecialtiesResponse>> getSpecialties({String? parentId});
}
