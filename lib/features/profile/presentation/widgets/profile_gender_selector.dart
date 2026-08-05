import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/features/profile/presentation/widgets/profile_choice_chip.dart';

class ProfileGenderSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const ProfileGenderSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ProfileChoiceChip(
            label: 'profile.male'.tr(),
            selected: selected == 'MALE',
            onTap: () => onChanged('MALE'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ProfileChoiceChip(
            label: 'profile.female'.tr(),
            selected: selected == 'FEMALE',
            onTap: () => onChanged('FEMALE'),
          ),
        ),
      ],
    );
  }
}
