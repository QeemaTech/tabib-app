import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/invoice_file_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_invoice_entity.dart';

class PatientInvoicesState extends Equatable {
  final BaseState<List<PatientInvoiceEntity>> invoicesState;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final String? downloadingInvoiceId;
  final BaseState<InvoiceFileEntity> downloadState;

  const PatientInvoicesState({
    this.invoicesState = const BaseState(requestState: RequestState.init),
    this.page = 1,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.downloadingInvoiceId,
    this.downloadState = const BaseState(requestState: RequestState.init),
  });

  PatientInvoicesState copyWith({
    BaseState<List<PatientInvoiceEntity>>? invoicesState,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    String? downloadingInvoiceId,
    bool clearDownloading = false,
    BaseState<InvoiceFileEntity>? downloadState,
  }) {
    return PatientInvoicesState(
      invoicesState: invoicesState ?? this.invoicesState,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      downloadingInvoiceId: clearDownloading
          ? null
          : downloadingInvoiceId ?? this.downloadingInvoiceId,
      downloadState: downloadState ?? this.downloadState,
    );
  }

  @override
  List<Object?> get props => [
    invoicesState,
    page,
    hasMore,
    isLoadingMore,
    downloadingInvoiceId,
    downloadState,
  ];
}
