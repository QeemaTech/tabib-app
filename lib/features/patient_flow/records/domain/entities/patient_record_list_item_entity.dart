import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_record_doctor_entity.dart';

enum PatientRecordKind { report, prescription }

class PatientRecordListItemEntity extends Equatable {
  final String id;
  final PatientRecordKind kind;
  final String referenceNumber;
  final PatientRecordDoctorEntity doctor;
  final String summary;
  final String occurredAt;

  const PatientRecordListItemEntity({
    required this.id,
    required this.kind,
    required this.referenceNumber,
    required this.doctor,
    required this.summary,
    required this.occurredAt,
  });

  @override
  List<Object?> get props => [
    id,
    kind,
    referenceNumber,
    doctor,
    summary,
    occurredAt,
  ];
}
