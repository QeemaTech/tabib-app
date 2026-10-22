import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/search_doctor_entity.dart';

abstract interface class SearchDoctorsRepo {
  Future<Result<SearchDoctorsResultEntity>> searchDoctors({
    String? search,
    String? specialty,
    int? page,
    int? limit,
  });
}
