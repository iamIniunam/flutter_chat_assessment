import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';
import 'package:flutter_chat_assessment/ux/resources/app_dimens.dart';
import 'package:flutter_chat_assessment/ux/resources/app_strings.dart';
import 'package:flutter_chat_assessment/ux/resources/app_text_styles.dart';

class PageLoadingIndicator extends StatelessWidget {
  const PageLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          AppColors.primaryGreen,
        ),
      ),
    );
  }
}

class PageErrorIndicator extends StatelessWidget {
  const PageErrorIndicator({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: AppColors.secondaryText,
          ),
          const SizedBox(height: AppDimens.paddingLarge),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimens.paddingLarge),
            child: Text(
              message ?? AppStrings.somethingWentWrong,
              style: AppTextStyles.lastMessage,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyPageIndicator extends StatelessWidget {
  const EmptyPageIndicator({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: AppColors.secondaryText,
          ),
          const SizedBox(height: AppDimens.paddingLarge),
          Text(
            message ?? AppStrings.noContentAvailable,
            style: AppTextStyles.contactName.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
