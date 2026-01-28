import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';
import 'package:flutter_chat_assessment/ux/resources/app_strings.dart';
import 'package:flutter_chat_assessment/ux/shared/components/app_bottom_nav.dart';
import 'package:flutter_chat_assessment/ux/shared/components/blurred_bottom.dart';
import 'package:flutter_chat_assessment/ux/shared/components/empty_state.dart';
import 'package:flutter_chat_assessment/ux/shared/components/home_app_bar.dart';
import 'package:flutter_chat_assessment/ux/shared/components/page_indicators.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_bloc.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_event.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_state.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/chat_feed_page.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/components/user_stories_widget.dart';

class NavigationHostPage extends StatefulWidget {
  const NavigationHostPage({super.key});

  @override
  State<NavigationHostPage> createState() => _NavigationHostPageState();
}

class _NavigationHostPageState extends State<NavigationHostPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChatFeedBloc>().add(const LoadChatFeed());
  }

  List<Widget> get pages {
    return [
      const ChatFeedPage(),
      const EmptyState(message: AppStrings.callsPage),
      const EmptyState(message: AppStrings.cameraPage),
      const EmptyState(message: AppStrings.profilePage),
    ];
  }

  List<IconData> navBarIcons = [
    Icons.home_rounded,
    Icons.call_rounded,
    Icons.camera_alt_rounded,
    Icons.person_rounded,
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: HomeAppBar(
                widget: selectedIndex == 0
                    ? BlocBuilder<ChatFeedBloc, ChatFeedState>(
                        builder: (context, state) {
                        if (state is ChatFeedLoading) {
                          return const PageLoadingIndicator();
                        }

                        if (state is ChatFeedError) {
                          return const PageErrorIndicator();
                        }

                        if (state is ChatFeedLoaded) {
                          final userStories = state.stories;

                          if (userStories.isEmpty) {
                            return const PageErrorIndicator(
                                message: 'No stories available');
                          }

                          return UserStoriesWidget(userStories: userStories);
                        }
                        return const SizedBox.shrink();
                      })
                    : null,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: selectedIndex == 0
                  ? AppDimens.sizeXXLarge
                  : AppDimens.storySectionHeight,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimens.sizeXLarge),
                    topRight: Radius.circular(AppDimens.sizeXLarge),
                  ),
                ),
                child: pages[selectedIndex],
              ),
            ),
            const SmoothBottomGradient(),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppBottomNav(
                navBarIcons: navBarIcons,
                selectedIndex: selectedIndex,
                onTap: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
