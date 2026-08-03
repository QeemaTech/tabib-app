import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/data/models/response/doctor_details_response.dart';

abstract interface class DoctorDetailsDataSource {
  Future<Result<DoctorDetailsResponse>> getDoctorDetails(String id);
}
