import 'package:flutter/material.dart';
import 'package:tabib_app/features/wallet/presentation/view_model/wallet_view_model.dart';
import 'package:tabib_app/features/wallet/presentation/widgets/wallet_content.dart';

class DocWalletView extends StatelessWidget {
  const DocWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const WalletContent(role: WalletRole.doctor);
  }
}
