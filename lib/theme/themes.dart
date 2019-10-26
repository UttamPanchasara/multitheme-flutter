import 'package:flutter/material.dart';
import 'package:multitheme_flutter/theme/theme_colors.dart';

class Themes {
  static final String dark = 'dark';
  static final String light = 'light';

  static final String titleColor = 'title_color';
  static final String backgroundColor = 'background_color';

  static ThemeColors darkThemeColors() {
    Map<String, dynamic> colors = new Map();
    colors[titleColor] = Colors.white.value;
    colors[backgroundColor] = Colors.black.value;

    return ThemeColors(
        primaryColor: Colors.black.value,
        primaryColorDark: Colors.black.value,
        accentColor: Colors.green.value,
        colors: colors);
  }

  static ThemeColors lightThemeColors() {
    Map<String, int> colors = new Map();
    colors[titleColor] = Colors.black.value;
    colors[backgroundColor] = Colors.white.value;

    return ThemeColors(
        primaryColor: Colors.white.value,
        primaryColorDark: Colors.white.value,
        accentColor: Colors.blue.value,
        colors: colors);
  }
}
