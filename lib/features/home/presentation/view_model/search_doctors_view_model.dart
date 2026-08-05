import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/domain/entities/search_doctor_entity.dart';
import 'package:tabib_app/features/home/domain/repo/search_doctors_repo.dart';
import 'package:tabib_app/features/home/presentation/view_model/search_doctors_state.dart';

@injectable
class SearchDoctorsViewModel extends Cubit<SearchDoctorsState> {
  final SearchDoctorsRepo searchDoctorsRepo;
  Timer? _debounce;

  SearchDoctorsViewModel({required this.searchDoctorsRepo})
      : super(const SearchDoctorsState());

  void init({String? specialty}) {
    emit(state.copyWith(specialty: specialty));
    searchDoctors();
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), searchDoctors);
  }

  void updateSpecialty(String? specialty) {
    emit(
      state.copyWith(
        specialty: specialty,
        clearSpecialty: specialty == null || specialty.isEmpty,
      ),
    );
    searchDoctors();
  }

  Future<void> searchDoctors({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(searchState: BaseState.loading()));
    }

    final search = state.searchQuery.trim();
    final specialty = state.specialty?.trim();

    final result = await searchDoctorsRepo.searchDoctors(
      search: search.isEmpty ? null : search,
      specialty: (specialty == null || specialty.isEmpty) ? null : specialty,
    );

    switch (result) {
      case Success<SearchDoctorsResultEntity>():
        emit(state.copyWith(searchState: BaseState.loaded(result.data)));
      case Failure<SearchDoctorsResultEntity>():
        emit(
          state.copyWith(
            searchState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> retry() => searchDoctors();

  Future<void> refresh() => searchDoctors(showLoading: false);

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
