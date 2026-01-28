import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_assessment/ux/resources/app_strings.dart';
import 'package:flutter_chat_assessment/ux/resources/app_theme.dart';
import 'package:flutter_chat_assessment/ux/shared/components/empty_state.dart';
import 'package:flutter_chat_assessment/ux/shared/components/page_indicators.dart';
import 'package:flutter_chat_assessment/ux/shared/components/tab_item.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_bloc.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_event.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_state.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/components/chat_card.dart';

class ChatFeedPage extends StatefulWidget {
  const ChatFeedPage({super.key});

  @override
  State<ChatFeedPage> createState() => _ChatFeedPageState();
}

class _ChatFeedPageState extends State<ChatFeedPage> {
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
                    const TabItem(title: AppStrings.chats),
                    const TabItem(title: AppStrings.groups),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      BlocBuilder<ChatFeedBloc, ChatFeedState>(
                        builder: (context, state) {
                          if (state is ChatFeedLoading) {
                            return const PageLoadingIndicator();
                          }

                          if (state is ChatFeedError) {
                            return PageErrorIndicator(message: state.message);
                          }

                          if (state is ChatFeedLoaded) {
                            final chats = state.displayChats;

                            if (chats.isEmpty) {
                              return const EmptyPageIndicator(
                                  message: AppStrings.noChatsYet);
                            }

                            return RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<ChatFeedBloc>()
                                    .add(const RefreshChatFeed());
                              },
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: chats.length,
                                itemBuilder: (context, index) {
                                  final chat = chats[index];
                                  return ChatCard(
                                    chat: chat,
                                    onTap: () {},
                                  );
                                },
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const EmptyState(message: AppStrings.groupsContent),
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
