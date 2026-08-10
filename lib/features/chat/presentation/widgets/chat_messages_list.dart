import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/chat/domain/entities/message_entity.dart';
import 'package:tabib_app/features/chat/presentation/utils/chat_list_ui_helpers.dart';
import 'package:tabib_app/features/chat/presentation/widgets/chat_bubble.dart';

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
    // reverse:true → older messages are toward maxScrollExtent.
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
    final itemCount = messages.length + (widget.isLoadingMore ? 1 : 0);

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.all(20),
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
        final message = messages[messages.length - 1 - index];
        return ChatBubble(
          message: message.content,
          time: formatChatListTime(message.createdAt),
          isMe: message.isMine,
          isPending: message.isPending,
        );
      },
    );
  }
}
