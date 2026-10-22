class ConfirmPaymentArgs {
  final String appointmentId;
  final double bookingPrice;
  final String doctorName;
  final String dateTimeText;
  final String currency;

  const ConfirmPaymentArgs({
    required this.appointmentId,
    required this.bookingPrice,
    required this.doctorName,
    required this.dateTimeText,
    required this.currency,
  });
}
