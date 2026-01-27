import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Chat List Styles
  static TextStyle contactName = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  );

  static const TextStyle lastMessage = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
  );

  static const TextStyle timestamp = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.timestampText,
  );

  static const TextStyle unreadCount = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteText,
  );

  // Story Name Style
  static const TextStyle storyName = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.whiteText,
  );

  // Tab Bar Styles
  static const TextStyle activeTab = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteText,
  );

  static const TextStyle inactiveTab = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color(0xFFB3B3B3),
  );

  // App Bar Styles
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteText,
  );

  static const TextStyle appBarSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.whiteText,
  );

  // Message Styles
  static TextStyle messageText = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryText,
  );

  static const TextStyle messageTime = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: AppColors.timestampText,
  );
}
