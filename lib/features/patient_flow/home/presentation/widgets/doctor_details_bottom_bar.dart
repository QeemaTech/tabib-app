import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/view_model/doctor_details_state.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/view_model/doctor_details_view_model.dart';

class DoctorDetailsBottomBar extends StatelessWidget {
  final double consultationFee;

  const DoctorDetailsBottomBar({
    super.key,
    required this.consultationFee,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocBuilder<DoctorDetailsViewModel, DoctorDetailsState>(
      buildWhen: (previous, current) =>
          previous.bookAppointmentState != current.bookAppointmentState,
      builder: (context, state) {
        final isLoading = state.bookAppointmentState.isLoading;
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.whiteColor,
            boxShadow: [
              BoxShadow(
                color: theme.textColor600.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'home.doctorDetails.price'.tr(),
                    style: theme.regular12.copyWith(color: theme.textColor200),
                  ),
                  Text(
                    '$consultationFee ${'home.search.currency'.tr()}',
                    style: theme.bold18.copyWith(color: theme.primaryColor),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => context
                          .read<DoctorDetailsViewModel>()
                          .bookAppointment(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    disabledBackgroundColor: theme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: theme.whiteColor,
                          ),
                        )
                      : Text(
                          'home.doctorDetails.confirm'.tr(),
                          style: theme.bold18.copyWith(
                            color: theme.whiteColor,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
