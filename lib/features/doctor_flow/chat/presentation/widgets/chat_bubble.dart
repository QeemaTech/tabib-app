import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final bool isPending;
  final String status;
  final bool isRead;
  final String? fileName;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
    this.isPending = false,
    this.status = '',
    this.isRead = false,
    this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final mineColor = theme.whiteColor;
    final peerColor = theme.textColor600;
    final metaColor = isMe
        ? theme.whiteColor.withValues(alpha: 0.8)
        : theme.textColor200;
    final attachment = fileName?.trim() ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: isMe
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: Opacity(
          opacity: isPending ? 0.72 : 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.78,
            ),
            decoration: BoxDecoration(
              color: isMe
                  ? theme.primaryColor
                  : theme.whiteColor,
              borderRadius: BorderRadiusDirectional.only(
                topStart: const Radius.circular(18),
                topEnd: const Radius.circular(18),
                bottomStart: Radius.circular(isMe ? 18 : 4),
                bottomEnd: Radius.circular(isMe ? 4 : 18),
              ),
              border: isMe
                  ? null
                  : Border.all(
                      color: theme.textColor100.withValues(alpha: 0.55),
                    ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (attachment.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.attach_file,
                          size: 16,
                          color: isMe ? mineColor : theme.primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          attachment,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.regular12.copyWith(
                            color: isMe ? mineColor : theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (message.trim().isNotEmpty)
                  Text(
                    message,
                    style: theme.regular14.copyWith(
                      color: isMe ? mineColor : peerColor,
                      height: 1.45,
                    ),
                  ),
                if (message.trim().isEmpty && attachment.isEmpty)
                  Text(
                    'chat.attachment'.tr(),
                    style: theme.regular14.copyWith(
                      color: isMe ? mineColor : peerColor,
                    ),
                  ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      time,
                      style: theme.regular12.copyWith(
                        color: metaColor,
                        fontSize: 11,
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 4),
                      Icon(
                        _statusIcon,
                        size: 14,
                        color: metaColor,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData get _statusIcon {
    if (isPending) return Icons.schedule;
    if (isRead || status.toUpperCase() == 'READ') return Icons.done_all;
    if (status.toUpperCase() == 'DELIVERED') return Icons.done_all;
    return Icons.done;
  }
}
