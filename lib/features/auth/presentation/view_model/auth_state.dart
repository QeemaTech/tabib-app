import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/auth/data/models/response/register_response.dart';

class AuthState extends Equatable {
  final BaseState<RegisterResponse> registerModel;
  final String preferredLanguage;
  final String? countryCode;

  const AuthState({
    this.registerModel = const BaseState(requestState: RequestState.init),
    this.preferredLanguage = 'ar',
    this.countryCode,
  });

  AuthState copyWith({
    BaseState<RegisterResponse>? registerModel,
    String? preferredLanguage,
    String? countryCode,
  }) {
    return AuthState(
      registerModel: registerModel ?? this.registerModel,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  List<Object?> get props => [registerModel, preferredLanguage, countryCode];
}
