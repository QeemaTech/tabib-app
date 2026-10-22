import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/data_source/doctor_schedule_data_source.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/mapper/doctor_schedule_mapper.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/request/replace_week_schedule_request.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/request/update_day_schedule_request.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/response/doctor_schedule_response.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/response/schedule_preview_response.dart';
import 'package:tabib_app/features/doctor_flow/schedule/domain/entities/schedule_day_entity.dart';
import 'package:tabib_app/features/doctor_flow/schedule/domain/entities/schedule_preview_entity.dart';
import 'package:tabib_app/features/doctor_flow/schedule/domain/repo/doctor_schedule_repo.dart';

@LazySingleton(as: DoctorScheduleRepo)
class DoctorScheduleRepoImpl implements DoctorScheduleRepo {
  final DoctorScheduleDataSource dataSource;

  DoctorScheduleRepoImpl(this.dataSource);

  @override
  Future<Result<List<ScheduleDayEntity>>> getSchedule() async {
    final response = await dataSource.getSchedule();
    switch (response) {
      case Success<DoctorScheduleResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorScheduleResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<List<ScheduleDayEntity>>> replaceSchedule(
    ReplaceWeekScheduleRequest request,
  ) async {
    final response = await dataSource.replaceSchedule(request);
    switch (response) {
      case Success<DoctorScheduleResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorScheduleResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<List<ScheduleDayEntity>>> updateDay(
    int dayOfWeek,
    UpdateDayScheduleRequest request,
  ) async {
    final response = await dataSource.updateDay(dayOfWeek, request);
    switch (response) {
      case Success<DoctorScheduleResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorScheduleResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<List<ScheduleDayEntity>>> deleteDay(int dayOfWeek) async {
    final response = await dataSource.deleteDay(dayOfWeek);
    switch (response) {
      case Success<DoctorScheduleResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorScheduleResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<SchedulePreviewEntity>> getPreview(String date) async {
    final response = await dataSource.getPreview(date);
    switch (response) {
      case Success<SchedulePreviewResponse>():
        return Success(response.data.toEntity());
      case Failure<SchedulePreviewResponse>():
        return Failure(response.errorMessage);
    }
  }
}
