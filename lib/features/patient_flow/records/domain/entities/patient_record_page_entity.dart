import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_record_list_item_entity.dart';

class PatientRecordPageEntity extends Equatable {
  final List<PatientRecordListItemEntity> items;
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  const PatientRecordPageEntity({
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
