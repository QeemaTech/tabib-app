import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/auth/domain/repo/auth_repo.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_state.dart';

@injectable
class AuthViewModel extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthViewModel(this.authRepo) : super(const AuthState());

  void setPreferredLanguage(String value) {
    emit(state.copyWith(preferredLanguage: value));
  }

  void setCountryCode(String countryCode) {
    emit(state.copyWith(countryCode: countryCode));
  }

  Future<void> registerPatient(RegisterRequest request) async {
    emit(state.copyWith(registerModel: BaseState.loading()));
    final result = await authRepo.registerPatient(request);
    switch (result) {
      case Success<RegisterResponse>():
        emit(state.copyWith(registerModel: BaseState.loaded(result.data)));
      case Failure<RegisterResponse>():
        emit(
          state.copyWith(registerModel: BaseState.error(result.errorMessage)),
        );
    }
  }
}
