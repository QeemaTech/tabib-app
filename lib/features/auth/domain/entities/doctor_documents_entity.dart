import 'package:equatable/equatable.dart';

class DoctorDocumentsEntity extends Equatable {
  final String verificationStatus;
  final String message;
  final bool documentsSubmitted;

  const DoctorDocumentsEntity({
    required this.verificationStatus,
    required this.message,
    required this.documentsSubmitted,
  });

  @override
  List<Object?> get props => [
        verificationStatus,
        message,
        documentsSubmitted,
      ];
}
