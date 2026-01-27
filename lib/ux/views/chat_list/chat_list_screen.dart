import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_image_strings.dart';
import 'package:flutter_chat_assessment/ux/shared/models/ui_models.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/components/chat_list_screen_app_bar.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/components/chat_list_screen_body.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<StoryItem> userStories = [
    StoryItem(profileImageUrl: AppImageStrings.avatar1, label: 'John'),
    StoryItem(profileImageUrl: AppImageStrings.avatar2, label: 'Sheril'),
    StoryItem(profileImageUrl: AppImageStrings.avatar3, label: 'Mark'),
    StoryItem(profileImageUrl: AppImageStrings.avatar4, label: 'Aler'),
  ];
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.primaryGreen,
        body: Column(
          children: [
            ChatListScreenAppBar(userStories: userStories),
            const ChatListScreenBody(),
          ],
        ),
      ),
    );
  }
}
