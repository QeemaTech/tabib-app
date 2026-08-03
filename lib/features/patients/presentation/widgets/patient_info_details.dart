import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class PatientInfoDetails extends StatelessWidget {
  final String gender;
  final String birthDate;
  final String height;
  final String weight;

  const PatientInfoDetails({
    super.key,
    required this.gender,
    required this.birthDate,
    required this.height,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.textColor100.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 5,
        children: [
          _buildInfoItem(
            context,
            'patients.details.birthDate'.tr(),
            birthDate,
          ),
          _buildInfoItem(context, 'patients.details.gender'.tr(), gender),
          _buildInfoItem(context, 'patients.details.weight'.tr(), weight),
          _buildInfoItem(context, 'patients.details.height'.tr(), height),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value) {
    final theme = context.appTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: theme.medium16.copyWith(color: theme.textColor600, fontSize: 13),
        ),
        const SizedBox(width: 4),
        Text(
          ':$label',
          style: theme.regular14.copyWith(color: theme.textColor300, fontSize: 13),
        ),
      ],
    );
  }
}
