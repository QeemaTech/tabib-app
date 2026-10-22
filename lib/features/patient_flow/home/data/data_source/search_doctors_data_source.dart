import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/home/data/models/response/search_doctors_response.dart';

abstract interface class SearchDoctorsDataSource {
  Future<Result<SearchDoctorsResponse>> searchDoctors({
    String? search,
    String? specialty,
    int? page,
    int? limit,
  });
}
