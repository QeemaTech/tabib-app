import 'package:equatable/equatable.dart';

class PatientFileAppointmentEntity extends Equatable {
  final String id;
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final String consultationType;
  final num bookingPrice;
  final String currency;
  final String notes;

  const PatientFileAppointmentEntity({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.consultationType,
    required this.bookingPrice,
    required this.currency,
    required this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        startTime,
        endTime,
        status,
        consultationType,
        bookingPrice,
        currency,
        notes,
      ];
}
