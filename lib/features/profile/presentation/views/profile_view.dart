import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/features/profile/presentation/view_model/doctor_profile_view_model.dart';
import 'package:tabib_app/features/profile/presentation/view_model/patient_profile_view_model.dart';
import 'package:tabib_app/features/profile/presentation/views/doc/doc_profile_content.dart';
import 'package:tabib_app/features/profile/presentation/views/user/user_profile_content.dart';

class ProfileView extends StatelessWidget {
  final String role;
  const ProfileView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final isDoctor = role == 'doctor' || role == 'doc';
    return SingleChildScrollView(
      child: isDoctor
          ? BlocProvider(
              create: (_) => getIt<DoctorProfileViewModel>()..loadProfile(),
              child: const DocProfileContent(),
            )
          : BlocProvider(
              create: (_) => getIt<PatientProfileViewModel>()..loadProfile(),
              child: const UserProfileContent(),
            ),
    );
  }
}
