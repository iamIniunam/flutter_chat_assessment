import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/shared/components/avatar_shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';
import 'package:flutter_chat_assessment/ux/shared/components/page_indicators.dart';
import 'package:flutter_chat_assessment/ux/shared/components/story_item_widget.dart';
import 'package:flutter_chat_assessment/ux/shared/models/ui_models.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_bloc.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_state.dart';

class UserStoriesWidget extends StatelessWidget {
  const UserStoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.paddingLarge),
      child: SizedBox(
        height: AppDimens.storyItemWidgetHeight,
        child: Row(
          children: [
            StoryItemWidget(storyItem: StoryItem(label: 'Add'), isAdd: true),
            const SizedBox(width: AppDimens.paddingMedium),
            Expanded(
              child: BlocBuilder<ChatFeedBloc, ChatFeedState>(
                builder: (context, state) {
                  if (state is ChatFeedLoading) {
                    return const AvatarShimmer();
                  }
                  if (state is ChatFeedError) {
                    return const Align(
                      alignment: Alignment.centerLeft,
                      child: PageErrorIndicator(),
                    );
                  }
                  if (state is ChatFeedLoaded) {
                    final userStories = state.stories;
                    if (userStories.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: userStories.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: AppDimens.paddingMedium);
                      },
                      itemBuilder: (context, index) {
                        final story = userStories[index];
                        return StoryItemWidget(storyItem: story);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
