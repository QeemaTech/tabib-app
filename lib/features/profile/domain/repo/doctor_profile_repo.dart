import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/profile/domain/entities/doctor_profile_entity.dart';

abstract interface class DoctorProfileRepo {
  Future<Result<DoctorProfileEntity>> getDoctorProfile();
}
