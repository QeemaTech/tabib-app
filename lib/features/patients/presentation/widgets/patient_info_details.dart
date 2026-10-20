import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class PatientInfoDetails extends StatelessWidget {
  final String gender;
  final String birthDate;
  final String height;
  final String weight;
  final String phone;

  const PatientInfoDetails({
    super.key,
    this.gender = '',
    this.birthDate = '',
    this.height = '',
    this.weight = '',
    this.phone = '',
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final rows = <Widget>[
      if (_hasValue(birthDate))
        _PatientInfoRow(
          label: 'patients.details.birthDate'.tr(),
          value: birthDate,
        ),
      if (_hasValue(gender))
        _PatientInfoRow(
          label: 'patients.details.gender'.tr(),
          value: gender,
        ),
      if (_hasValue(phone))
        _PatientInfoRow(
          label: 'appointments.phone'.tr(),
          value: phone,
        ),
      if (_hasValue(weight))
        _PatientInfoRow(
          label: 'patients.details.weight'.tr(),
          value: weight,
        ),
      if (_hasValue(height))
        _PatientInfoRow(
          label: 'patients.details.height'.tr(),
          value: height,
        ),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.textColor100.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 5,
        children: rows,
      ),
    );
  }

  bool _hasValue(String value) {
    final trimmed = value.trim();
    return trimmed.isNotEmpty && trimmed != '—' && trimmed != '----';
  }
}

class _PatientInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _PatientInfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: theme.medium16.copyWith(
              color: theme.textColor600,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          ':$label',
          style: theme.regular14.copyWith(
            color: theme.textColor300,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
