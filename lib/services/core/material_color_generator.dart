import 'dart:math';

import 'package:flutter/material.dart';

/*
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
*/

// Generated using Material Design Palette/Theme Generator
// http://mcg.mbitson.com/
// https://github.com/mbitson/mcg
class McgPalette {
  // static final MaterialColor colorPalette =
  //     MaterialColor(_mcgPalettePrimaryValue, <int, Color>{
  //   50: const Color(0xFFFEE3EA),
  //   100: const Color(0xFFFBB9CB),
  //   200: const Color(0xFFF98BA9),
  //   300: const Color(0xFFF75D87),
  //   400: const Color(0xFFF53A6D),
  //   500: Color(_mcgPalettePrimaryValue),
  //   600: const Color(0xFFF1144C),
  //   700: const Color(0xFFEF1142),
  //   800: const Color(0xFFED0D39),
  //   900: const Color(0xFFEA0729),
  // });

  // static const MaterialColor colorAccent =
  //     MaterialColor(_mcgPaletteAccentValue, <int, Color>{
  //   100: Color(0xFFFFFFFF),
  //   200: Color(_mcgPaletteAccentValue),
  //   400: Color(0xFFFFADB6),
  //   700: Color(0xFFFF939F),
  // });

  // static const int _mcgPaletteAccentValue = 0xFFFFE0E3;

  static final MaterialColor colorPalette = _generateMaterialColor(primary);

  static final int _mcgPalettePrimaryValue = Colors.blue.value; //0xFFF31753;

  static final Color primary = Color(_mcgPalettePrimaryValue);

  static int _tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color _tintColor(Color color, double factor) => Color.fromRGBO(
      _tintValue(color.red, factor),
      _tintValue(color.green, factor),
      _tintValue(color.blue, factor),
      1);

  static MaterialColor _generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: _tintColor(color, 0.5),
      100: _tintColor(color, 0.4),
      200: _tintColor(color, 0.3),
      300: _tintColor(color, 0.2),
      400: _tintColor(color, 0.1),
      500: _tintColor(color, 0),
      600: _tintColor(color, -0.1),
      700: _tintColor(color, -0.2),
      800: _tintColor(color, -0.3),
      900: _tintColor(color, -0.4),
    });
  }
}
