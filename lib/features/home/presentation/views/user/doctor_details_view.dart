import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/core/widgets/calendar_section.dart';
import 'package:tabib_app/features/auth/presentation/widgets/drop_down_menu.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_details_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_specialty_entity.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_details_state.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_details_view_model.dart';
import 'package:tabib_app/features/home/presentation/widgets/available_appointment_list.dart';
import 'package:tabib_app/features/home/presentation/widgets/doctor_about_section.dart';
import 'package:tabib_app/features/home/presentation/widgets/doctor_certificates_section.dart';
import 'package:tabib_app/features/home/presentation/widgets/doctor_details_bottom_bar.dart';
import 'package:tabib_app/features/home/presentation/widgets/doctor_header_card.dart';
import 'package:tabib_app/features/home/presentation/widgets/doctor_specializations_section.dart';

class DoctorDetailsView extends StatefulWidget {
  const DoctorDetailsView({super.key});

  @override
  State<DoctorDetailsView> createState() => _DoctorDetailsViewState();
}

class _DoctorDetailsViewState extends State<DoctorDetailsView> {
  late final TextEditingController notesController;

  static const _consultationItems = [
    'home.doctorDetails.consultationChat',
    'home.doctorDetails.consultationVideo',
    'home.doctorDetails.consultationCall',
  ];

  static const _consultationApiValues = {
    'home.doctorDetails.consultationChat': 'CHAT',
    'home.doctorDetails.consultationVideo': 'VIDEO',
    'home.doctorDetails.consultationCall': 'VOICE',
  };

  @override
  void initState() {
    super.initState();
    notesController = TextEditingController();
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return BlocListener<DoctorDetailsViewModel, DoctorDetailsState>(
      listenWhen: (previous, current) =>
          previous.bookAppointmentState != current.bookAppointmentState,
      listener: (context, state) {
        final bookState = state.bookAppointmentState;
        if (bookState.isLoaded) {
          CustomToast.success(
            context,
            'home.doctorDetails.bookSuccess'.tr(),
          );
          Navigator.pop(context);
        }
        if (bookState.isError) {
          CustomToast.error(
            context,
            bookState.errorMessage ?? '',
          );
        }
      },
      child: Scaffold(
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
              return const DoctorDetailsLoadingBody();
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
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorHeaderCard(doctor: doctor),
                  DoctorSpecializationsSection(specialties: doctor.specialties),
                  DoctorAboutSection(bio: doctor.localizedBio(languageCode)),
                  DoctorCertificatesSection(certificates: doctor.certificates),
                  Text(
                    'home.doctorDetails.selectConsultationType'.tr(),
                    style: theme.bold12,
                  ),
                  CustomDropdownField(
                    hintText: 'home.doctorDetails.selectConsultationType'.tr(),
                    items: _consultationItems,
                    onChanged: (value) {
                      if (value == null) return;
                      final apiValue =
                          _consultationApiValues[value] ?? value;
                      context
                          .read<DoctorDetailsViewModel>()
                          .selectConsultationType(apiValue);
                    },
                  ),
                  Text(
                    'home.doctorDetails.notes'.tr(),
                    style: theme.bold12,
                  ),
                  CustomTextFormField(
                    hintText: 'home.doctorDetails.notesHint'.tr(),
                    maxLines: 3,
                    controller: notesController,
                  ),
                  CalendarSection(
                    selectedDay: state.selectedDate,
                    onDaySelected: (day) {
                      context.read<DoctorDetailsViewModel>().selectDate(day);
                    },
                  ),
                  const AvailableAppointmentList(),
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
      ),
    );
  }
}

class DoctorDetailsLoadingBody extends StatelessWidget {
  const DoctorDetailsLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DoctorHeaderCard(
              doctor: const DoctorDetailsEntity(
                id: '1',
                fullNameAr: 'دكتور أحمد',
                fullNameEn: 'Doctor Name',
                avatarUrl: '',
                bioAr: 'نبذة عن الطبيب',
                bioEn: 'Doctor biography placeholder for the loading state.',
                experienceYears: 10,
                consultationFee: 25,
                ratingAvg: 4.8,
                ratingCount: 20,
                isOnline: true,
                specialties: [
                  DoctorSpecialtyEntity(
                    id: '1',
                    nameAr: 'قلب',
                    nameEn: 'Cardiology',
                  ),
                ],
                certificates: [],
                reviews: [],
              ),
            ),
            DoctorSpecializationsSection(
              specialties: const [
                DoctorSpecialtyEntity(
                  id: '1',
                  nameAr: 'قلب',
                  nameEn: 'Cardiology',
                ),
              ],
            ),
            const DoctorAboutSection(
              bio: 'Doctor biography placeholder for the loading state.',
            ),
            Text(
              'home.doctorDetails.selectConsultationType'.tr(),
              style: context.appTheme.bold12,
            ),
            const CalendarSection(selectedDay: null),
          ],
        ),
      ),
    );
  }
}
