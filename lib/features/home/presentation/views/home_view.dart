import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/features/home/presentation/view_model/patient_home_view_model.dart';
import 'package:tabib_app/features/home/presentation/views/user/user_content.dart';
import 'package:tabib_app/features/home/presentation/widgets/app_bar_sliver_section.dart';
import 'doc/doc_content.dart';

class HomeView extends StatelessWidget {
  final String role;
  const HomeView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final isUser = role == 'user';

    return CustomScrollView(
      slivers: [
        const AppBarSliverSection(),
        SliverFillRemaining(
          child: isUser
              ? BlocProvider(
                  create: (_) => getIt<PatientHomeViewModel>()..loadHome(),
                  child: const UserContent(),
                )
              : const DocContent(),
        ),
      ],
    );
  }
}
