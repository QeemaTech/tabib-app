import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class ChatMessageInput extends StatefulWidget {
  final bool enabled;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSend;

  const ChatMessageInput({
    super.key,
    required this.enabled,
    required this.onChanged,
    required this.onSend,
  });

  @override
  State<ChatMessageInput> createState() => _ChatMessageInputState();
}

class _ChatMessageInputState extends State<ChatMessageInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (!widget.enabled) return;
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    widget.onSend(text);
    _controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border(
          top: BorderSide(color: theme.textColor100.withValues(alpha: 0.4)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: widget.enabled,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onChanged: widget.onChanged,
                onSubmitted: (_) => _handleSend(),
                style: theme.regular14.copyWith(color: theme.textColor600),
                decoration: InputDecoration(
                  hintText: 'chat.hint'.tr(),
                  hintStyle: theme.regular14.copyWith(
                    color: theme.textColor200,
                  ),
                  filled: true,
                  fillColor: theme.whiteColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: theme.textColor100.withValues(alpha: 0.7),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: theme.textColor100.withValues(alpha: 0.7),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: theme.primaryColor),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Material(
              color: widget.enabled
                  ? theme.primaryColor
                  : theme.textColor100,
              shape: const CircleBorder(),
              child: IconButton(
                onPressed: widget.enabled ? _handleSend : null,
                icon: Icon(
                  Icons.send,
                  color: theme.whiteColor,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
