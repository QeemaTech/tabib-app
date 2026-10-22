import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patient_flow/calls/domain/entities/call_session_entity.dart';

class CallEndedSheet extends StatelessWidget {
  final CallSessionEntity session;
  final VoidCallback onDone;

  const CallEndedSheet({
    super.key,
    required this.session,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final minutes = session.durationSeconds ~/ 60;
    final seconds = session.durationSeconds % 60;
    final durationLabel =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'calls.callEnded'.tr(),
            style: theme.bold18.copyWith(color: theme.textColor600),
          ),
          const SizedBox(height: 8),
          Text(
            'calls.duration'.tr(args: [durationLabel]),
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onDone,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: theme.whiteColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text('calls.done'.tr()),
            ),
          ),
        ],
      ),
    );
  }
}
