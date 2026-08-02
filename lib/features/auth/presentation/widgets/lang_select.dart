import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key, required this.onLanguageSelected});
  final ValueChanged<String> onLanguageSelected;
  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String selectedLanguage = 'ar';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // English Option
        Expanded(
          child: _buildLanguageButton(
            context: context,
            label: 'English',
            value: 'en',
            isSelected: selectedLanguage == 'en',
            onTap: () {
              widget.onLanguageSelected('en');
              setState(() {
                selectedLanguage = 'en';
              });
            },
          ),
        ),
        const SizedBox(width: 16.0), // Space between the buttons
        // Arabic Option
        Expanded(
          child: _buildLanguageButton(
            context: context,
            label: 'العربية',
            value: 'ar',
            isSelected: selectedLanguage == 'ar',
            onTap: () {
              widget.onLanguageSelected("ar");
              setState(() {
                selectedLanguage = 'ar';
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageButton({
    required BuildContext context,
    required String label,
    required String value,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = context.appTheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFE9EBF1) : Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isSelected ? theme.primaryColor : const Color(0xFFD1D5DB),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? theme.primaryColor
                    : const Color(0xFF9EA6B4),
              ),
            ),
            const SizedBox(width: 10.0),
            // Custom Radio Indicator
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? theme.primaryColor.withValues(alpha: 0.2)
                    : const Color(0xFFE5E7EB),
                border: Border.all(
                  color: isSelected
                      ? theme.primaryColor
                      : const Color(0xFF9EA6B4),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
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
      ),
    );
  }
}
