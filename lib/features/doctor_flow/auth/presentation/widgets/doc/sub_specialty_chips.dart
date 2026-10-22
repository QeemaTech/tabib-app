import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/auth/domain/entities/specialty_entity.dart';

class SubSpecialtyChips extends StatelessWidget {
  final List<SpecialtyEntity> specialties;
  final List<String> selectedIds;
  final ValueChanged<String> onToggle;

  const SubSpecialtyChips({
    super.key,
    required this.specialties,
    required this.selectedIds,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;

    if (specialties.isEmpty) {
      return Text(
        'auth.completeProfile.stepOne.noSubSpecialties'.tr(),
        style: theme.regular14.copyWith(color: theme.textColor300),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: specialties.map((specialty) {
        final selected = selectedIds.contains(specialty.id);
        return FilterChip(
          label: Text(specialty.localizedName(languageCode)),
          selected: selected,
          onSelected: (_) => onToggle(specialty.id),
          selectedColor: theme.primaryColor.withValues(alpha: 0.15),
          checkmarkColor: theme.primaryColor,
          labelStyle: theme.medium13.copyWith(
            color: selected ? theme.primaryColor : theme.textColor300,
          ),
          side: BorderSide(
            color: selected ? theme.primaryColor : theme.textColor100,
          ),
          backgroundColor: theme.whiteColor,
        );
      }).toList(),
    );
  }
}
