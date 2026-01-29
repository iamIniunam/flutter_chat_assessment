import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
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
                child: Icon(
                  Icons.add_rounded,
                  color: AppColors.primaryColor,
                  size: AppDimens.centerButtonIconSize,
                ),
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
      height: AppDimens.bottomNavHeight,
      margin: const EdgeInsets.only(
        left: AppDimens.paddingLarge,
        right: AppDimens.paddingLarge,
        bottom: AppDimens.paddingLarge,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryGreen,
            AppColors.primaryGreen,
            AppColors.primaryGreen,
            AppColors.primaryColor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusXLarge),
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
