import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomRadioGroup extends StatefulWidget {
  const CustomRadioGroup({super.key});

  @override
  State<CustomRadioGroup> createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  String? _selectedValue = 'yes';

  @override
  Widget build(BuildContext context) {
    return Row(


      children: [
        _buildRadioButton(
          title: 'common.yes',
          value: 'yes',
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
        ),
        const SizedBox(width: 100),
        _buildRadioButton(
          title: 'common.no',
          value: 'no',
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildRadioButton({
    required String title,
    required String value,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    final isSelected = value == groupValue;

    return InkWell(
      onTap: () => onChanged(value),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(

        children: [
          Text(
            title.tr(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              // Dark blue-grey text color matching your UI
              color: const Color(0xFF2B3674),
            ),
          ),
          const SizedBox(width: 8), // Gap between text and the radio circle
          SizedBox(
            width: 24,
            height: 24,
            child: Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              // Color configurations to match the deep blue and grey states
              activeColor: const Color(0xFF1B365D),
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color(0xFF1B365D); // Deep blue when active
                }
                return const Color(0xFFA3AED0); // Soft grey when inactive
              }),
            ),
          ),
        ],
      ),
    );
  }
}