import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/utils/appointment_ui_helpers.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/appointment_card_facts.dart';
import 'package:tabib_app/features/doctor_flow/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/doctor_reservation_session_actions.dart';

class DoctorBookingVisitSection extends StatelessWidget {
  final DoctorAppointmentEntity appointment;

  const DoctorBookingVisitSection({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    final patient = appointment.patient;
    final phone = [
      if (patient.countryCode.isNotEmpty) patient.countryCode,
      if (patient.phone.isNotEmpty) patient.phone,
    ].join(' ');
    final feeText = appointment.currency.isEmpty
        ? '${appointment.bookingPrice}'
        : '${appointment.bookingPrice} ${appointment.currency}';
    final showSession = DoctorReservationSessionActions.showsForStatus(
      appointment.status,
    );

    return Column(
      children: [
        if (showSession) ...[
          DoctorReservationSessionActions(
            appointmentId: appointment.id,
            peerName: patient.localizedFullName(languageCode),
            canChat: appointment.actions.canAccessChat,
            canCall: appointment.actions.canAccessCall,
          ),
          const SizedBox(height: 16),
        ],
        AppointmentCardFacts(
          consultationType: appointment.consultationType,
          consultationTypeLabel: consultationTypeLabel(
            appointment.consultationType,
          ),
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
        ),
      ],
    );
  }
}
