import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/platform/data_source/entities/message.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';

class StatusIndicator extends StatelessWidget {
  final MessageStatus status;
  final double size;

  const StatusIndicator({
    super.key,
    required this.status,
    this.size = AppDimens.iconSizeSmall,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case MessageStatus.sent:
        return Icon(
          Icons.check,
          size: size,
          color: AppColors.checkmarkGray,
        );

      case MessageStatus.delivered:
        return Icon(
          Icons.done_all,
          size: size,
          color: AppColors.checkmarkGray,
        );

      case MessageStatus.read:
        return Icon(
          Icons.done_all,
          size: size,
          color: AppColors.checkmarkBlue,
        );
    }
  }
}
