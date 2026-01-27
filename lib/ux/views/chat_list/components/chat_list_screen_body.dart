import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_text_styles.dart';

class ChatListScreenBody extends StatefulWidget {
  const ChatListScreenBody({super.key});

  @override
  State<ChatListScreenBody> createState() => _ChatListScreenBodyState();
}

class _ChatListScreenBodyState extends State<ChatListScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
              Container(
                height: 34,
                margin: const EdgeInsets.only(
                    left: 16, top: 24, right: 16, bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider, width: 2),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: AppColors.primaryGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelStyle: AppTextStyles.activeTab,
                  unselectedLabelStyle: AppTextStyles.inactiveTab,
                  tabs: const [
                    Tab(text: 'Chats'),
                    Tab(text: 'Groups'),
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
