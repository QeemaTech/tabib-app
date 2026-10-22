import 'package:flutter/material.dart';
import 'package:tabib_app/features/patient_flow/wallet/presentation/view_model/wallet_view_model.dart';
import 'package:tabib_app/features/patient_flow/wallet/presentation/widgets/wallet_content.dart';

class PatientWalletView extends StatelessWidget {
  const PatientWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const WalletContent(role: WalletRole.patient);
  }
}
