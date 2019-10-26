import 'package:flutter/material.dart';

class ThemeColors {
  int primaryColor;
  int primaryColorDark;
  int accentColor;
  Map<String, dynamic> colors;

  ThemeColors(
      {@required this.primaryColor,
      @required this.primaryColorDark,
      @required this.accentColor,
      this.colors});

  ThemeColors.fromJson(Map<String, dynamic> json) {
    primaryColor = json["primaryColor"];
    primaryColorDark = json["primaryColorDark"];
    accentColor = json["accentColor"];
    colors = json['colors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primaryColor'] = this.primaryColor;
    data['primaryColorDark'] = this.primaryColorDark;
    data['accentColor'] = this.accentColor;
    data['colors'] = this.colors;
    return data;
  }
}
