import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patient_flow/chat/domain/entities/message_entity.dart';
import 'package:tabib_app/features/patient_flow/chat/presentation/utils/chat_list_ui_helpers.dart';
import 'package:tabib_app/features/patient_flow/chat/presentation/widgets/chat_bubble.dart';
import 'package:tabib_app/features/patient_flow/chat/presentation/widgets/chat_day_chip.dart';

class ChatMessagesList extends StatefulWidget {
  final List<MessageEntity> messages;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback? onLoadMore;

  const ChatMessagesList({
    super.key,
    required this.messages,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.onLoadMore,
  });

  @override
  State<ChatMessagesList> createState() => _ChatMessagesListState();
}

class _ChatMessagesListState extends State<ChatMessagesList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _jumpToLatest());
  }

  @override
  void didUpdateWidget(covariant ChatMessagesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldLastId =
        oldWidget.messages.isEmpty ? null : oldWidget.messages.last.id;
    final newLastId =
        widget.messages.isEmpty ? null : widget.messages.last.id;
    final prependedOlder = oldWidget.messages.isNotEmpty &&
        widget.messages.length > oldWidget.messages.length &&
        oldLastId == newLastId;
    if (!prependedOlder &&
        (oldWidget.messages.length != widget.messages.length ||
            oldLastId != newLastId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _jumpToLatest());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!widget.hasMore || widget.isLoadingMore || widget.onLoadMore == null) {
      return;
    }
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 80) {
      widget.onLoadMore!();
    }
  }

  void _jumpToLatest() {
    if (!_scrollController.hasClients) return;
    _scrollController.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final messages = widget.messages;
    final locale = Localizations.localeOf(context).toString();
    final itemCount = messages.length + (widget.isLoadingMore ? 1 : 0);

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (widget.isLoadingMore && index == messages.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.primaryColor,
                ),
              ),
            ),
          );
        }
        final messageIndex = messages.length - 1 - index;
        final message = messages[messageIndex];
        final showDay = messageIndex == 0 ||
            !isSameChatDay(
              messages[messageIndex - 1].createdAt,
              message.createdAt,
            );
        return Column(
          children: [
            if (showDay)
              ChatDayChip(
                label: formatChatDayLabel(message.createdAt, locale: locale),
              ),
            ChatBubble(
              message: message.content,
              time: formatChatMessageTime(message.createdAt, locale: locale),
              isMe: message.isMine,
              isPending: message.isPending,
              status: message.status,
              isRead: message.isRead,
              fileName: message.fileName,
            ),
          ],
        );
      },
    );
  }
}
