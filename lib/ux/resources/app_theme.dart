import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryGreen,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryGreen,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.whiteText),
        titleTextStyle: TextStyle(
          color: AppColors.whiteText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundLight,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.iconGray,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondaryGreen,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 0,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryGreen,
        secondary: AppColors.secondaryGreen,
      ),
    );
  }
}
