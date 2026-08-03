class AuthRole {
  AuthRole._();

  static const String patient = 'PATIENT';
  static const String doctor = 'DOCTOR';

  static String fromUi(String uiRole) =>
      uiRole == 'doctor' ? doctor : patient;

  static String toUi(String apiRole) =>
      apiRole == doctor ? 'doctor' : 'user';
}

class AuthMode {
  AuthMode._();

  static const String login = 'login';
  static const String signup = 'signup';
}
