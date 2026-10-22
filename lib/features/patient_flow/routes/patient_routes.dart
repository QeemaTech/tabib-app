import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/utils/confirm_payment_args.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/views/appointment_details_view.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/views/confirm_payment_view.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/views/patient_invoices_view.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/views/payment_success_view.dart';
import 'package:tabib_app/features/patient_flow/auth/presentation/view/login_view.dart';
import 'package:tabib_app/features/patient_flow/auth/presentation/view/patient/complete_user_profile_view.dart';
import 'package:tabib_app/features/patient_flow/auth/presentation/view/sign_up_view.dart';
import 'package:tabib_app/features/patient_flow/auth/presentation/view_model/auth_constants.dart';
import 'package:tabib_app/features/patient_flow/auth/presentation/view_model/auth_view_model.dart';
import 'package:tabib_app/features/patient_flow/auth/presentation/view_model/patient/complete_patient_profile_view_model.dart';
import 'package:tabib_app/features/patient_flow/calls/presentation/utils/video_call_args.dart';
import 'package:tabib_app/features/patient_flow/calls/presentation/view_model/video_call_view_model.dart';
import 'package:tabib_app/features/patient_flow/calls/presentation/views/video_call_view.dart';
import 'package:tabib_app/features/patient_flow/chat/presentation/utils/chat_details_args.dart';
import 'package:tabib_app/features/patient_flow/chat/presentation/view_model/chat_details_view_model.dart';
import 'package:tabib_app/features/patient_flow/chat/presentation/view_model/chat_list_view_model.dart';
import 'package:tabib_app/features/patient_flow/chat/presentation/views/chat_details_view.dart';
import 'package:tabib_app/features/patient_flow/chat/presentation/views/chat_list_view.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/view_model/doctor_details_view_model.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/view_model/search_doctors_view_model.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/view_model/specialties_view_model.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/views/user/doctor_details_view.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/views/user/search_view.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/views/user/see_more_specialization.dart';
import 'package:tabib_app/features/patient_flow/notification/presentation/view_model/notifications_view_model.dart';
import 'package:tabib_app/features/patient_flow/notification/presentation/views/notification_view.dart';
import 'package:tabib_app/features/patient_flow/profile/presentation/views/user/patient_personal_info_view.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/views/prescription_details_view.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/views/report_details_view.dart';

class PatientRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginView:
        return _authRoute(settings, const LoginView());
      case AppRoutes.signUpView:
        return _authRoute(settings, const SignUpView());
      case AppRoutes.completeProfileView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<CompletePatientProfileViewModel>(),
            child: const CompleteUserProfileView(),
          ),
        );
      case AppRoutes.prescriptionDetailsView:
        final prescriptionId = settings.arguments as String? ?? '';
        if (prescriptionId.isEmpty) {
          return MaterialPageRoute(
            builder: (context) =>
                Scaffold(body: Center(child: Text('records.missingId'.tr()))),
          );
        }
        return MaterialPageRoute(
          builder: (context) =>
              PrescriptionDetailsView(prescriptionId: prescriptionId),
        );
      case AppRoutes.reportDetailsView:
        final reportId = settings.arguments as String? ?? '';
        if (reportId.isEmpty) {
          return MaterialPageRoute(
            builder: (context) =>
                Scaffold(body: Center(child: Text('records.missingId'.tr()))),
          );
        }
        return MaterialPageRoute(
          builder: (context) => ReportDetailsView(reportId: reportId),
        );
      case AppRoutes.seeMoreSpecializationView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<SpecialtiesViewModel>()..loadSpecialties(),
            child: const SeeMoreSpecializationView(),
          ),
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
      case AppRoutes.notificationView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) =>
                getIt<PatientNotificationsViewModel>()..loadNotifications(),
            child: const NotificationView(),
          ),
        );
      case AppRoutes.chatListView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) =>
                getIt<PatientChatListViewModel>()..loadConsultations(),
            child: const ChatListView(),
          ),
        );
      case AppRoutes.chatDetailsView:
        final args = ChatDetailsArgs.fromRouteArguments(settings.arguments);
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (_) => getIt<PatientChatDetailsViewModel>()
              ..init(
                consultationId: args.consultationId,
                participantTitle: args.title,
                avatarUrl: args.avatarUrl,
              ),
            child: const ChatDetailsView(),
          ),
        );
      case AppRoutes.patientPersonalInfoView:
        return MaterialPageRoute(
          builder: (context) => const PatientPersonalInfoView(),
        );
      case AppRoutes.confirmPaymentView:
        final args = settings.arguments;
        if (args is! ConfirmPaymentArgs) {
          return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(child: Text('Missing payment arguments')),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => ConfirmPaymentView(args: args),
        );
      case AppRoutes.paymentSuccessView:
        final invoiceId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (context) => PaymentSuccessView(invoiceId: invoiceId),
        );
      case AppRoutes.patientInvoicesView:
        return MaterialPageRoute(
          builder: (context) => const PatientInvoicesView(),
        );
      case AppRoutes.appointmentDetailsView:
        final appointmentId = settings.arguments as String? ?? '';
        if (appointmentId.isEmpty) {
          return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(child: Text('Missing appointment id')),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) =>
              AppointmentDetailsView(appointmentId: appointmentId),
        );
      case AppRoutes.videoCallView:
        final args = VideoCallArgs.fromRouteArguments(settings.arguments);
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (_) => getIt<PatientVideoCallViewModel>()
              ..startCall(
                appointmentId: args.appointmentId,
                callType: args.callType,
                peerName: args.peerName,
              ),
            child: const VideoCallView(),
          ),
        );
      default:
        return null;
    }
  }

  static MaterialPageRoute<dynamic> _authRoute(
    RouteSettings settings,
    Widget child,
  ) {
    final mode = settings.arguments is Map
        ? ((settings.arguments as Map)['mode'] as String? ?? AuthMode.login)
        : AuthMode.login;
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => BlocProvider(
        create: (_) => getIt<PatientAuthViewModel>()
          ..setRole('user')
          ..setAuthMode(mode),
        child: child,
      ),
    );
  }
}
