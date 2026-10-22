import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

class RoleSelectionWidget extends StatefulWidget {
  final Function(String) onRoleChanged;
  const RoleSelectionWidget({super.key, required this.onRoleChanged});

  @override
  State<RoleSelectionWidget> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionWidget> {
  String _selectedRole = 'user';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildRoleCard(
          context: context,
          id: 'user',
          titleKey: 'auth.role.user.title',
          subtitleKey: 'auth.role.user.subtitle',
          iconPath: AssetsManager.user,
          isSelected: _selectedRole == 'user',
        ),
        const SizedBox(height: 16.0),
        // Doctor Card
        _buildRoleCard(
          context: context,
          id: 'doctor',
          titleKey: 'auth.role.doctor.title',
          subtitleKey: 'auth.role.doctor.subtitle',
          iconPath: AssetsManager.doctor,
          isSelected: _selectedRole == 'doctor',
        ),
      ],
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String id,
    required String titleKey,
    required String subtitleKey,
    required String iconPath,
    required bool isSelected,
  }) {
    final theme =
        context.appTheme; // Use theme colors instead of hardcoded values
    final Color primaryBlue = theme.primaryColor;
    final Color textGrey = theme.textColor300;
    final Color activeBgColor = theme.primaryColor.withOpacity(0.06);
    final Color inactiveBorderColor = theme.textColor200.withOpacity(0.3);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = id;
        });
        widget.onRoleChanged(id);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? activeBgColor : Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isSelected ? primaryBlue : inactiveBorderColor,
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImageView(imagePath: iconPath),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleKey.tr(),
                    style: theme.bold24.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: isSelected
                          ? primaryBlue
                          : textGrey.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    subtitleKey.tr(),
                    style: theme.medium13.copyWith(
                      fontSize: 14.0,
                      color: isSelected
                          ? primaryBlue.withOpacity(0.7)
                          : textGrey,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward,
              color: isSelected ? primaryBlue.withOpacity(0.7) : textGrey,
            ),
          ],
        ),
      ),
    );
  }
}
