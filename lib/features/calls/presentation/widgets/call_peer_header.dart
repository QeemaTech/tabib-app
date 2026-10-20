import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class CallPeerHeader extends StatelessWidget {
  final String peerName;
  final String statusLabel;

  const CallPeerHeader({
    super.key,
    required this.peerName,
    required this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Column(
          children: [
            Text(
              peerName.isNotEmpty ? peerName : statusLabel,
              style: theme.bold18.copyWith(color: theme.whiteColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              statusLabel,
              style: theme.regular14.copyWith(color: theme.textColor100),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
