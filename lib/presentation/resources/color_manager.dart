import 'package:flutter/material.dart';

/// This class defines a set of color constants used throughout the application.
/// It helps maintain a consistent color scheme and avoids hardcoding color values.
class ColorManager {
  static Color black = HexColor.fromHex("#000000"); // Pure black color
  static Color blackOpacity70 =
      HexColor.fromHex("#A6000000"); // Black with 70% opacity
  static Color grey = HexColor.fromHex("#808080"); // Standard grey color
  static Color grey1 = HexColor.fromHex("#707070"); // Slightly darker grey
  static Color grey2 = HexColor.fromHex("#797979"); // Another variation of grey
  static Color lightGrey = HexColor.fromHex("#9E9E9E"); // Light grey shade
  static Color darkGrey =
      HexColor.fromHex("#1C1C1E"); // Dark grey, almost black
  static Color blueOpacity70 =
      HexColor.fromHex("#6666FF"); // Blue with 70% opacity
  static Color white = HexColor.fromHex("#FFFFFF"); // Pure white
  static Color error = HexColor.fromHex("#e61f34"); // Error red color
  static Color pinkAccent = Colors.pinkAccent; // Predefined pink accent color
  static Color red = HexColor.fromHex("#FF6B6B"); // Soft red color
  static Color teal = HexColor.fromHex("#4ECDC4"); // Teal color
  static Color yellow = HexColor.fromHex("#FFBE0B"); // Bright yellow
  static Color purple = HexColor.fromHex("#845EC2"); // Purple shade
  static Color green = HexColor.fromHex("#00B8A9"); // Green shade
  static Color orange = HexColor.fromHex("#FF9671"); // Soft orange
  static Color blue = HexColor.fromHex("#4B7BE5"); // Standard blue
  static Color pink = HexColor.fromHex("#F15BB5"); // Soft pink
  static Color matteBlack = HexColor.fromHex("#28282B"); // Matte black color
}

/// This extension allows easy conversion of hex color codes to Flutter's Color class.
/// It ensures that hex strings are correctly interpreted as ARGB values.
extension HexColor on Color {
  /// Converts a hex color string (e.g., "#FFFFFF" or "FFFFFF") into a Color object.
  /// Automatically adds full opacity if the hex code is only 6 characters long.
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', ''); // Remove # if present
    if (hexColorString.length == 6) {
      hexColorString =
          "FF$hexColorString"; // Add full opacity (FF) if not provided
    }
    return Color(int.parse(hexColorString,
        radix: 16)); // Convert hex to int and create a Color
  }
}
