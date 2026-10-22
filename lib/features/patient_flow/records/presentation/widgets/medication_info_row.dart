import 'package:flutter/material.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/widgets/medication_info_column.dart';

class MedicationInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final String secondLabel;
  final String secondValue;

  const MedicationInfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.secondLabel,
    required this.secondValue,
  });

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty && secondValue.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          if (value.isNotEmpty)
            Expanded(child: MedicationInfoColumn(label: label, value: value)),
          if (secondValue.isNotEmpty)
            Expanded(
              child: MedicationInfoColumn(
                label: secondLabel,
                value: secondValue,
              ),
            ),
        ],
      ),
    );
  }
}
