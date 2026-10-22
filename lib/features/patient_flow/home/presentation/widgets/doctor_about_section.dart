import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/widgets/details_section.dart';

class DoctorAboutSection extends StatelessWidget {
  final String bio;

  const DoctorAboutSection({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    if (bio.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = context.appTheme;
    return DetailsSection(
      title: 'home.doctorDetails.about'.tr(),
      child: Text(
        bio,
        style: theme.regular14.copyWith(
          color: theme.textColor300,
          height: 1.5,
        ),
      ),
    );
  }
}
