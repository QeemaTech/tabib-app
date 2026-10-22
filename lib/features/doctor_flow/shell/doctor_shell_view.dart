import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/doctor_flow/home/presentation/views/home_view.dart';
import 'package:tabib_app/features/doctor_flow/patients/presentation/views/patients_view.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/views/profile_view.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/views/reservations_view.dart';
import 'package:tabib_app/features/doctor_flow/shell/doctor_layout_view_model.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/views/doc/doct_wallet.dart';

class DoctorShellView extends StatelessWidget {
  const DoctorShellView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final currentIndex = context.watch<DoctorLayoutViewModel>().state;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IndexedStack(
            index: currentIndex,
            children: const [
              HomeView(),
              ReservationsView(),
              PatientsView(),
              DocWalletView(),
              ProfileView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) =>
            context.read<DoctorLayoutViewModel>().changeIndex(index),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: AssetsManager.home,
              color: theme.textColor300,
            ),
            activeIcon: CustomImageView(
              imagePath: AssetsManager.homeActive,
              color: theme.primaryColor,
            ),
            label: 'layout.navBar.home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: AssetsManager.appointments,
              color: theme.textColor300,
            ),
            activeIcon: CustomImageView(
              imagePath: AssetsManager.appointmentsActive,
              color: theme.primaryColor,
            ),
            label: 'layout.navBar.reservations'.tr(),
          ),
          BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: AssetsManager.patients,
              color: theme.textColor300,
            ),
            activeIcon: CustomImageView(
              imagePath: AssetsManager.patientsActive,
              color: theme.primaryColor,
            ),
            label: 'layout.navBar.patients'.tr(),
          ),
          BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: AssetsManager.walletActive,
              color: theme.textColor300,
            ),
            activeIcon: CustomImageView(
              imagePath: AssetsManager.walletInactive,
              color: theme.primaryColor,
            ),
            label: 'layout.navBar.wallet'.tr(),
          ),
          BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: AssetsManager.profile,
              color: theme.textColor300,
            ),
            activeIcon: CustomImageView(
              imagePath: AssetsManager.profileActive,
              color: theme.primaryColor,
            ),
            label: 'layout.navBar.profile'.tr(),
          ),
        ],
      ),
    );
  }
}
