import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/platform/data_source/entities/chat.dart';
import 'package:flutter_chat_assessment/ux/shared/components/date_formatter.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';
import 'package:flutter_chat_assessment/ux/resources/app_text_styles.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/components/status_indicator.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.chat,
    required this.onTap,
    this.onLongPress,
  });

  final Chat chat;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingLarge,
          vertical: AppDimens.paddingMedium,
        ),
        child: Row(
          children: [
            Container(
              width: AppDimens.avatarSizeLarge,
              height: AppDimens.avatarSizeLarge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.secondaryGreen,
                  width: AppDimens.sizeExtraExtraSmall,
                ),
                image: DecorationImage(
                  image: NetworkImage(chat.user.avatarUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: AppDimens.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    chat.user.name,
                    style: AppTextStyles.contactName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDimens.paddingXSmall),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          style: AppTextStyles.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormatter.formatChatTimestamp(chat.lastMessageTime),
                  style: AppTextStyles.timestamp,
                ),
                const SizedBox(height: AppDimens.paddingSmall),
                if (chat.unreadCount == 0)
                  StatusIndicator(
                    status: chat.messageStatus,
                    size: AppDimens.iconSizeSmall,
                  ),
                if (chat.unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.sizeExtraSmall,
                      vertical: AppDimens.sizeExtraExtraSmall,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.unreadIndicator,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: AppDimens.unreadBadgeSize,
                      minHeight: AppDimens.unreadBadgeSize,
                    ),
                    child: Center(
                      child: Text(
                        chat.unreadCount.toString(),
                        style: AppTextStyles.unreadCount,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
