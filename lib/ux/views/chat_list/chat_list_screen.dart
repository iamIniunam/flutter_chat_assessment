import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_theme.dart';
import 'package:flutter_chat_assessment/ux/shared/components/tab_item.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/components/chat_list_screen_body.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

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
                const Expanded(
                  child: TabBarView(
                    children: [
                      ChatList(),
                      Center(child: Text('Groups Content')),
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
