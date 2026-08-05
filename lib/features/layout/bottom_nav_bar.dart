import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/appointments/presentation/views/appointments_view.dart';
import 'package:tabib_app/features/home/presentation/views/home_view.dart';
import 'package:tabib_app/features/layout/view_model/layout_view_model.dart';
import 'package:tabib_app/features/patients/presentation/views/patients_view.dart';
import 'package:tabib_app/features/profile/presentation/views/profile_view.dart';
import 'package:tabib_app/features/records/presentation/views/records_view.dart';
import 'package:tabib_app/features/reservations/presentation/views/reservations_view.dart';
import 'package:tabib_app/features/wallet/presentation/views/doc/doct_wallet.dart';
import 'package:tabib_app/features/wallet/presentation/views/patient/patient_wallet.dart';

class MainLayout extends StatefulWidget {
  final String role;

  const MainLayout({super.key, required this.role});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    final bool isDoctor = widget.role == 'doctor' || widget.role == 'doc';
    final theme = context.appTheme;
    final currentIndex = context.watch<LayoutViewModel>().state;

    final List<Widget> views = isDoctor
        ? [
            HomeView(role: widget.role),
            const ReservationsView(),
            const PatientsView(),
            const DocWalletView(),
            ProfileView(role: widget.role),
          ]
        : [
            HomeView(role: widget.role),
            const AppointmentsView(),
            const RecordsView(),
            const PatientWalletView(),
            ProfileView(role: widget.role),
          ];

    final List<BottomNavigationBarItem> items = isDoctor
        ? [
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
                imagePath: AssetsManager.moneys,
                color: theme.textColor300,
              ),
              activeIcon: CustomImageView(
                imagePath: AssetsManager.moneys,
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
          ]
        : [
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
          ];

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IndexedStack(index: currentIndex, children: views),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => context.read<LayoutViewModel>().changeIndex(index),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: items,
      ),
    );
  }
}
