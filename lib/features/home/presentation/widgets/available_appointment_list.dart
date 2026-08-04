import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/home/domain/entities/availability_slot_entity.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_details_state.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_details_view_model.dart';
import 'package:tabib_app/features/home/presentation/widgets/available_appointment_card.dart';

class AvailableAppointmentList extends StatelessWidget {
  const AvailableAppointmentList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return BlocBuilder<DoctorDetailsViewModel, DoctorDetailsState>(
      buildWhen: (previous, current) =>
          previous.availabilityState != current.availabilityState ||
          previous.selectedSlot != current.selectedSlot,
      builder: (context, state) {
        final availabilityState = state.availabilityState;

        if (availabilityState.isLoading || availabilityState.isInitial) {
           return Skeletonizer(
            enabled: true,
             child: ListView.separated(
                       shrinkWrap: true,
                       physics: const NeverScrollableScrollPhysics(),
                       itemCount: 10,
                       separatorBuilder: (_, _) => const SizedBox(height: 8),
                       itemBuilder: (context, index) {
                      
              return AvailableAppointmentCard(
                startTime: '10:00',
                endTime: '11:00',
                isAvailable: true,
                isSelected: false,
                
              );
                       },
                     ),
           );
        }

        if (availabilityState.isError) {
          return Center(
            child: Column(
              children: [
                Text(
                  availabilityState.errorMessage ?? '',
                  textAlign: TextAlign.center,
                  style: theme.regular14.copyWith(color: theme.textColor300),
                ),
                IconButton(
                  onPressed: () => context
                      .read<DoctorDetailsViewModel>()
                      .loadAvailability(state.selectedDate),
                  icon: Icon(Icons.refresh, color: theme.primaryColor),
                ),
              ],
            ),
          );
        }

        final slots = availabilityState.data?.slots ?? const [];
        if (slots.isEmpty) {
          return const SizedBox.shrink();
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: slots.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final AvailabilitySlotEntity slot = slots[index];
            return AvailableAppointmentCard(
              startTime: slot.startTime,
              endTime: slot.endTime,
              isAvailable: slot.available,
              isSelected: state.selectedSlot == slot,
              onTap: () =>
                  context.read<DoctorDetailsViewModel>().selectSlot(slot),
            );
          },
        );
      },
    );
  }
}
