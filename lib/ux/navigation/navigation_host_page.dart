import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';
import 'package:flutter_chat_assessment/ux/shared/components/blurred_bottom.dart';
import 'package:flutter_chat_assessment/ux/shared/components/home_app_bar.dart';
import 'package:flutter_chat_assessment/ux/shared/components/page_indicators.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_bloc.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_event.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_state.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/chat_list_screen.dart';
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
      const ChatListScreen(),
      const Center(child: Text('Calls Page')),
      const Center(child: Text('Camera Page')),
      const Center(child: Text('Profile Page')),
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
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: pages[selectedIndex],
              ),
            ),
            const SmoothBottomGradient(),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavBar(
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

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.navBarIcons,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<IconData> navBarIcons;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final int centerIndex = (navBarIcons.length / 2).floor();
    List<Widget> navItems = [];
    for (int i = 0; i < navBarIcons.length + 1; i++) {
      if (i == centerIndex) {
        navItems.add(
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(AppDimens.sizeExtraSmall),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.2),
                    blurRadius: AppDimens.paddingSmall,
                    spreadRadius: AppDimens.sizeExtraExtraSmall,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.add_rounded,
                    color: AppColors.primaryColor, size: 36),
              ),
            ),
          ),
        );
      }
      if (i < centerIndex) {
        final bool isSelected = selectedIndex == i;
        navItems.add(
          GestureDetector(
            onTap: () => onTap(i),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  navBarIcons[i],
                  size: AppDimens.sizeExtraLarge,
                  color: isSelected ? AppColors.white : AppColors.iconGray,
                ),
                if (isSelected)
                  Container(
                    width: AppDimens.sizeExtraSmall,
                    height: AppDimens.sizeExtraSmall,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        );
      } else if (i > centerIndex) {
        final int iconIndex = i - 1;
        final bool isSelected = selectedIndex == iconIndex;
        navItems.add(
          GestureDetector(
            onTap: () => onTap(iconIndex),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  navBarIcons[iconIndex],
                  size: AppDimens.sizeExtraLarge,
                  color: isSelected ? AppColors.white : AppColors.iconGray,
                ),
                if (isSelected)
                  Container(
                    width: AppDimens.sizeExtraSmall,
                    height: AppDimens.sizeExtraSmall,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        );
      }
    }
    return Container(
      height: 63,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor.withOpacity(0.9),
            AppColors.primaryGreen,
            AppColors.primaryGreen.withOpacity(0.9),
            AppColors.primaryGreen,
            AppColors.primaryColor.withOpacity(0.9),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(20),
            blurRadius: 20,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navItems,
      ),
    );
  }
}
