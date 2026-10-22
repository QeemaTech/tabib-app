import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/view_model/prescription_details_view_model.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/widgets/prescription_details_body.dart';

class PrescriptionDetailsView extends StatelessWidget {
  final String prescriptionId;

  const PrescriptionDetailsView({super.key, required this.prescriptionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<PrescriptionDetailsViewModel>()..load(prescriptionId),
      child: PrescriptionDetailsBody(prescriptionId: prescriptionId),
    );
  }
}
