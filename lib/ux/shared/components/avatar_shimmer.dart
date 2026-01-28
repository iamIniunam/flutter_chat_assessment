import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';
import 'package:shimmer/shimmer.dart';

class AvatarShimmer extends StatelessWidget {
  const AvatarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: AppDimens.storyItemWidgetHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          separatorBuilder: (context, index) =>
              const SizedBox(width: AppDimens.paddingMedium),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseDark,
              highlightColor: AppColors.shimmerHighlightDark,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: AppDimens.avatarSizeMedium,
                    height: AppDimens.avatarSizeMedium,
                    decoration: const BoxDecoration(
                      color: AppColors.shimmerSurfaceDark,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: AppDimens.paddingSmall),
                  Container(
                    width: AppDimens.sizeXLarge,
                    height: AppDimens.sizeXSmall,
                    decoration: BoxDecoration(
                      color: AppColors.shimmerSurfaceDark,
                      borderRadius: BorderRadius.circular(AppDimens.sizeSmall),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
