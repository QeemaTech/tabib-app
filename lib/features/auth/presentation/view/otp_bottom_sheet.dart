import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/extension/app_extension.dart';
import 'otp_widget.dart';

class OtpBottomSheet extends StatefulWidget {
  const OtpBottomSheet({super.key});

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  Timer? _timer;
  int _remainingTime = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _remainingTime = 30;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: EdgeInsets.only(
        top: 16,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24), // Spacer to center the title text
                Text(
                  "Verification",
                  style: theme.bold24.copyWith(
                    fontSize: 20,
                    color: theme.textColor600,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xFF1B365D),
                    size: 24,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'We have sent a 6-digit code to your phone number +965 ••••1234',
              textAlign: TextAlign.center,
              style: theme.regular14.copyWith(color: theme.textColor200),
            ),
            OTPWidget(onCompleted: (pin) {}, hasError: false, isLoading: false),
            const SizedBox(height: 24),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(
                  text: "Didn't receive the code? Resend it in $_remainingTime seconds.",
                  style: theme.regular14.copyWith(color: theme.primaryColor300),
                ),
                TextSpan(
                  text: "Resend it",
                  style: theme.medium16.copyWith(color: theme.blackColor),
                ),
              ],
            )),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Confirm',
                style: theme.regular14.copyWith(color: theme.whiteColor),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
