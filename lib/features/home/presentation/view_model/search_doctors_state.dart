import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/home/domain/entities/search_doctor_entity.dart';

class SearchDoctorsState extends Equatable {
  final String searchQuery;
  final String? specialty;
  final BaseState<SearchDoctorsResultEntity> searchState;

  const SearchDoctorsState({
    this.searchQuery = '',
    this.specialty,
    this.searchState = const BaseState(requestState: RequestState.init),
  });

  SearchDoctorsState copyWith({
    String? searchQuery,
    String? specialty,
    bool clearSpecialty = false,
    BaseState<SearchDoctorsResultEntity>? searchState,
  }) {
    return SearchDoctorsState(
      searchQuery: searchQuery ?? this.searchQuery,
      specialty: clearSpecialty ? null : (specialty ?? this.specialty),
      searchState: searchState ?? this.searchState,
    );
  }

  @override
  List<Object?> get props => [searchQuery, specialty, searchState];
}
