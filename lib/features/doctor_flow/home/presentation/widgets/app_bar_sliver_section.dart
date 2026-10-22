import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/doctor_flow/home/presentation/widgets/custom_app_bar_profile.dart';
import 'package:tabib_app/features/doctor_flow/shell/doctor_layout_view_model.dart';

class AppBarSliverSection extends StatelessWidget {
  const AppBarSliverSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      pinned: true,
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      flexibleSpace: CustomAppBarProfile(
        title: 'home.appBar.title',
        subTitle: "home.appBar.subtitle",
        onMessageClicked: () {
          Navigator.pushNamed(context, AppRoutes.chatListView);
        },
        onNotificationClicked: () {
          Navigator.pushNamed(context, AppRoutes.notificationView);
        },
        onProfileImageClicked: () {
          context.read<DoctorLayoutViewModel>().changeIndex(3);
        },
      ),
    );
  }
}
