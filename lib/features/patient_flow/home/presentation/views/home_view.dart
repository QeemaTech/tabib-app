import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/view_model/patient_home_view_model.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/views/user/user_content.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/widgets/app_bar_sliver_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const AppBarSliverSection(),
        SliverFillRemaining(
          child: BlocProvider(
            create: (_) => getIt<PatientHomeViewModel>()..loadHome(),
            child: const UserContent(),
          ),
        ),
      ],
    );
  }
}
