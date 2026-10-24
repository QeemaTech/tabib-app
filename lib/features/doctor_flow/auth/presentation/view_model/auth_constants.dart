class AuthRole {
  AuthRole._();

  static const String patient = 'PATIENT';
  static const String doctor = 'DOCTOR';

  static String fromUi(String uiRole) =>
      uiRole == 'doctor' || uiRole == 'doc' ? doctor : patient;

  static String toUi(String apiRole) {
    final normalized = apiRole.trim().toUpperCase();
    if (normalized == doctor || normalized == 'DOC') {
      return 'doctor';
    }
    return 'user';
  }
}

class AuthMode {
  AuthMode._();

  static const String login = 'login';
  static const String signup = 'signup';
}

enum OtpPurpose { accountVerification, passwordReset }

class AuthErrorCode {
  AuthErrorCode._();

  static const String unverified = 'AUTH_014';
}
