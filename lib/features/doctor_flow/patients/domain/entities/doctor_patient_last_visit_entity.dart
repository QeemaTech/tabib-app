import 'package:equatable/equatable.dart';

class DoctorPatientLastVisitEntity extends Equatable {
  final String appointmentId;
  final String date;
  final String startTime;

  const DoctorPatientLastVisitEntity({
    required this.appointmentId,
    required this.date,
    required this.startTime,
  });

  @override
  List<Object?> get props => [appointmentId, date, startTime];
}
