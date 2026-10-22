import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/features/patient_flow/shell/patient_layout_view_model.dart';
import 'package:tabib_app/features/patient_flow/shell/patient_shell_view.dart';

class PatientShell extends StatelessWidget {
  const PatientShell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PatientLayoutViewModel>(),
      child: const PatientShellView(),
    );
  }
}
