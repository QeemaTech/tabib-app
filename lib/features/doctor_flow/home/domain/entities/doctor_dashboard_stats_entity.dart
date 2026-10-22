import 'package:equatable/equatable.dart';

class DoctorDashboardStatsEntity extends Equatable {
  final int todayCount;
  final int weekCount;
  final int completedCount;
  final int totalCompletedCount;
  final int pendingCount;
  final double rating;
  final int ratingCount;
  final double earnings;

  const DoctorDashboardStatsEntity({
    required this.todayCount,
    required this.weekCount,
    required this.completedCount,
    required this.totalCompletedCount,
    required this.pendingCount,
    required this.rating,
    required this.ratingCount,
    required this.earnings,
  });

  @override
  List<Object?> get props => [
        todayCount,
        weekCount,
        completedCount,
        totalCompletedCount,
        pendingCount,
        rating,
        ratingCount,
        earnings,
      ];
}
