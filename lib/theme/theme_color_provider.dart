import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multitheme_flutter/theme/theme_colors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeColorProvider {
  static final String _currentTheme = 'current_theme';
  static final String _themes = 'themes';
  static final ThemeColorProvider _application = ThemeColorProvider._internal();
  BehaviorSubject _subject = new BehaviorSubject<ThemeData>();

  factory ThemeColorProvider() {
    return _application;
  }

  ThemeColorProvider._internal();

  addThemes(Map<String, ThemeColors> theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> newThemes = new List();
    newThemes
        .addAll(prefs.getStringList(_themes) ?? List()); // add previous themes

    theme.forEach((themeName, themeColors) {
      newThemes.add(themeName);
      prefs.setString(themeName, json.encode(themeColors));
    });

    prefs.setStringList(_themes, newThemes);

    changeTheme(prefs.getString(_currentTheme) ?? null);
  }

  removeTheme(String themeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> allThemes = prefs.getStringList(_themes);
    if (allThemes.contains(themeName)) {
      prefs.remove(themeName);
      allThemes.remove(themeName);

      prefs.setStringList(_themes, allThemes);
    }
  }

  changeTheme(String themeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (themeName == null) {
      List<String> allThemes = prefs.getStringList(_themes);
      themeName = allThemes[0];
    }
    prefs.setString(_currentTheme, themeName);
    themeName = prefs.getString(_currentTheme);

    ThemeColors themeColors =
        ThemeColors.fromJson(json.decode(prefs.getString(themeName)));
    var themeData = ThemeData(
        primaryColor: Color(themeColors.primaryColor),
        primaryColorDark: Color(themeColors.primaryColorDark),
        accentColor: Color(themeColors.accentColor));

    _subject.add(themeData);
  }

  Stream getTheme() {
    return _subject.stream;
  }

  Future<Map<String, dynamic>> getThemeColors() async {
    var pref = await SharedPreferences.getInstance();
    var themeName = pref.getString(_currentTheme);

    return ThemeColors.fromJson(json.decode(pref.getString(themeName))).colors;
  }
}
