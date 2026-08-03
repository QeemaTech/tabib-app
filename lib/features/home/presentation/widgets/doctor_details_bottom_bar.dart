import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class DoctorDetailsBottomBar extends StatelessWidget {
  final double consultationFee;

  const DoctorDetailsBottomBar({
    super.key,
    required this.consultationFee,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        boxShadow: [
          BoxShadow(
            color: theme.textColor600.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'home.doctorDetails.price'.tr(),
                style: theme.regular12.copyWith(color: theme.textColor200),
              ),
              Text(
                '$consultationFee ${'home.search.currency'.tr()}',
                style: theme.bold18.copyWith(color: theme.primaryColor),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'home.doctorDetails.confirm'.tr(),
                style: theme.bold18.copyWith(
                  color: theme.whiteColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
