import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/cache_helper/cached_user_role.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/auth/presentation/view/doc/complete_doc_profile_view.dart';
import 'package:tabib_app/features/auth/presentation/view/login_view.dart';
import 'package:tabib_app/features/auth/presentation/view/role_view.dart';
import 'package:tabib_app/features/auth/presentation/view/sign_up_view.dart';
import 'package:tabib_app/features/auth/presentation/view/welcome_view.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_constants.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:tabib_app/features/auth/presentation/view_model/doc/complete_doc_profile_cubit.dart';
import 'package:tabib_app/features/auth/presentation/view_model/patient/complete_patient_profile_view_model.dart';
import 'package:tabib_app/features/chat/presentation/views/chat_details_view.dart';
import 'package:tabib_app/features/chat/presentation/views/chat_list_view.dart';
import 'package:tabib_app/features/home/presentation/views/user/search_view.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_details_view_model.dart';
import 'package:tabib_app/features/home/presentation/view_model/search_doctors_view_model.dart';
import 'package:tabib_app/features/patients/presentation/views/patient_details_view.dart';
import 'package:tabib_app/features/reservations/presentation/views/create_report_view.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/create_report_view_model.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/doctor_appointment_details_view_model.dart';
import '../../features/auth/presentation/view/patient/complete_user_profile_view.dart';
import '../../features/home/presentation/views/user/doctor_details_view.dart';
import '../../features/home/presentation/views/user/see_more_specialization.dart';
import '../../features/layout/bottom_nav_bar.dart';
import '../../features/layout/view_model/layout_view_model.dart';
import '../../features/notification/presentation/views/notification_view.dart';
import '../../features/patients/presentation/views/patient_appointment_details_view.dart';
import '../../features/profile/presentation/views/doc/doctor_personal_info_view.dart';
import '../../features/profile/presentation/views/user/patient_personal_info_view.dart';
import '../../features/records/presentation/views/prescription_details_view.dart';
import 'package:tabib_app/features/wallet/presentation/utils/doctor_withdraw_args.dart';
import 'package:tabib_app/features/wallet/presentation/views/doc/doctor_withdraw_view.dart';
import 'package:tabib_app/features/wallet/presentation/views/doc/doctor_withdrawal_details_view.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcomeView:
        return MaterialPageRoute(builder: (context) => const WelcomeView());
      case AppRoutes.roleView:
        final args = settings.arguments;
        final mode = args is Map
            ? (args['mode'] as String? ?? AuthMode.login)
            : AuthMode.login;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt<AuthViewModel>()..setAuthMode(mode),
            child: const RoleView(),
          ),
        );
      case AppRoutes.loginView:
        return MaterialPageRoute(
          builder: (context) => _authScoped(
            settings.arguments,
            const LoginView(),
          ),
        );
      case AppRoutes.signUpView:
        return MaterialPageRoute(
          builder: (context) => _authScoped(
            settings.arguments,
            const SignUpView(),
          ),
        );
      case AppRoutes.mainLayoutView:
        final argsRole = settings.arguments is String
            ? settings.arguments as String
            : null;
        final role = (argsRole != null && argsRole.isNotEmpty)
            ? argsRole
            : CachedUserRole.uiRole;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LayoutViewModel>(),
            child: MainLayout(role: role),
          ),
        );
      case AppRoutes.prescriptionDetailsView:
        return MaterialPageRoute(
          builder: (context) => const PrescriptionDetailsView(),
        );
      case AppRoutes.seeMoreSpecializationView:
        return MaterialPageRoute(
          builder: (context) => const SeeMoreSpecializationView(),
        );
      case AppRoutes.searchView:
        final args = settings.arguments;
        final specialty = args is String
            ? args
            : (args is Map ? args['specialty'] as String? : null);
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) =>
                getIt<SearchDoctorsViewModel>()..init(specialty: specialty),
            child: const SearchView(),
          ),
        );
      case AppRoutes.notificationView:
        return MaterialPageRoute(
          builder: (context) => const NotificationView(),
        );
      case AppRoutes.doctorDetailsView:
        final doctorId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (_) =>
                getIt<DoctorDetailsViewModel>()..loadDoctorDetails(doctorId),
            child: const DoctorDetailsView(),
          ),
        );
      case AppRoutes.chatListView:
        return MaterialPageRoute(builder: (context) => const ChatListView());
      case AppRoutes.chatDetailsView:
        return MaterialPageRoute(builder: (context) => const ChatDetailsView());
      case AppRoutes.patientDetailsView:
        return MaterialPageRoute(
          builder: (context) => const PatientDetailsView(),
        );
      case AppRoutes.patientsAppointmentDetailsView:
        final appointmentId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (_) => getIt<DoctorAppointmentDetailsViewModel>()
              ..loadDetails(appointmentId),
            child: const PatientsAppointmentDetailsView(),
          ),
        );
      case AppRoutes.createReportView:
        final appointmentId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (_) =>
                getIt<CreateReportViewModel>()..loadDetails(appointmentId),
            child: const CreateReportView(),
          ),
        );
      case AppRoutes.patientPersonalInfoView:
        return MaterialPageRoute(
          builder: (context) => const PatientPersonalInfoView(),
        );
      case AppRoutes.doctorPersonalInfoView:
        return MaterialPageRoute(
          builder: (context) => const DoctorPersonalInfoView(),
        );
      case AppRoutes.doctorWithdrawView:
        final args = settings.arguments;
        if (args is! DoctorWithdrawArgs) {
          return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(child: Text('Missing withdraw arguments')),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => DoctorWithdrawView(args: args),
        );
      case AppRoutes.doctorWithdrawalDetailsView:
        final id = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (context) => DoctorWithdrawalDetailsView(withdrawalId: id),
        );
      case AppRoutes.completeProfileView:
        final role = settings.arguments as String? ?? 'user';
        final isDoctor = role == 'doctor' || role == 'doc';
        if (isDoctor) {
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => getIt<CompleteDocProfileCubit>(),
              child: const CompleteDocProfileView(),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<CompletePatientProfileViewModel>(),
            child: const CompleteUserProfileView(),
          ),
        );

      default:
        return null;
    }
  }

  static Widget _authScoped(Object? arguments, Widget child) {
    if (arguments is AuthViewModel) {
      return BlocProvider.value(value: arguments, child: child);
    }
    return BlocProvider(
      create: (context) => getIt<AuthViewModel>(),
      child: child,
    );
  }
}
