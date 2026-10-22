import 'package:flutter/material.dart';
import 'package:tabib_app/core/cache_helper/cached_user_role.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/doctor_flow/routes/doctor_routes.dart';
import 'package:tabib_app/features/doctor_flow/shell/doctor_shell.dart';
import 'package:tabib_app/features/entry/presentation/view/role_view.dart';
import 'package:tabib_app/features/entry/presentation/view/welcome_view.dart';
import 'package:tabib_app/features/patient_flow/routes/patient_routes.dart';
import 'package:tabib_app/features/patient_flow/shell/patient_shell.dart';

class Routes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcomeView:
        return MaterialPageRoute(builder: (context) => const WelcomeView());
      case AppRoutes.roleView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const RoleView(),
        );
      case AppRoutes.mainLayoutView:
        final role = _roleFrom(settings);
        if (_isDoctorRole(role)) {
          return MaterialPageRoute(
            builder: (context) => const DoctorShell(),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const PatientShell(),
        );
      default:
        if (_isDoctorRole(_roleFrom(settings))) {
          return DoctorRoutes.onGenerateRoute(settings);
        }
        return PatientRoutes.onGenerateRoute(settings);
    }
  }

  static String _roleFrom(RouteSettings settings) {
    final args = settings.arguments;
    if (args is String && args.isNotEmpty) return args;
    if (args is Map) {
      final role = args['role'] as String?;
      if (role != null && role.isNotEmpty) return role;
    }
    return CachedUserRole.uiRole;
  }

  static bool _isDoctorRole(String role) => role == 'doctor' || role == 'doc';
}
