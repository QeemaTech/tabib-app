import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/profile/data/models/response/doctor_profile_response.dart';

abstract interface class DoctorProfileDataSource {
  Future<Result<DoctorProfileResponse>> getDoctorProfile();
}
