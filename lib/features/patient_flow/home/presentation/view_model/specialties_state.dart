import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/specialty_entity.dart';

class SpecialtiesState extends Equatable {
  final BaseState<List<SpecialtyEntity>> specialtiesState;
  final String query;

  const SpecialtiesState({
    this.specialtiesState = const BaseState(requestState: RequestState.init),
    this.query = '',
  });

  List<SpecialtyEntity> filteredSpecialties(String languageCode) {
    final items = specialtiesState.data ?? const [];
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return items;
    return items
        .where(
          (item) =>
              item.localizedName(languageCode).toLowerCase().contains(trimmed),
        )
        .toList();
  }

  SpecialtiesState copyWith({
    BaseState<List<SpecialtyEntity>>? specialtiesState,
    String? query,
  }) {
    return SpecialtiesState(
      specialtiesState: specialtiesState ?? this.specialtiesState,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [specialtiesState, query];
}
