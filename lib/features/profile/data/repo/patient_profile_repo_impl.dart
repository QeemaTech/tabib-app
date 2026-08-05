import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/profile/data/data_source/patient_profile_data_source.dart';
import 'package:tabib_app/features/profile/data/mapper/patient_profile_mapper.dart';
import 'package:tabib_app/features/profile/data/models/request/update_patient_profile_request.dart';
import 'package:tabib_app/features/profile/data/models/response/patient_profile_response.dart';
import 'package:tabib_app/features/profile/domain/entities/patient_profile_entity.dart';
import 'package:tabib_app/features/profile/domain/repo/patient_profile_repo.dart';

@LazySingleton(as: PatientProfileRepo)
class PatientProfileRepoImpl implements PatientProfileRepo {
  final PatientProfileDataSource dataSource;

  PatientProfileRepoImpl(this.dataSource);

  @override
  Future<Result<PatientProfileEntity>> getPatientProfile() async {
    final response = await dataSource.getPatientProfile();
    return _mapResponse(response);
  }

  @override
  Future<Result<PatientProfileEntity>> updatePatientProfile({
    required String fullNameAr,
    required String fullNameEn,
    required String fullNameSo,
    required String dateOfBirth,
    required String gender,
    required String bloodType,
    required String allergies,
    required String chronicConditions,
  }) async {
    final response = await dataSource.updatePatientProfile(
      UpdatePatientProfileRequest(
        fullNameAr: fullNameAr,
        fullNameEn: fullNameEn,
        fullNameSo: fullNameSo,
        dateOfBirth: dateOfBirth,
        gender: gender,
        bloodType: bloodType,
        allergies: allergies,
        chronicConditions: chronicConditions,
      ),
    );
    return _mapResponse(response);
  }

  Result<PatientProfileEntity> _mapResponse(
    Result<PatientProfileResponse> response,
  ) {
    switch (response) {
      case Success<PatientProfileResponse>():
        final data = response.data.data;
        if (data == null) {
          return const Failure('Invalid profile response');
        }
        return Success(data.toEntity());
      case Failure<PatientProfileResponse>():
        return Failure(response.errorMessage);
    }
  }
}
