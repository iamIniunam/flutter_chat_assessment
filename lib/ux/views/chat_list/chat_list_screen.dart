import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/platform/data_source/entities/chat.dart';
import 'package:flutter_chat_assessment/platform/data_source/entities/message.dart';
import 'package:flutter_chat_assessment/platform/data_source/entities/user.dart';
import 'package:flutter_chat_assessment/ux/resources/app_image_strings.dart';
import 'package:flutter_chat_assessment/ux/resources/app_theme.dart';
import 'package:flutter_chat_assessment/ux/shared/components/tab_item.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/components/chat_card.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  List<Chat> get mockChats => [
        Chat(
          id: '1',
          user: const User(
            id: '1',
            name: 'John Doe',
            avatarUrl: AppImageStrings.avatar1,
          ),
          lastMessage: 'Hey, how are you?',
          lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
          unreadCount: 2,
        ),
        Chat(
          id: '2',
          user: const User(
            id: '2',
            name: 'Jane Smith',
            avatarUrl: AppImageStrings.avatar2,
          ),
          lastMessage: 'Let\'s catch up tomorrow.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          unreadCount: 5,
        ),
        Chat(
          id: '2',
          user: const User(
            id: '2',
            name: 'Jane Smith',
            avatarUrl: AppImageStrings.avatar3,
          ),
          lastMessage: 'Let\'s catch up tomorrow.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          unreadCount: 0,
          messageStatus: MessageStatus.read,
        ),
        Chat(
          id: '2',
          user: const User(
            id: '2',
            name: 'Jane Smith',
            avatarUrl: AppImageStrings.avatar3,
          ),
          lastMessage: 'Let\'s catch up tomorrow.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          unreadCount: 0,
          messageStatus: MessageStatus.sent,
        ),
        Chat(
          id: '2',
          user: const User(
            id: '2',
            name: 'Jane Smith',
            avatarUrl: AppImageStrings.avatar3,
          ),
          lastMessage: 'Let\'s catch up tomorrow.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          unreadCount: 0,
        ),
        Chat(
          id: '2',
          user: const User(
            id: '2',
            name: 'Jane Smith',
            avatarUrl: AppImageStrings.avatar3,
          ),
          lastMessage: 'Let\'s catch up tomorrow.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          unreadCount: 0,
        ),
        Chat(
          id: '2',
          user: const User(
            id: '2',
            name: 'Jane Smith',
            avatarUrl: AppImageStrings.avatar3,
          ),
          lastMessage: 'Let\'s catch up tomorrow.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          unreadCount: 0,
        ),
        Chat(
          id: '2',
          user: const User(
            id: '2',
            name: 'Jane Smith',
            avatarUrl: AppImageStrings.avatar3,
          ),
          lastMessage: 'Let\'s catch up tomorrow.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          unreadCount: 0,
        ),
        Chat(
          id: '2',
          user: const User(
            id: '2',
            name: 'Jane Smith',
            avatarUrl: AppImageStrings.avatar3,
          ),
          lastMessage: 'Let\'s catch up tomorrow.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          unreadCount: 0,
        ),
        Chat(
          id: '2',
          user: const User(
            id: '2',
            name: 'Jane Smith',
            avatarUrl: AppImageStrings.avatar3,
          ),
          lastMessage: 'Let\'s catch up tomorrow.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          unreadCount: 0,
        ),
        Chat(
          id: '2',
          user: const User(
            id: '2',
            name: 'Jane Smith',
            avatarUrl: AppImageStrings.avatar3,
          ),
          lastMessage: 'Let\'s catch up tomorrow.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          unreadCount: 0,
        ),
        Chat(
          id: '2',
          user: const User(
            id: '2',
            name: 'Jane Smith',
            avatarUrl: AppImageStrings.avatar3,
          ),
          lastMessage: 'Let\'s catch up tomorrow.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          unreadCount: 0,
        ),
        Chat(
          id: '2',
          user: const User(
            id: '2',
            name: 'Jane Smith',
            avatarUrl: AppImageStrings.avatar3,
          ),
          lastMessage: 'Let\'s catch up tomorrow.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          unreadCount: 0,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                AppTheme.tabBar(
                  tabItems: [
                    const TabItem(title: 'Chats'),
                    const TabItem(title: 'Groups'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: mockChats.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox.shrink();
                        },
                        itemBuilder: (context, index) {
                          final chat = mockChats[index];
                          return ChatCard(
                            chat: chat,
                            onTap: () {
                              // Handle chat tap
                            },
                          );
                        },
                      ),
                      const Center(child: Text('Groups Content')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
