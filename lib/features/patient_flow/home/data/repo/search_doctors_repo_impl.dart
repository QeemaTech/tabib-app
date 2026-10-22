import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/home/data/data_source/search_doctors_data_source.dart';
import 'package:tabib_app/features/patient_flow/home/data/mapper/search_doctors_mapper.dart';
import 'package:tabib_app/features/patient_flow/home/data/models/response/search_doctors_response.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/search_doctor_entity.dart';
import 'package:tabib_app/features/patient_flow/home/domain/repo/search_doctors_repo.dart';

@LazySingleton(as: SearchDoctorsRepo)
class SearchDoctorsRepoImpl implements SearchDoctorsRepo {
  final SearchDoctorsDataSource dataSource;

  SearchDoctorsRepoImpl(this.dataSource);

  @override
  Future<Result<SearchDoctorsResultEntity>> searchDoctors({
    String? search,
    String? specialty,
    int? page,
    int? limit,
  }) async {
    final response = await dataSource.searchDoctors(
      search: search,
      specialty: specialty,
      page: page,
      limit: limit,
    );
    switch (response) {
      case Success<SearchDoctorsResponse>():
        return Success(response.data.toEntity());
      case Failure<SearchDoctorsResponse>():
        return Failure(response.errorMessage);
    }
  }
}
