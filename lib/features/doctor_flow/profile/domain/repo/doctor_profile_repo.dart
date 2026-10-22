import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/profile/domain/entities/doctor_profile_entity.dart';

abstract interface class DoctorProfileRepo {
  Future<Result<DoctorProfileEntity>> getDoctorProfile();
}
