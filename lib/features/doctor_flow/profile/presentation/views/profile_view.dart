import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/view_model/doctor_profile_view_model.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/views/doc/doc_profile_content.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider(
        create: (_) => getIt<DoctorProfileViewModel>()..loadProfile(),
        child: const DocProfileContent(),
      ),
    );
  }
}
