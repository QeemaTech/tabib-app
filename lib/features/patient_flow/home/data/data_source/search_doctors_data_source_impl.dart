import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/home/data/data_source/search_doctors_data_source.dart';
import 'package:tabib_app/features/patient_flow/home/data/models/response/search_doctors_response.dart';

@LazySingleton(as: SearchDoctorsDataSource)
class SearchDoctorsDataSourceImpl implements SearchDoctorsDataSource {
  final ApiClient apiClient;

  SearchDoctorsDataSourceImpl(this.apiClient);

  @override
  Future<Result<SearchDoctorsResponse>> searchDoctors({
    String? search,
    String? specialty,
    int? page,
    int? limit,
  }) {
    return executeApi(
      () => apiClient.searchDoctors(
        search: search,
        specialty: specialty,
        page: page,
        limit: limit,
      ),
    );
  }
}
