import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_invoice_entity.dart';

class PatientInvoicesPageEntity extends Equatable {
  final List<PatientInvoiceEntity> items;
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  const PatientInvoicesPageEntity({
    required this.items,
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  bool get hasMore => page < totalPages;

  @override
  List<Object?> get props => [items, page, limit, total, totalPages];
}
