import 'package:flutter/material.dart';
import 'package:tabib_app/features/profile/presentation/widgets/profile_choice_chip.dart';

class ProfileBloodTypeSelector extends StatelessWidget {
  final String selected;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const ProfileBloodTypeSelector({
    super.key,
    required this.selected,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options
          .map(
            (type) => ProfileChoiceChip(
              label: type,
              selected: selected == type,
              onTap: () => onChanged(type),
            ),
          )
          .toList(),
    );
  }
}
