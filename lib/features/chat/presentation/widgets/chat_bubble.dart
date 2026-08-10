import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final bool isPending;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: isPending ? 0.7 : 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.75,
              ),
              decoration: BoxDecoration(
                color: isMe
                    ? theme.primaryColor
                    : theme.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isMe ? const Radius.circular(20) : Radius.zero,
                  bottomRight: isMe ? Radius.zero : const Radius.circular(20),
                ),
              ),
              child: Text(
                message,
                style: theme.regular14.copyWith(
                  color: isMe ? theme.whiteColor : theme.textColor600,
                  height: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: theme.regular12.copyWith(color: theme.textColor200),
          ),
        ],
      ),
    );
  }
}
