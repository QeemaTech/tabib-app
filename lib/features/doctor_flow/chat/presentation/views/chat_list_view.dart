import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/doctor_flow/chat/domain/entities/consultation_entity.dart';
import 'package:tabib_app/features/doctor_flow/chat/presentation/utils/chat_details_args.dart';
import 'package:tabib_app/features/doctor_flow/chat/presentation/utils/chat_list_ui_helpers.dart';
import 'package:tabib_app/features/doctor_flow/chat/presentation/view_model/chat_list_state.dart';
import 'package:tabib_app/features/doctor_flow/chat/presentation/view_model/chat_list_view_model.dart';
import 'package:tabib_app/features/doctor_flow/chat/presentation/widgets/chat_item.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text('layout.navBar.messages'.tr(), style: theme.bold18),
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<DoctorChatListViewModel, ChatListState>(
        buildWhen: (previous, current) =>
            previous.consultationsState != current.consultationsState,
        builder: (context, state) {
          final consultationsState = state.consultationsState;
          if (consultationsState.isLoading || consultationsState.isInitial) {
            return const _ChatListLoadingWidget();
          }
          if (consultationsState.isError) {
            return _ChatListErrorWidget(
              message: consultationsState.errorMessage ?? '',
            );
          }
          final consultations = consultationsState.data ?? const [];
          if (consultations.isEmpty) {
            return const _ChatListEmptyWidget();
          }
          return _ChatListSuccessWidget(consultations: consultations);
        },
      ),
    );
  }
}

class _ChatListLoadingWidget extends StatelessWidget {
  const _ChatListLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: 6,
        itemBuilder: (_, index) => ChatItem(
          name: 'Doctor Name',
          lastMessage: 'Last message placeholder text',
          time: '09:25 AM',
          unreadCount: index == 0 ? 2 : 0,
          onTap: () {},
        ),
      ),
    );
  }
}

class _ChatListErrorWidget extends StatelessWidget {
  final String message;

  const _ChatListErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () =>
          context.read<DoctorChatListViewModel>().refreshConsultations(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: theme.regular14.copyWith(color: theme.textColor300),
                  ),
                  IconButton(
                    onPressed: () => context.read<DoctorChatListViewModel>().retry(),
                    icon: Icon(Icons.refresh, color: theme.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatListEmptyWidget extends StatelessWidget {
  const _ChatListEmptyWidget();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () =>
          context.read<DoctorChatListViewModel>().refreshConsultations(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 56,
                      color: theme.primaryColor.withValues(alpha: 0.7),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'chat.emptyTitle'.tr(),
                      textAlign: TextAlign.center,
                      style: theme.medium16.copyWith(color: theme.textColor600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'chat.emptySubtitle'.tr(),
                      textAlign: TextAlign.center,
                      style: theme.regular14.copyWith(color: theme.textColor300),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatListSuccessWidget extends StatelessWidget {
  final List<ConsultationEntity> consultations;

  const _ChatListSuccessWidget({required this.consultations});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;
    final locale = context.locale.toString();

    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () =>
          context.read<DoctorChatListViewModel>().refreshConsultations(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: consultations.length,
        itemBuilder: (context, index) {
          final consultation = consultations[index];
          final lastMessage = consultation.lastMessage;
          final timeSource = lastMessage?.createdAt.isNotEmpty == true
              ? lastMessage!.createdAt
              : consultation.updatedAt;
          final preview = _preview(lastMessage);

          return ChatItem(
            name: consultation.participant.localizedFullName(languageCode),
            lastMessage: preview,
            time: formatChatListTime(timeSource, locale: locale),
            imageUrl: consultation.participant.avatarUrl.isNotEmpty
                ? consultation.participant.avatarUrl
                : null,
            unreadCount: consultation.unreadCount,
            onTap: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.chatDetailsView,
                arguments: ChatDetailsArgs(
                  consultationId: consultation.id,
                  title: consultation.participant
                      .localizedFullName(languageCode),
                  avatarUrl: consultation.participant.avatarUrl,
                ),
              );
              if (!context.mounted) return;
              await context.read<DoctorChatListViewModel>().refreshConsultations();
            },
          );
        },
      ),
    );
  }

  String _preview(ConsultationLastMessageEntity? lastMessage) {
    if (lastMessage == null || lastMessage.content.trim().isEmpty) {
      return 'chat.noMessages'.tr();
    }
    if (lastMessage.isMine) {
      return '${'chat.you'.tr()}: ${lastMessage.content}';
    }
    return lastMessage.content;
  }
}
