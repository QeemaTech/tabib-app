import 'package:flutter/material.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/home/domain/entities/featured_doctor_entity.dart';
import 'package:tabib_app/features/home/presentation/widgets/featured_doctor_card.dart';

class FeaturedDoctorsList extends StatelessWidget {
  final List<FeaturedDoctorEntity> doctors;

  const FeaturedDoctorsList({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: doctors.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return FeaturedDoctorCard(
          doctor: doctors[index],
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.doctorDetailsView);
          },
        );
      },
    );
  }
}
