import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/features/home/presentation/widgets/details_section.dart';

class DoctorAboutSection extends StatelessWidget {
  const DoctorAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailsSection(
      title: 'home.doctorDetails.about'.tr(),
      child: Text(
        'home.doctorDetails.aboutText'.tr(),
        style: const TextStyle(height: 1.5),
      ),
    );
  }
}
