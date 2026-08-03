import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/home/presentation/view_model/patient_home_state.dart';
import 'package:tabib_app/features/home/presentation/view_model/patient_home_view_model.dart';
import 'package:tabib_app/features/home/presentation/widgets/ads_list.dart';
import 'package:tabib_app/features/home/presentation/widgets/featured_doctors_list.dart';
import 'package:tabib_app/features/home/presentation/widgets/header_special.dart';
import 'package:tabib_app/features/home/presentation/widgets/list_of_special_doc.dart';
import 'package:tabib_app/features/home/presentation/widgets/meeting_section.dart';
import 'package:tabib_app/features/home/presentation/widgets/search_bar_widget.dart';

class UserContent extends StatelessWidget {
  const UserContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return BlocBuilder<PatientHomeViewModel, PatientHomeState>(
      buildWhen: (previous, current) =>
          previous.homeState != current.homeState,
      builder: (context, state) {
        final homeState = state.homeState;

        if (homeState.isLoading || homeState.isInitial) {
          return Center(
            child: CircularProgressIndicator(color: theme.primaryColor),
          );
        }

        if (homeState.isError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  homeState.errorMessage ?? '',
                  textAlign: TextAlign.center,
                  style: theme.regular14.copyWith(color: theme.textColor300),
                ),
                const SizedBox(height: 12),
                IconButton(
                  onPressed: () =>
                      context.read<PatientHomeViewModel>().loadHome(),
                  icon: Icon(Icons.refresh, color: theme.primaryColor),
                ),
              ],
            ),
          );
        }

        final home = homeState.data;
        if (home == null) {
          return const SizedBox.shrink();
        }

        return SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              SearchBarWidget(
                readOnly: true,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.searchView);
                },
              ),
              const MeetingSection(),
              AutoMovingAdsCarousel(banners: home.banners),
              HeaderSpecial(
                title: 'home.user.fastSpecializations',
                onSeeMoreClicked: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.seeMoreSpecializationView,
                  );
                },
              ),
              ListOfSpecialDoc(specialties: home.specialties),
              const HeaderSpecial(
                title: 'home.user.featuredDoctors',
              ),
              FeaturedDoctorsList(doctors: home.featuredDoctors),
              const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
