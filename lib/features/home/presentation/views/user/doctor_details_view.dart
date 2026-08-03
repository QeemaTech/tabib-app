import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/widgets/calendar_section.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_details_state.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_details_view_model.dart';
import 'package:tabib_app/features/home/presentation/widgets/doctor_about_section.dart';
import 'package:tabib_app/features/home/presentation/widgets/doctor_certificates_section.dart';
import 'package:tabib_app/features/home/presentation/widgets/doctor_details_bottom_bar.dart';
import 'package:tabib_app/features/home/presentation/widgets/doctor_header_card.dart';
import 'package:tabib_app/features/home/presentation/widgets/doctor_specializations_section.dart';

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text('home.doctorDetails.title'.tr(), style: theme.bold18),
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<DoctorDetailsViewModel, DoctorDetailsState>(
        builder: (context, state) {
          final detailsState = state.doctorDetailsState;

          if (detailsState.isLoading || detailsState.isInitial) {
            return Center(
              child: CircularProgressIndicator(color: theme.primaryColor),
            );
          }

          if (detailsState.isError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    detailsState.errorMessage ?? '',
                    textAlign: TextAlign.center,
                    style: theme.regular14.copyWith(color: theme.textColor300),
                  ),
                  const SizedBox(height: 12),
                  IconButton(
                    onPressed: () =>
                        context.read<DoctorDetailsViewModel>().retry(),
                    icon: Icon(Icons.refresh, color: theme.primaryColor),
                  ),
                ],
              ),
            );
          }

          final doctor = detailsState.data;
          if (doctor == null) {
            return const SizedBox.shrink();
          }

          final languageCode = context.locale.languageCode;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DoctorHeaderCard(doctor: doctor),
                const SizedBox(height: 16),
                DoctorSpecializationsSection(specialties: doctor.specialties),
                const SizedBox(height: 16),
                DoctorAboutSection(bio: doctor.localizedBio(languageCode)),
                const SizedBox(height: 16),
                DoctorCertificatesSection(certificates: doctor.certificates),
                const SizedBox(height: 16),
                const CalendarSection(),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar:
          BlocBuilder<DoctorDetailsViewModel, DoctorDetailsState>(
        buildWhen: (previous, current) =>
            previous.doctorDetailsState != current.doctorDetailsState,
        builder: (context, state) {
          final doctor = state.doctorDetailsState.data;
          if (doctor == null) {
            return const SizedBox.shrink();
          }
          return DoctorDetailsBottomBar(
            consultationFee: doctor.consultationFee,
          );
        },
      ),
    );
  }
}
