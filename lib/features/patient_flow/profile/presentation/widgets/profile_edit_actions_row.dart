import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class ProfileEditActionsRow extends StatelessWidget {
  final bool isUpdating;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const ProfileEditActionsRow({
    super.key,
    required this.isUpdating,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: isUpdating ? null : onCancel,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              side: BorderSide(color: theme.primaryColor300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'common.cancel'.tr(),
              style: theme.medium16.copyWith(color: theme.primaryColor),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: isUpdating ? null : onSave,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              backgroundColor: theme.primaryColor,
              foregroundColor: theme.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: isUpdating
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.whiteColor,
                    ),
                  )
                : Text(
                    'profile.personal.save'.tr(),
                    style: theme.medium16.copyWith(color: theme.whiteColor),
                  ),
          ),
        ),
      ],
    );
  }
}
