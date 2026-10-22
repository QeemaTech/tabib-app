import 'package:flutter/material.dart';
import 'package:tabib_app/features/doctor_flow/home/presentation/views/doc/doc_content.dart';
import 'package:tabib_app/features/doctor_flow/home/presentation/widgets/app_bar_sliver_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        AppBarSliverSection(),
        SliverFillRemaining(child: DocContent()),
      ],
    );
  }
}
