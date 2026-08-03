import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/data/data_source/doctor_details_data_source.dart';
import 'package:tabib_app/features/home/data/mapper/doctor_details_mapper.dart';
import 'package:tabib_app/features/home/data/models/response/doctor_details_response.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_details_entity.dart';
import 'package:tabib_app/features/home/domain/repo/doctor_details_repo.dart';

@LazySingleton(as: DoctorDetailsRepo)
class DoctorDetailsRepoImpl implements DoctorDetailsRepo {
  final DoctorDetailsDataSource dataSource;

  DoctorDetailsRepoImpl(this.dataSource);

  @override
  Future<Result<DoctorDetailsEntity>> getDoctorDetails(String id) async {
    final response = await dataSource.getDoctorDetails(id);
    switch (response) {
      case Success<DoctorDetailsResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorDetailsResponse>():
        return Failure(response.errorMessage);
    }
  }
}
