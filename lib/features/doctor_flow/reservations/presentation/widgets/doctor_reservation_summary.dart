import 'package:flutter/material.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/utils/appointment_ui_helpers.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/appointment_card_facts.dart';
import 'package:tabib_app/features/doctor_flow/reservations/domain/entities/doctor_appointment_entity.dart';

class DoctorReservationSummary extends StatelessWidget {
  final DoctorAppointmentEntity appointment;

  const DoctorReservationSummary({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final patient = appointment.patient;
    final phone = [
      if (patient.countryCode.isNotEmpty) patient.countryCode,
      if (patient.phone.isNotEmpty) patient.phone,
    ].join(' ');
    final currency = appointment.currency;
    final feeText = currency.isEmpty
        ? '${appointment.bookingPrice}'
        : '${appointment.bookingPrice} $currency';

    return AppointmentCardFacts(
      consultationType: '',
      consultationTypeLabel: '',
      dateText: formatAppointmentDate(appointment.date),
      timeText: formatAppointmentTimeRange(
        startTime: appointment.startTime,
        endTime: appointment.endTime,
      ),
      durationText: appointmentDurationLabel(
        consultationType: appointment.consultationType,
        durationChatHours: appointment.durationChatHours,
        durationCallMinutes: appointment.durationCallMinutes,
      ),
      feeText: feeText,
      complaint: appointment.complaint.isNotEmpty
          ? appointment.complaint
          : patient.medicalComplaint,
      symptoms: appointment.symptoms.isNotEmpty
          ? appointment.symptoms
          : patient.medicalSymptoms,
      notes: appointment.notes,
      phone: phone,
      cancelReason: appointment.status.toUpperCase() == 'CANCELLED'
          ? appointment.cancelReason
          : '',
    );
  }
}
