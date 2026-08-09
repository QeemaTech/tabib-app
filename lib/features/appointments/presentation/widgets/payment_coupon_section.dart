import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';

class PaymentCouponSection extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final bool hasAppliedCoupon;
  final VoidCallback onApply;
  final VoidCallback onClear;

  const PaymentCouponSection({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.hasAppliedCoupon,
    required this.onApply,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'appointments.couponHint'.tr(),
          style: theme.medium13.copyWith(color: theme.textColor300),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: controller,
                hintText: 'appointments.couponCode'.tr(),
                readOnly: hasAppliedCoupon || isLoading,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : (hasAppliedCoupon ? onClear : onApply),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: theme.whiteColor,
                // Theme default is width: infinity — breaks when used in a Row.
                minimumSize: const Size(0, 52),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.whiteColor,
                      ),
                    )
                  : Text(
                      hasAppliedCoupon
                          ? 'appointments.clearCoupon'.tr()
                          : 'appointments.applyCoupon'.tr(),
                      style: theme.regular12.copyWith(
                        color: theme.whiteColor,
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
