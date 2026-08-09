class ConfirmPaymentArgs {
  final String appointmentId;
  final double consultationFee;
  final String doctorName;
  final String dateTimeText;

  const ConfirmPaymentArgs({
    required this.appointmentId,
    required this.consultationFee,
    required this.doctorName,
    required this.dateTimeText,
  });
}
