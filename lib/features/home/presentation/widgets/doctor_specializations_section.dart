import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_specialty_entity.dart';
import 'package:tabib_app/features/home/presentation/widgets/details_section.dart';

class DoctorSpecializationsSection extends StatelessWidget {
  final List<DoctorSpecialtyEntity> specialties;

  const DoctorSpecializationsSection({
    super.key,
    required this.specialties,
  });

  @override
  Widget build(BuildContext context) {
    if (specialties.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;

    return DetailsSection(
      title: 'home.search.specializations'.tr(),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: specialties
            .map(
              (specialty) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: theme.primaryColor300,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  specialty.localizedName(languageCode),
                  style: theme.medium13.copyWith(color: theme.primaryColor),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
