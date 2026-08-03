import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_details_entity.dart';

abstract interface class DoctorDetailsRepo {
  Future<Result<DoctorDetailsEntity>> getDoctorDetails(String id);
}
