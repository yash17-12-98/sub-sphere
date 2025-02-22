import 'package:flutter/material.dart';

class ColorManager {
  static Color black = HexColor.fromHex("#000000");
  static Color blackOpacity70 = HexColor.fromHex("#A6000000");
  static Color grey = HexColor.fromHex("#808080");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color blueOpacity70 = HexColor.fromHex("#6666FF");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");
  static Color pinkAccent = Colors.pinkAccent;
  static Color red = HexColor.fromHex("#FF6B6B");
  static Color teal = HexColor.fromHex("#4ECDC4");
  static Color yellow = HexColor.fromHex("#FFBE0B");
  static Color purple = HexColor.fromHex("#845EC2");
  static Color green = HexColor.fromHex("#00B8A9");
  static Color orange = HexColor.fromHex("#FF9671");
  static Color blue = HexColor.fromHex("#4B7BE5");
  static Color pink = HexColor.fromHex("#F15BB5");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
