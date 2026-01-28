import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';
import 'package:flutter_chat_assessment/ux/resources/app_text_styles.dart';
import 'package:flutter_chat_assessment/ux/shared/models/ui_models.dart';

class StoryItemWidget extends StatelessWidget {
  final bool isAdd;
  final VoidCallback? onTap;
  final StoryItem storyItem;

  const StoryItemWidget({
    super.key,
    required this.storyItem,
    this.isAdd = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = storyItem.avatarUrl;
    final AvatarType avatarType = isAdd ? AvatarType.add : AvatarType.image;

    Widget avatarWidget;
    switch (avatarType) {
      case AvatarType.add:
        avatarWidget = DottedBorder(
          color: AppColors.secondaryGreen,
          borderType: BorderType.Circle,
          padding: const EdgeInsets.all(AppDimens.paddingLarge),
          dashPattern: const [5, 3],
          strokeWidth: AppDimens.sizeExtraExtraSmall,
          child: const Icon(
            Icons.add_rounded,
            color: AppColors.secondaryGreen,
            size: AppDimens.sizeExtraLarge,
          ),
        );
        break;
      case AvatarType.image:
        avatarWidget = Container(
          padding: const EdgeInsets.all(AppDimens.storyAvatarPadding),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.secondaryGreen,
              width: AppDimens.sizeExtraExtraSmall,
            ),
            image: DecorationImage(
              image: NetworkImage(imageUrl ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        );
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          avatarWidget,
          const SizedBox(height: AppDimens.paddingSmall),
          Text(
            storyItem.label,
            style: AppTextStyles.storyName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
