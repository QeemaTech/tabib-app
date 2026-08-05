import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/profile/data/models/request/update_patient_profile_request.dart';
import 'package:tabib_app/features/profile/data/models/response/patient_profile_response.dart';

abstract interface class PatientProfileDataSource {
  Future<Result<PatientProfileResponse>> getPatientProfile();

  Future<Result<PatientProfileResponse>> updatePatientProfile(
    UpdatePatientProfileRequest request,
  );
}
