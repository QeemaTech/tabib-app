import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
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
          centerTitle: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: theme.textColor600,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const _ChatDetailsTitle(),
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

class _ChatDetailsTitle extends StatelessWidget {
  const _ChatDetailsTitle();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocBuilder<ChatDetailsViewModel, ChatDetailsState>(
      buildWhen: (previous, current) =>
          previous.participantTitle != current.participantTitle ||
          previous.avatarUrl != current.avatarUrl ||
          previous.isPeerTyping != current.isPeerTyping ||
          previous.isJoined != current.isJoined ||
          previous.isConnected != current.isConnected,
      builder: (context, state) {
        final status = state.isPeerTyping
            ? 'chat.typing'.tr()
            : (!state.isConnected
                ? 'chat.reconnecting'.tr()
                : (!state.isJoined ? 'chat.joining'.tr() : ''));
        final title = state.participantTitle.isNotEmpty
            ? state.participantTitle
            : 'layout.navBar.messages'.tr();
        return Row(
          children: [
            CustomImageView(
              imagePath: state.avatarUrl.isNotEmpty
                  ? state.avatarUrl
                  : AssetsManager.doctor,
              height: 40,
              width: 40,
              radius: BorderRadius.circular(20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.medium16.copyWith(color: theme.textColor600),
                  ),
                  if (status.isNotEmpty)
                    Text(
                      status,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.regular12.copyWith(color: theme.primaryColor),
                    ),
                ],
              ),
            ),
          ],
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.forum_outlined,
              size: 48,
              color: theme.primaryColor.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 12),
            Text(
              'chat.noMessages'.tr(),
              textAlign: TextAlign.center,
              style: theme.regular14.copyWith(color: theme.textColor300),
            ),
          ],
        ),
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
