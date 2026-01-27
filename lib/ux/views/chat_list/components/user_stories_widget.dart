import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';
import 'package:flutter_chat_assessment/ux/shared/components/story_item_widget.dart';
import 'package:flutter_chat_assessment/ux/shared/models/ui_models.dart';

class UserStoriesWidget extends StatelessWidget {
  const UserStoriesWidget({
    super.key,
    required this.userStories,
  });

  final List<StoryItem> userStories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.paddingLarge),
      child: SizedBox(
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
    );
  }
}
