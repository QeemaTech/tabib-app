import 'package:equatable/equatable.dart';

class PatientRecordActionsEntity extends Equatable {
  final bool canDownloadPdf;
  final String downloadPdfUrl;
  final bool canBookFollowUp;
  final String doctorId;

  const PatientRecordActionsEntity({
    required this.canDownloadPdf,
    required this.downloadPdfUrl,
    required this.canBookFollowUp,
    required this.doctorId,
  });

  const PatientRecordActionsEntity.empty()
    : canDownloadPdf = false,
      downloadPdfUrl = '',
      canBookFollowUp = false,
      doctorId = '';

  bool get showDownload => canDownloadPdf && downloadPdfUrl.isNotEmpty;

  bool get showFollowUp => canBookFollowUp && doctorId.isNotEmpty;

  bool get hasAny => showDownload || showFollowUp;

  @override
  List<Object?> get props => [
    canDownloadPdf,
    downloadPdfUrl,
    canBookFollowUp,
    doctorId,
  ];
}
