import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';
import 'package:flutter_chat_assessment/ux/resources/app_images.dart';
import 'package:flutter_chat_assessment/ux/resources/app_strings.dart';
import 'package:flutter_chat_assessment/ux/resources/app_text_styles.dart';
import 'package:flutter_chat_assessment/ux/shared/components/story_item_widget.dart';
import 'package:flutter_chat_assessment/ux/shared/models/ui_models.dart';

class ChatListScreenAppBar extends StatelessWidget {
  const ChatListScreenAppBar({super.key, required this.userStories});

  final List<StoryItem> userStories;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, top: 40, bottom: 32),
      color: AppColors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppImages.svgWhatsappLogo,
              const SizedBox(width: AppDimens.paddingSmall),
              const Text(AppStrings.appName, style: AppTextStyles.appBarTitle),
            ],
          ),
          const SizedBox(height: AppDimens.paddingLarge),
          SizedBox(
            height: 87,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: userStories.length + 1,
              separatorBuilder: (context, index) {
                return const SizedBox(width: AppDimens.paddingMedium);
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return StoryItemWidget(
                    storyItem: StoryItem(label: 'Add'),
                    isAdd: true,
                  );
                } else {
                  final user = userStories[index - 1];
                  return StoryItemWidget(storyItem: user);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
