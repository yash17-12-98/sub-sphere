import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color,
    {double? letterSpacing}) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight);
}

/// Regular style
TextStyle getRegularStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? letterSpacing}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.regular, color,
      letterSpacing: letterSpacing);
}

/// Light text style
TextStyle getLightStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? letterSpacing}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.light, color,
      letterSpacing: letterSpacing);
}

/// Bold text style
TextStyle getBoldStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? letterSpacing}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.bold, color,
      letterSpacing: letterSpacing);
}

/// Semi bold text style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? letterSpacing}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.semiBold, color,
      letterSpacing: letterSpacing);
}

/// Medium text style
TextStyle getMediumStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    double? letterSpacing}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.medium, color,
      letterSpacing: letterSpacing);
}
