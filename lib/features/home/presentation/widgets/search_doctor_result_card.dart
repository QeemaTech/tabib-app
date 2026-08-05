import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/home/domain/entities/search_doctor_entity.dart';
import 'package:tabib_app/features/home/presentation/widgets/doctor_search_card.dart';

class SearchDoctorResultCard extends StatelessWidget {
  final SearchDoctorEntity doctor;

  const SearchDoctorResultCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    return DoctorSearchCard(
      name: doctor.localizedFullName(languageCode),
      specialty: doctor.specialties.isNotEmpty
          ? doctor.specialties.first
          : doctor.clinicName,
      rating: doctor.ratingAvg,
      appointmentsCount: '${doctor.ratingCount}',
      specializations: doctor.specialties,
      date: doctor.clinicName,
      time: doctor.city,
      price: '${doctor.consultationFee}',
      imageUrl: doctor.hasAvatar ? doctor.avatarUrl : null,
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.doctorDetailsView,
          arguments: doctor.id,
        );
      },
    );
  }
}
