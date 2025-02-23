import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

/// Returns the global application theme with predefined colors, typography, and component styles.
ThemeData getApplicationTheme() {
  return ThemeData(
      // Main colors of the app
      primaryColor: ColorManager.black,
      primaryColorLight: ColorManager.blackOpacity70,
      primaryColorDark: ColorManager.black,
      disabledColor: ColorManager.grey1,
      scaffoldBackgroundColor: ColorManager.black,

      // Ripple effect color
      splashColor: ColorManager.blackOpacity70,

      // Hint color used for text fields
      hintColor: ColorManager.grey,

      // Card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),

      // AppBar theme configuration
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.black,
          elevation: AppSize.s4,
          shadowColor: ColorManager.blackOpacity70,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),

      // Button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.blue,
          splashColor: ColorManager.blueOpacity70),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              backgroundColor: ColorManager.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      // BottomSheet theme
      bottomSheetTheme: BottomSheetThemeData(
        surfaceTintColor: ColorManager.matteBlack,
        backgroundColor: ColorManager.matteBlack,
      ),

      // Text theme configuration
      textTheme: TextTheme(
          displayLarge: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16),
          displayMedium: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16),
          displaySmall:
              getBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
          headlineMedium: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s14),
          titleMedium: getMediumStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s14),
          titleSmall:
              getMediumStyle(color: ColorManager.black, fontSize: FontSize.s14),
          bodyMedium: getMediumStyle(color: ColorManager.lightGrey),
          bodySmall: getRegularStyle(color: ColorManager.grey1),
          bodyLarge: getRegularStyle(color: ColorManager.grey)),

      // Input decoration theme (TextFormField styling)
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),

        // Hint text style
        hintStyle:
            getRegularStyle(color: ColorManager.white.withValues(alpha: 0.2)),

        // Label text style
        labelStyle: getMediumStyle(color: ColorManager.white),

        // Error text style
        errorStyle: getRegularStyle(color: ColorManager.error),

        // Background fill for input fields
        filled: true,
        fillColor: ColorManager.white.withValues(alpha: 0.05),

        // Enabled border style (default)
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // Focused border style
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.blue, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // Error border style
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // Focused error border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
