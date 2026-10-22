import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/profile/data/data_source/doctor_profile_data_source.dart';
import 'package:tabib_app/features/doctor_flow/profile/data/mapper/doctor_profile_mapper.dart';
import 'package:tabib_app/features/doctor_flow/profile/data/models/response/doctor_profile_response.dart';
import 'package:tabib_app/features/doctor_flow/profile/domain/entities/doctor_profile_entity.dart';
import 'package:tabib_app/features/doctor_flow/profile/domain/repo/doctor_profile_repo.dart';

@LazySingleton(as: DoctorProfileRepo)
class DoctorProfileRepoImpl implements DoctorProfileRepo {
  final DoctorProfileDataSource dataSource;

  DoctorProfileRepoImpl(this.dataSource);

  @override
  Future<Result<DoctorProfileEntity>> getDoctorProfile() async {
    final response = await dataSource.getDoctorProfile();
    switch (response) {
      case Success<DoctorProfileResponse>():
        final data = response.data.data;
        if (data == null) {
          return const Failure('Invalid profile response');
        }
        return Success(response.data.toEntity());
      case Failure<DoctorProfileResponse>():
        return Failure(response.errorMessage);
    }
  }
}
