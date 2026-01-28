import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';
import 'package:flutter_chat_assessment/ux/resources/app_images.dart';
import 'package:flutter_chat_assessment/ux/resources/app_strings.dart';
import 'package:flutter_chat_assessment/ux/resources/app_text_styles.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, this.widget});

  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, top: 40, bottom: 35),
      color: AppColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppImages.svgWhatsappLogo,
              const SizedBox(width: AppDimens.paddingSmall),
              const Text(AppStrings.appName, style: AppTextStyles.appBarTitle),
            ],
          ),
          widget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
