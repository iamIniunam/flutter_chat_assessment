import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_image_strings.dart';
import 'package:flutter_chat_assessment/ux/shared/components/home_app_bar.dart';
import 'package:flutter_chat_assessment/ux/shared/models/ui_models.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/chat_list_screen.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/components/user_stories_widget.dart';

class NavigationHostPage extends StatefulWidget {
  const NavigationHostPage({super.key});

  @override
  State<NavigationHostPage> createState() => _NavigationHostPageState();
}

class _NavigationHostPageState extends State<NavigationHostPage> {
  final List<StoryItem> userStories = [
    StoryItem(profileImageUrl: AppImageStrings.avatar1, label: 'John'),
    StoryItem(profileImageUrl: AppImageStrings.avatar2, label: 'Sheril'),
    StoryItem(profileImageUrl: AppImageStrings.avatar3, label: 'Mark'),
    StoryItem(profileImageUrl: AppImageStrings.avatar4, label: 'Aler'),
  ];

  List<Widget> get pages => [
        const ChatListScreen(),
        const Center(child: Text('Calls Page')),
        const Center(child: Text('Camera Page')),
        const Center(child: Text('Profile Page')),
      ];

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
                    ? UserStoriesWidget(userStories: userStories)
                    : null,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: selectedIndex == 0 ? 200 : 100,
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
    return Container(
      height: 63,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryGreen,
            AppColors.primaryGreen.withOpacity(0.8),
            AppColors.primaryGreen,
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
        children: List.generate(navBarIcons.length, (index) {
          final bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onTap(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  navBarIcons[index],
                  size: 28,
                  color: isSelected ? AppColors.white : AppColors.iconGray,
                ),
                if (isSelected)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
