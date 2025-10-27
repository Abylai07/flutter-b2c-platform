import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      dividerColor: AppColors.divider,
      brightness: Brightness.light,
      primaryColor: AppColors.main,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
        ),
        backgroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        // toolbarHeight: 87.h,
        toolbarTextStyle: TextStyle(
          fontSize: 16,
          height: 1.4,
          color: AppColors.mainBlue,
        ),
        titleTextStyle: TextStyle(
          fontSize: 18,
          height: 1.4,
          color: AppColors.mainBlue,
        ),
        iconTheme: IconThemeData(
          color: AppColors.mainBlue,
          size: 20,
        ),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        elevation: 24,
        color: AppColors.gray1,
        shape: CircularNotchedRectangle(),
      ),
      dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
      ),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: AppColors.white),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
      ),
      primaryTextTheme: const TextTheme(
        bodyMedium: TextStyle(height: 1.4),
      ).apply(
        fontFamily: 'SF-Pro-Display',
        displayColor: AppColors.black,
        bodyColor: AppColors.black,
        decorationColor: AppColors.black,
      ),
      unselectedWidgetColor: AppColors.gray,
      fontFamily: 'SF-Pro-Display',
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        foregroundColor: AppColors.main,
        padding: EdgeInsets.zero,
        minimumSize: const Size(30, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: const TextStyle(
            color: AppColors.main,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.2),
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.main,
              shape: const SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius.all(
                SmoothRadius(
                  cornerRadius: 12,
                  cornerSmoothing: 1,
                ),
              )),
              // RoundedRectangleBorder(borderRadius: CustomRadius.radius(12)),
              elevation: 0,
              minimumSize: const Size(double.infinity, 48),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 16, height: 1.2))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.main,
              shape: const SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius.all(
                SmoothRadius(
                  cornerRadius: 12,
                  cornerSmoothing: 1,
                ),
              )),
              elevation: 0,
              side: const BorderSide(color: AppColors.main, width: 1.2),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.2,
              ))),
      colorScheme: const ColorScheme.light(
          primary: AppColors.main, background: AppColors.white));
}
