import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/features/doctor_flow/home/presentation/view_model/doctor_dashboard_view_model.dart';
import 'package:tabib_app/features/doctor_flow/shell/doctor_layout_view_model.dart';
import 'package:tabib_app/features/doctor_flow/shell/doctor_shell_view.dart';

class DoctorShell extends StatelessWidget {
  const DoctorShell({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<DoctorLayoutViewModel>()),
        BlocProvider(
          create: (_) => getIt<DoctorDashboardViewModel>()..loadDashboard(),
        ),
      ],
      child: const DoctorShellView(),
    );
  }
}
