import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/chat/presentation/widgets/chat_bubble.dart';

class ChatDetailsView extends StatelessWidget {
  const ChatDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'appointments.drName'.tr(),
          style: theme.bold18.copyWith(color: theme.textColor600),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.textColor600, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                ChatBubble(
                  message:
                      'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                  time: '09:25 AM',
                  isMe: false,
                ),
                ChatBubble(
                  message: 'Lorem ipsum is simply dummy text of the printing.',
                  time: '09:25 AM',
                  isMe: true,
                ),
                ChatBubble(
                  message:
                      'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
                  time: '09:25 AM',
                  isMe: false,
                ),
              ],
            ),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F7),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'chat.hint'.tr(),
                          hintStyle: theme.regular14.copyWith(
                            color: theme.textColor200,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.send, color: theme.primaryColor, size: 20),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.attach_file,
                      color: theme.textColor200,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
