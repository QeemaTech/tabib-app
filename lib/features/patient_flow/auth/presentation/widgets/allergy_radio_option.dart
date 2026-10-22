import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class AllergyRadioOption extends StatelessWidget {
  const AllergyRadioOption({
    super.key,
    required this.title,
    required this.optionValue,
    required this.groupValue,
    required this.onChanged,
  });

  final String title;
  final bool optionValue;
  final bool groupValue;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final isSelected = optionValue == groupValue;
    return InkWell(
      onTap: () => onChanged(optionValue),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        children: [
          Text(
            title.tr(),
            style: theme.medium16.copyWith(color: theme.textColor600),
          ),
          const SizedBox(width: 8),
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? theme.primaryColor : theme.textColor200,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.primaryColor,
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
