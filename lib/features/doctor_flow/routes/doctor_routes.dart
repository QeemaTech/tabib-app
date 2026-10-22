import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view/doc/complete_doc_profile_view.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view/login_view.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view/sign_up_view.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_constants.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_view_model.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/doc/complete_doc_profile_cubit.dart';
import 'package:tabib_app/features/doctor_flow/calls/presentation/utils/video_call_args.dart';
import 'package:tabib_app/features/doctor_flow/calls/presentation/view_model/video_call_view_model.dart';
import 'package:tabib_app/features/doctor_flow/calls/presentation/views/video_call_view.dart';
import 'package:tabib_app/features/doctor_flow/chat/presentation/utils/chat_details_args.dart';
import 'package:tabib_app/features/doctor_flow/chat/presentation/view_model/chat_details_view_model.dart';
import 'package:tabib_app/features/doctor_flow/chat/presentation/view_model/chat_list_view_model.dart';
import 'package:tabib_app/features/doctor_flow/chat/presentation/views/chat_details_view.dart';
import 'package:tabib_app/features/doctor_flow/chat/presentation/views/chat_list_view.dart';
import 'package:tabib_app/features/doctor_flow/notification/presentation/view_model/notifications_view_model.dart';
import 'package:tabib_app/features/doctor_flow/notification/presentation/views/notification_view.dart';
import 'package:tabib_app/features/doctor_flow/patients/presentation/view_model/patient_file_view_model.dart';
import 'package:tabib_app/features/doctor_flow/patients/presentation/views/patient_appointment_details_view.dart';
import 'package:tabib_app/features/doctor_flow/patients/presentation/views/patient_details_view.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/views/doc/doctor_personal_info_view.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/view_model/create_report_view_model.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/view_model/doctor_appointment_details_view_model.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/views/create_report_view.dart';
import 'package:tabib_app/features/doctor_flow/schedule/presentation/view_model/doctor_schedule_view_model.dart';
import 'package:tabib_app/features/doctor_flow/schedule/presentation/views/doctor_schedule_view.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/utils/doctor_withdraw_args.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/views/doc/doctor_withdraw_view.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/views/doc/doctor_withdrawal_details_view.dart';

class DoctorRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginView:
        return _authRoute(settings, const LoginView());
      case AppRoutes.signUpView:
        return _authRoute(settings, const SignUpView());
      case AppRoutes.completeProfileView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<CompleteDocProfileCubit>(),
            child: const CompleteDocProfileView(),
          ),
        );
      case AppRoutes.notificationView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) =>
                getIt<DoctorNotificationsViewModel>()..loadNotifications(),
            child: const NotificationView(),
          ),
        );
      case AppRoutes.chatListView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<DoctorChatListViewModel>()..loadConsultations(),
            child: const ChatListView(),
          ),
        );
      case AppRoutes.chatDetailsView:
        final args = ChatDetailsArgs.fromRouteArguments(settings.arguments);
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (_) => getIt<DoctorChatDetailsViewModel>()
              ..init(
                consultationId: args.consultationId,
                participantTitle: args.title,
                avatarUrl: args.avatarUrl,
              ),
            child: const ChatDetailsView(),
          ),
        );
      case AppRoutes.patientDetailsView:
        final appointmentId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (_) => getIt<PatientFileViewModel>()..load(appointmentId),
            child: const PatientDetailsView(),
          ),
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
      case AppRoutes.doctorScheduleView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<DoctorScheduleViewModel>()..loadSchedule(),
            child: const DoctorScheduleView(),
          ),
        );
      case AppRoutes.videoCallView:
        final args = VideoCallArgs.fromRouteArguments(settings.arguments);
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (_) => getIt<DoctorVideoCallViewModel>()
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
        create: (_) => getIt<DoctorAuthViewModel>()
          ..setRole('doctor')
          ..setAuthMode(mode),
        child: child,
      ),
    );
  }
}
