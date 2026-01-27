import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';
import 'package:flutter_chat_assessment/ux/resources/app_text_styles.dart';
import 'package:flutter_chat_assessment/ux/shared/models/ui_models.dart';

enum AvatarType { add, image }

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
    final String? imageUrl = storyItem.profileImageUrl;
    final AvatarType avatarType = isAdd ? AvatarType.add : AvatarType.image;

    Widget avatarWidget;
    switch (avatarType) {
      case AvatarType.add:
        avatarWidget = DottedBorder(
          color: AppColors.secondaryGreen,
          borderType: BorderType.Circle,
          padding: const EdgeInsets.all(15),
          dashPattern: const [5, 3],
          strokeWidth: 2,
          child: const Icon(
            Icons.add,
            color: AppColors.secondaryGreen,
            size: 32,
          ),
        );
        break;
      case AvatarType.image:
        avatarWidget = Container(
          width: AppDimens.storyAvatarSize,
          height: AppDimens.storyAvatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.secondaryGreen, width: 2),
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
