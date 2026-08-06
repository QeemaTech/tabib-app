import 'package:tabib_app/features/home/data/models/response/doctor_dashboard_response.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_dashboard_appointment_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_dashboard_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_dashboard_stats_entity.dart';

extension DoctorDashboardResponseMapper on DoctorDashboardResponse {
  DoctorDashboardEntity toEntity() {
    final data = this.data;
    return DoctorDashboardEntity(
      todayAppointments: data?.todayAppointments
              ?.map((item) => item.toEntity())
              .toList() ??
          const [],
      pendingRequests: data?.pendingRequests
              ?.map((item) => item.toEntity())
              .toList() ??
          const [],
      stats: data?.stats?.toEntity() ??
          const DoctorDashboardStatsEntity(
            todayCount: 0,
            weekCount: 0,
            completedCount: 0,
            totalCompletedCount: 0,
            pendingCount: 0,
            rating: 0,
            ratingCount: 0,
            earnings: 0,
          ),
    );
  }
}

extension DoctorDashboardStatsResponseMapper on DoctorDashboardStatsResponse {
  DoctorDashboardStatsEntity toEntity() {
    return DoctorDashboardStatsEntity(
      todayCount: todayCount ?? 0,
      weekCount: weekCount ?? 0,
      completedCount: completedCount ?? 0,
      totalCompletedCount: totalCompletedCount ?? 0,
      pendingCount: pendingCount ?? 0,
      rating: rating?.toDouble() ?? 0,
      ratingCount: ratingCount ?? 0,
      earnings: earnings?.toDouble() ?? 0,
    );
  }
}

extension DoctorDashboardAppointmentResponseMapper
    on DoctorDashboardAppointmentResponse {
  DoctorDashboardAppointmentEntity toEntity() {
    return DoctorDashboardAppointmentEntity(
      id: id ?? '',
      date: date ?? '',
      startTime: startTime ?? '',
      endTime: endTime ?? '',
      status: status ?? '',
      consultationType: consultationType ?? '',
      bookingPrice: bookingPrice?.toDouble() ?? 0,
      currency: currency ?? '',
      sessionStartsAt: sessionStartsAt ?? '',
      durationChatHours: durationChatHours ?? 0,
      durationCallMinutes: durationCallMinutes ?? 0,
      accessWindows: accessWindows?.toEntity() ??
          const DoctorDashboardAccessWindowsEntity(
            chat: DoctorDashboardChatAccessEntity(
              isActive: false,
              remainingHours: 0,
            ),
            call: DoctorDashboardCallAccessEntity(
              isActive: false,
              durationMinutes: 0,
              usedSeconds: 0,
              remainingSeconds: 0,
            ),
          ),
      actions: actions?.toEntity() ??
          const DoctorDashboardActionsEntity(
            canAccessChat: false,
            canAccessCall: false,
          ),
      createdAt: createdAt ?? '',
      patient: patient?.toEntity() ??
          const DoctorDashboardPatientEntity(
            id: '',
            fullNameAr: '',
            avatarUrl: '',
            phone: '',
            countryCode: '',
          ),
    );
  }
}

extension DoctorDashboardPatientResponseMapper
    on DoctorDashboardPatientResponse {
  DoctorDashboardPatientEntity toEntity() {
    return DoctorDashboardPatientEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
      avatarUrl: avatarUrl ?? '',
      phone: phone ?? '',
      countryCode: countryCode ?? '',
    );
  }
}

extension DoctorDashboardAccessWindowsResponseMapper
    on DoctorDashboardAccessWindowsResponse {
  DoctorDashboardAccessWindowsEntity toEntity() {
    return DoctorDashboardAccessWindowsEntity(
      chat: chat?.toEntity() ??
          const DoctorDashboardChatAccessEntity(
            isActive: false,
            remainingHours: 0,
          ),
      call: call?.toEntity() ??
          const DoctorDashboardCallAccessEntity(
            isActive: false,
            durationMinutes: 0,
            usedSeconds: 0,
            remainingSeconds: 0,
          ),
    );
  }
}

extension DoctorDashboardChatAccessResponseMapper
    on DoctorDashboardChatAccessResponse {
  DoctorDashboardChatAccessEntity toEntity() {
    return DoctorDashboardChatAccessEntity(
      isActive: isActive ?? false,
      remainingHours: remainingHours?.toDouble() ?? 0,
    );
  }
}

extension DoctorDashboardCallAccessResponseMapper
    on DoctorDashboardCallAccessResponse {
  DoctorDashboardCallAccessEntity toEntity() {
    return DoctorDashboardCallAccessEntity(
      isActive: isActive ?? false,
      durationMinutes: durationMinutes ?? 0,
      usedSeconds: usedSeconds ?? 0,
      remainingSeconds: remainingSeconds ?? 0,
    );
  }
}

extension DoctorDashboardActionsResponseMapper
    on DoctorDashboardActionsResponse {
  DoctorDashboardActionsEntity toEntity() {
    return DoctorDashboardActionsEntity(
      canAccessChat: canAccessChat ?? false,
      canAccessCall: canAccessCall ?? false,
    );
  }
}
