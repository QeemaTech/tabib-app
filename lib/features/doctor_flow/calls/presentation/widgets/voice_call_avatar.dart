import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class VoiceCallAvatar extends StatelessWidget {
  final String peerName;

  const VoiceCallAvatar({super.key, required this.peerName});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final trimmed = peerName.trim();
    final initial = trimmed.isNotEmpty ? trimmed[0].toUpperCase() : '?';

    return CircleAvatar(
      radius: 64,
      backgroundColor: theme.primaryColor300,
      child: Text(
        initial,
        style: theme.bold24.copyWith(color: theme.whiteColor),
      ),
    );
  }
}
