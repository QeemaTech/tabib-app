import 'package:easy_localization/easy_localization.dart';

class AppValidator {
  AppValidator._();
  /// ================= Patterns =================

  static final _emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static final _phoneRegex = RegExp(r'^(?:[+0]9)?[0-9]{10,12}$');

  /// ================= Email =================

  static String? email(String? value) {
    final v = value?.trim();

    if (v == null || v.isEmpty) {
      return 'validation.email.required'.tr();
    }

    if (!_emailRegex.hasMatch(v)) {
      return 'validation.email.invalid'.tr();
    }

    return null;
  }

  /// ================= Password =================

  static String? password(String? value) {
    final v = value?.trim();
    if (v == null || v.isEmpty) {
      return 'validation.password.required'.tr();
    }
    if (v.length < 8) {
      return 'validation.password.minLength'.tr();
    }
    return null;
  }

  /// ================= Confirm Password =================

  static String? confirmPassword(String? value, String password) {
    final v = value?.trim();
    if (v == null || v.isEmpty) {
      return 'validation.confirmPassword.required'.tr();
    }
    if (v != password) {
      return 'validation.confirmPassword.mismatch'.tr();
    }
    return null;
  }

  /// ================= Phone =================

  static String? phone(String? value) {
    final v = value?.replaceAll(RegExp(r'\s+'), '');

    if (v == null || v.isEmpty) {
      return 'validation.phone.required'.tr();
    }

    if (!_phoneRegex.hasMatch(v)) {
      return 'validation.phone.invalid'.tr();
    }

    return null;
  }

  /// ================= Name =================

  static String? name(String? value) {
    final v = value?.trim();
    if (v == null || v.isEmpty) {
      return 'validation.name.required'.tr();
    }
    if (v.length < 3) {
      return 'validation.name.minLength'.tr();
    }
    return null;
  }

  /// ================= Note =================

  static String? note(String? value) {
    final v = value?.trim();

    if (v != null && v.length > 500) {
      return 'validation.note.maxLength'.tr();
    }

    return null;
  }

  /// ================= OTP =================

  static String? otp(String? value) {
    final v = value?.trim();

    if (v == null || v.isEmpty) {
      return 'validation.otp.required'.tr();
    }

    if (v.length < 5) {
      return 'validation.otp.minLength'.tr();
    }

    return null;
  }

  /// ================= City =================

  static String? city(String? value) {
   if (value == null || value.trim().isEmpty) {
      return 'validation.city.required'.tr();
    }
    return null;
  }
  static String? shouldEnter(String? value) {
   if (value == null || value.trim().isEmpty){
      return 'validation.required'.tr();
    }
    return null;
  }
}
