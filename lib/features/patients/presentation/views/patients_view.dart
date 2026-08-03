import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/filter_chips.dart';
import '../../../../core/widgets/reservation_card.dart';
import '../../../home/presentation/widgets/search_bar_widget.dart';

enum Status { all, stable, listVisit, needReview }

class PatientsView extends StatefulWidget {
  const PatientsView({super.key});

  @override
  State<PatientsView> createState() => _PatientsViewState();
}

class _PatientsViewState extends State<PatientsView> {
  ValueNotifier<Status> status = ValueNotifier(Status.all);
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      children: [
        const SearchBarWidget(),
        const SizedBox(height: 26),
        FilterChips(
          filters: [
            "patients.filters.all".tr(),
            "patients.filters.lastVisit".tr(),
            "patients.filters.needReview".tr(),
            "patients.filters.stable".tr(),
          ],
          onSelected: (index) {
            switch (index) {
              case 0:
                status.value = Status.all;
                setState(() {});
              case 1:
                status.value = Status.listVisit;
                setState(() {});
              case 2:
                status.value = Status.needReview;
                setState(() {});
              case 3:
                status.value = Status.stable;
                setState(() {});
            }
          },
        ),
        const SizedBox(height: 16),
        Expanded(
          child: switch (status.value) {
            Status.all => ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ReservationCard(
                  status: "reservations.confirmedNow".tr(),
                  doctorName: "appointments.drName".tr(),
                  subTitle: "common.yearsOldMale".tr(args: ['25']),
                  time: "patients.lastVisitTime".tr(args: ['08:30']),
                  actions: [
                    ReservationActionButton(
                      label: "patients.viewProfile".tr(),
                      iconPath: AssetsManager.report,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.patientDetailsView);
                      },
                    ),
                  ],
                );
              },
            ),
            Status.listVisit => ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ReservationCard(
                  status: "patients.filters.lastVisit".tr(),
                  statusColor: theme.primaryColor500,
                  statusBackgroundColor: const Color(0xFFE9EBF1),
                  doctorName: "appointments.drName".tr(),
                  subTitle: "common.yearsOldMale".tr(args: ['25']),
                  time: "patients.lastVisitTime".tr(args: ['08:30']),
                  actions: [
                    ReservationActionButton(
                      label: "patients.viewProfile".tr(),
                      iconPath: AssetsManager.report,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.patientDetailsView);
                      },
                    ),
                  ],
                );
              },
            ),
            Status.needReview => ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ReservationCard(
                  status: "patients.filters.lastVisit".tr(),
                  statusColor: const Color(0xFFDCB263),
                  statusBackgroundColor: const Color(0xFFFEF9F0),
                  doctorName: "appointments.drName".tr(),
                  subTitle: "common.yearsOldMale".tr(args: ['25']),
                  time: "patients.lastVisitTime".tr(args: ['08:30']),
                  actions: [
                    ReservationActionButton(
                      label: "patients.viewProfile".tr(),
                      iconPath: AssetsManager.report,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.patientDetailsView);
                      },
                    ),
                  ],
                );
              },
            ),
            Status.stable => ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ReservationCard(
                  status: "patients.filters.stable".tr(),
                  statusColor: const Color(0xFFDCB263),
                  statusBackgroundColor: const Color(0xFFFEF9F0),
                  doctorName: "appointments.drName".tr(),
                  subTitle: "common.yearsOldMale".tr(args: ['25']),
                  time: "patients.lastVisitTime".tr(args: ['08:30']),
                  actions: [
                    ReservationActionButton(
                      label: "patients.viewProfile".tr(),
                      iconPath: AssetsManager.report,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.patientDetailsView);
                      },
                    ),
                  ],
                );
              },
            ),
          },
        ),
      ],
    );
  }
}
