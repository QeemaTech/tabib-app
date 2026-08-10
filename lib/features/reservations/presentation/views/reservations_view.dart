import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/core/widgets/calendar_section.dart';
import 'package:tabib_app/core/widgets/filter_chips.dart';
import 'package:tabib_app/features/chat/presentation/view_model/start_consultation_state.dart';
import 'package:tabib_app/features/chat/presentation/view_model/start_consultation_view_model.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/doctor_appointments_state.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/doctor_appointments_view_model.dart';
import 'package:tabib_app/features/reservations/presentation/widgets/reservations_list_area.dart';

class ReservationsView extends StatelessWidget {
  const ReservationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<DoctorAppointmentsViewModel>()..loadAppointments(),
        ),
        BlocProvider(create: (_) => getIt<StartConsultationViewModel>()),
      ],
      child: const _ReservationsViewBody(),
    );
  }
}

class _ReservationsViewBody extends StatelessWidget {
  const _ReservationsViewBody();

  static const _filters = DoctorAppointmentsFilter.values;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return MultiBlocListener(
      listeners: [
        BlocListener<DoctorAppointmentsViewModel, DoctorAppointmentsState>(
          listenWhen: (previous, current) =>
              previous.actionState != current.actionState,
          listener: (context, state) {
            final action = state.actionState;
            if (action.isLoaded) {
              final message = action.data == DoctorAppointmentActionType.reject
                  ? 'reservations.rejectSuccess'.tr()
                  : 'reservations.acceptSuccess'.tr();
              CustomToast.show(
                context,
                message: message,
                status: ToastStatus.success,
              );
              context.read<DoctorAppointmentsViewModel>().resetActionState();
            } else if (action.isError) {
              CustomToast.show(
                context,
                message: action.errorMessage ?? 'errors.unknown'.tr(),
                status: ToastStatus.error,
              );
              context.read<DoctorAppointmentsViewModel>().resetActionState();
            }
          },
        ),
        BlocListener<StartConsultationViewModel, StartConsultationState>(
          listenWhen: (previous, current) =>
              previous.startState != current.startState,
          listener: (context, state) {
            final startState = state.startState;
            if (startState.isLoaded) {
              final consultation = startState.data;
              context.read<StartConsultationViewModel>().reset();
              if (consultation != null && consultation.id.isNotEmpty) {
                Navigator.of(context).pushNamed(
                  AppRoutes.chatDetailsView,
                  arguments: consultation.id,
                );
              }
            } else if (startState.isError) {
              CustomToast.error(
                context,
                startState.errorMessage ?? 'errors.unknown'.tr(),
              );
              context.read<StartConsultationViewModel>().reset();
            }
          },
        ),
      ],
      child: BlocBuilder<DoctorAppointmentsViewModel, DoctorAppointmentsState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 26),
              FilterChips(
                filters: [
                  'appointments.filters.all'.tr(),
                  'appointments.filters.confirm'.tr(),
                  'appointments.filters.holding'.tr(),
                  'appointments.filters.completed'.tr(),
                  'appointments.filters.cancel'.tr(),
                ],
                onSelected: (index) {
                  context
                      .read<DoctorAppointmentsViewModel>()
                      .onFilterChanged(_filters[index]);
                },
              ),
              if (state.filter == DoctorAppointmentsFilter.all) ...[
                CalendarSection(
                  selectedDay: state.selectedDate,
                  onDaySelected: (day) {
                    context
                        .read<DoctorAppointmentsViewModel>()
                        .onDaySelected(day);
                  },
                ),
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
                  onPressed: () =>
                      context.pushName(AppRoutes.doctorScheduleView),
                  label: Text('schedule.workingHours'.tr()),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
              const SizedBox(height: 16),
              Expanded(
                child: ReservationsListArea(state: state),
              ),
            ],
          );
        },
      ),
    );
  }
}
