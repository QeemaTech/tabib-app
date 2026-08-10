import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/chat/presentation/view_model/chat_details_state.dart';
import 'package:tabib_app/features/chat/presentation/view_model/chat_details_view_model.dart';
import 'package:tabib_app/features/chat/presentation/widgets/chat_message_input.dart';
import 'package:tabib_app/features/chat/presentation/widgets/chat_messages_list.dart';

class ChatDetailsView extends StatelessWidget {
  const ChatDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocListener<ChatDetailsViewModel, ChatDetailsState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage &&
          current.errorMessage != null &&
          !current.historyState.isError,
      listener: (context, state) {
        CustomToast.error(context, state.errorMessage ?? 'errors.unknown'.tr());
        context.read<ChatDetailsViewModel>().clearError();
      },
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: theme.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: BlocSelector<ChatDetailsViewModel, ChatDetailsState, String>(
            selector: (state) => state.participantTitle,
            builder: (context, title) => Text(
              title.isNotEmpty ? title : 'layout.navBar.messages'.tr(),
              style: theme.bold18.copyWith(color: theme.textColor600),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: theme.textColor600, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: _ChatTypingStatusBar(),
          ),
        ),
        body: const Column(
          children: [
            Expanded(child: _ChatMessagesBody()),
            _ChatComposer(),
          ],
        ),
      ),
    );
  }
}

class _ChatTypingStatusBar extends StatelessWidget {
  const _ChatTypingStatusBar();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocBuilder<ChatDetailsViewModel, ChatDetailsState>(
      buildWhen: (p, c) =>
          p.isPeerTyping != c.isPeerTyping ||
          p.isJoined != c.isJoined ||
          p.isConnected != c.isConnected,
      builder: (context, state) {
        final text = state.isPeerTyping
            ? 'chat.typing'.tr()
            : (!state.isConnected
                ? 'chat.reconnecting'.tr()
                : (!state.isJoined ? 'chat.joining'.tr() : ''));
        if (text.isEmpty) return const SizedBox(height: 20);
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            text,
            style: theme.regular12.copyWith(color: theme.textColor200),
          ),
        );
      },
    );
  }
}

class _ChatMessagesBody extends StatelessWidget {
  const _ChatMessagesBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailsViewModel, ChatDetailsState>(
      buildWhen: (p, c) =>
          p.messages != c.messages ||
          p.historyState != c.historyState ||
          p.hasMore != c.hasMore ||
          p.isLoadingMore != c.isLoadingMore,
      builder: (context, state) {
        if (state.historyState.isLoading || state.historyState.isInitial) {
          return const _ChatHistoryLoadingWidget();
        }
        if (state.historyState.isError) {
          return _ChatHistoryErrorWidget(
            message: state.historyState.errorMessage ??
                state.errorMessage ??
                'errors.unknown'.tr(),
          );
        }
        if (state.messages.isEmpty) {
          return const _ChatEmptyMessagesWidget();
        }
        return ChatMessagesList(
          messages: state.messages,
          hasMore: state.hasMore,
          isLoadingMore: state.isLoadingMore,
          onLoadMore: () =>
              context.read<ChatDetailsViewModel>().loadOlderMessages(),
        );
      },
    );
  }
}

class _ChatHistoryLoadingWidget extends StatelessWidget {
  const _ChatHistoryLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: context.appTheme.primaryColor),
    );
  }
}

class _ChatHistoryErrorWidget extends StatelessWidget {
  final String message;

  const _ChatHistoryErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.regular14.copyWith(color: theme.textColor300),
            ),
            IconButton(
              onPressed: () =>
                  context.read<ChatDetailsViewModel>().retryHistory(),
              icon: Icon(Icons.refresh, color: theme.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatEmptyMessagesWidget extends StatelessWidget {
  const _ChatEmptyMessagesWidget();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Text(
        'chat.noMessages'.tr(),
        style: theme.regular14.copyWith(color: theme.textColor300),
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  const _ChatComposer();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatDetailsViewModel, ChatDetailsState, bool>(
      selector: (state) => state.canSend,
      builder: (context, canSend) {
        final vm = context.read<ChatDetailsViewModel>();
        return ChatMessageInput(
          enabled: canSend,
          onChanged: vm.onComposerChanged,
          onSend: vm.sendMessage,
        );
      },
    );
  }
}
