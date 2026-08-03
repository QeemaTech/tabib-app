import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/calendar_section.dart';
import '../../../../core/widgets/filter_chips.dart';
import '../../../home/presentation/widgets/request_review_doc.dart';
import '../../../../core/widgets/reservation_card.dart';

enum Status { all, confirm, holding, completed, cancel }

class ReservationsView extends StatefulWidget {
  const ReservationsView({super.key});

  @override
  State<ReservationsView> createState() => _ReservationsViewState();
}

class _ReservationsViewState extends State<ReservationsView> {
  ValueNotifier<Status> status = ValueNotifier(Status.all);
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      children: [
        const SizedBox(height: 26),
        FilterChips(
          filters: [
            "appointments.filters.all".tr(),
            "appointments.filters.confirm".tr(),
            "appointments.filters.holding".tr(),
            "appointments.filters.completed".tr(),
            "appointments.filters.cancel".tr(),
          ],
          onSelected: (index) {
            switch (index) {
              case 0:
                status.value = Status.all;
                setState(() {});
              case 1:
                status.value = Status.confirm;
                setState(() {});
              case 2:
                status.value = Status.holding;
                setState(() {});
              case 3:
                status.value = Status.completed;
                setState(() {});
              case 4:
                status.value = Status.cancel;
                setState(() {});
            }
          },
        ),
        if (status.value == Status.all) ...[
          const CalendarSection(),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              backgroundColor: const Color(0xFFE9EBF1),
              side: BorderSide.none,
              textStyle: theme.bold18.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            label: Text("appointments.addAppointment".tr()),
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
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
                  subTitle: "reservations.cardiologyConsultation".tr(),
                  time: "08:30 م",
                  actions: [
                    ReservationActionButton(
                      label: "reservations.startSession".tr(),
                      iconPath: AssetsManager.video,
                      isFilled: true,
                      onTap: () {},
                    ),
                    ReservationActionButton(
                      label: "reservations.bookingDetails".tr(),
                      iconPath: AssetsManager.records,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.patientsAppointmentDetailsView,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            Status.confirm => ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ReservationCard(
                  status: "reservations.confirmedNow".tr(),
                  doctorName: "appointments.drName".tr(),
                  subTitle: "reservations.cardiologyConsultation".tr(),
                  time: "08:30 م",
                  actions: [
                    ReservationActionButton(
                      label: "reservations.bookingDetails".tr(),
                      iconPath: AssetsManager.report,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.patientsAppointmentDetailsView,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            Status.holding => ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const RequestReviewDocCard();
              },
            ),
            Status.completed => ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ReservationCard(
                  showTime: false,
                  status: "reservations.confirmedNow".tr(),
                  doctorName: "appointments.drName".tr(),
                  subTitle: "reservations.cardiologyConsultation".tr(),
                  time: "08:30 م",
                  actions: [
                    ReservationActionButton(
                      label: "reservations.createReportBtn".tr(),
                      iconPath: AssetsManager.report,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.createReportView);
                      },
                    ),
                  ],
                );
              },
            ),
            Status.cancel => ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ReservationCard(
                  showTime: false,
                  statusBackgroundColor: const Color(0xFFF7E4E3),
                  statusColor: const Color(0xFFFF3B30),
                  status: "reservations.cancelBtn".tr(),
                  doctorName: "appointments.drName".tr(),
                  subTitle: "reservations.cardiologyConsultation".tr(),
                );
              },
            ),
          },
        ),
      ],
    );
  }
}
