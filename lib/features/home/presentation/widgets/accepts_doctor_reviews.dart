import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class AcceptDoctorBtn extends StatelessWidget {
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final bool isLoading;

  const AcceptDoctorBtn({
    super.key,
    this.onAccept,
    this.onReject,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: isLoading ? null : onAccept,
            borderRadius: BorderRadius.circular(40),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: ShapeDecoration(
                color: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading)
                    SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.whiteColor,
                      ),
                    )
                  else ...[
                    Text(
                      'common.accept'.tr(),
                      textAlign: TextAlign.center,
                      style: theme.bold12.copyWith(
                        fontSize: 14,
                        color: theme.whiteColor,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(Icons.check, color: theme.whiteColor, size: 18),
                  ],
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            onTap: isLoading ? null : onReject,
            borderRadius: BorderRadius.circular(40),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: theme.textColor100),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'reservations.reject'.tr(),
                    textAlign: TextAlign.center,
                    style: theme.bold12.copyWith(
                      fontSize: 14,
                      color: const Color(0xFFFF2D55),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.close,
                    color: Color(0xFFFF2D55),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
