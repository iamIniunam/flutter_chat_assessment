import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_theme.dart';
import 'package:flutter_chat_assessment/ux/shared/components/tab_item.dart';

class ChatListScreenBody extends StatefulWidget {
  const ChatListScreenBody({super.key});

  @override
  State<ChatListScreenBody> createState() => _ChatListScreenBodyState();
}

class _ChatListScreenBodyState extends State<ChatListScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              AppTheme.tabBar(
                tabItems: const [
                  TabItem(title: 'Chats'),
                  TabItem(title: 'Groups'),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text('Chats Content')),
                    Center(child: Text('Groups Content')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
