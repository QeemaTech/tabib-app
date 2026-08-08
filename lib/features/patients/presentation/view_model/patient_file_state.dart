import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/patients/domain/entities/patient_file_entity.dart';

class PatientFileState extends Equatable {
  final BaseState<PatientFileEntity> fileState;

  const PatientFileState({
    this.fileState = const BaseState(requestState: RequestState.init),
  });

  PatientFileState copyWith({
    BaseState<PatientFileEntity>? fileState,
  }) {
    return PatientFileState(
      fileState: fileState ?? this.fileState,
    );
  }

  @override
  List<Object?> get props => [fileState];
}
