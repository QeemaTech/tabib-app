import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/views/appointments_view.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/views/home_view.dart';
import 'package:tabib_app/features/patient_flow/profile/presentation/views/profile_view.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/views/records_view.dart';
import 'package:tabib_app/features/patient_flow/shell/patient_layout_view_model.dart';
import 'package:tabib_app/features/patient_flow/wallet/presentation/views/patient/patient_wallet.dart';

class PatientShellView extends StatelessWidget {
  const PatientShellView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final currentIndex = context.watch<PatientLayoutViewModel>().state;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IndexedStack(
            index: currentIndex,
            children: const [
              HomeView(),
              AppointmentsView(),
              RecordsView(),
              PatientWalletView(),
              ProfileView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) =>
            context.read<PatientLayoutViewModel>().changeIndex(index),
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
            label: 'layout.navBar.appointments'.tr(),
          ),
          BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: AssetsManager.records,
              color: theme.textColor300,
            ),
            activeIcon: CustomImageView(
              imagePath: AssetsManager.recordsActive,
              color: theme.primaryColor,
            ),
            label: 'layout.navBar.records'.tr(),
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
