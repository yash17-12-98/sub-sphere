import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      primaryColor: ColorManager.black,
      primaryColorLight: ColorManager.blackOpacity70,
      primaryColorDark: ColorManager.black,
      disabledColor: ColorManager.grey1,
      scaffoldBackgroundColor: ColorManager.black,
      // ripple color
      splashColor: ColorManager.blackOpacity70,
      // will be used in case of disabled button
      hintColor: ColorManager.grey,
      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      // App bar theme
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

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              backgroundColor: ColorManager.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),
      bottomSheetTheme: BottomSheetThemeData(
        surfaceTintColor: ColorManager.matteBlack,
        backgroundColor: ColorManager.matteBlack,
      ),

      // Text theme
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
      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getRegularStyle(color: ColorManager.white.withValues(alpha: 0.2)),

        // label style
        labelStyle: getMediumStyle(color: ColorManager.white),
        // error style
        errorStyle: getRegularStyle(color: ColorManager.error),

        filled: true,
        fillColor: ColorManager.white.withValues(alpha: 0.05),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.blue, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
