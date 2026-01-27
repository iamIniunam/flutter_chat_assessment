import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_text_styles.dart';
import 'package:flutter_chat_assessment/ux/resources/app_theme.dart';
import 'package:flutter_chat_assessment/ux/shared/components/tab_item.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/bloc/chat_list_bloc.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/bloc/chat_list_event.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/bloc/chat_list_state.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/components/chat_card.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatListBloc>().add(const LoadChats());
  }

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
                      BlocBuilder<ChatListBloc, ChatListState>(
                        builder: (context, state) {
                          if (state is ChatListLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primaryGreen,
                                ),
                              ),
                            );
                          }

                          if (state is ChatListError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    size: 48,
                                    color: AppColors.secondaryText,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    state.message,
                                    style: AppTextStyles.lastMessage,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }

                          if (state is ChatListLoaded) {
                            final chats = state.displayChats;

                            if (chats.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.chat_bubble_outline,
                                      size: 64,
                                      color: AppColors.secondaryText,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No chats yet',
                                      style: AppTextStyles.contactName.copyWith(
                                        color: AppColors.secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<ChatListBloc>()
                                    .add(const RefreshChats());
                              },
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: chats.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox.shrink();
                                },
                                itemBuilder: (context, index) {
                                  final chat = chats[index];
                                  return ChatCard(
                                    chat: chat,
                                    onTap: () {
                                      // Handle chat tap
                                    },
                                  );
                                },
                              ),
                            );
                          }
                          return const SizedBox.shrink();
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
