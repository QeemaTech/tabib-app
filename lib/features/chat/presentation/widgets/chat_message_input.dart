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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: theme.textColor600.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: theme.textColor100.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  enabled: widget.enabled,
                  onChanged: widget.onChanged,
                  onSubmitted: (_) => _handleSend(),
                  decoration: InputDecoration(
                    hintText: 'chat.hint'.tr(),
                    hintStyle: theme.regular14.copyWith(
                      color: theme.textColor200,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: widget.enabled ? _handleSend : null,
                icon: Icon(
                  Icons.send,
                  color: widget.enabled
                      ? theme.primaryColor
                      : theme.textColor200,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
