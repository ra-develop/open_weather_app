import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/hex_to_color.dart';

class Palette {
  static Color primary = HexColor("#F31753"); //Color(0xFFF31753);
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.5),
    100: tintColor(color, 0.4),
    200: tintColor(color, 0.3),
    300: tintColor(color, 0.2),
    400: tintColor(color, 0.1),
    500: tintColor(color, 0),
    600: tintColor(color, -0.1),
    700: tintColor(color, -0.2),
    800: tintColor(color, -0.3),
    900: tintColor(color, -0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

// Generated using Material Design Palette/Theme Generator
// http://mcg.mbitson.com/
// https://github.com/mbitson/mcg
class McgPalette {
  static const MaterialColor mcgpalette0 =
      MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFFEE3EA),
    100: Color(0xFFFBB9CB),
    200: Color(0xFFF98BA9),
    300: Color(0xFFF75D87),
    400: Color(0xFFF53A6D),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFFF1144C),
    700: Color(0xFFEF1142),
    800: Color(0xFFED0D39),
    900: Color(0xFFEA0729),
  });
  static const int _mcgpalette0PrimaryValue = 0xFFF31753;

  static const MaterialColor mcgpalette0Accent =
      MaterialColor(_mcgpalette0AccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_mcgpalette0AccentValue),
    400: Color(0xFFFFADB6),
    700: Color(0xFFFF939F),
  });
  static const int _mcgpalette0AccentValue = 0xFFFFE0E3;
}
