import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multitheme_flutter/theme/theme_color_provider.dart';
import 'package:multitheme_flutter/theme/theme_colors.dart';

typedef ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData data);

class MultiTheme extends StatefulWidget {
  final ThemedWidgetBuilder themedWidgetBuilder;
  final Map<String, ThemeColors> themes;

  const MultiTheme({this.themedWidgetBuilder, this.themes});

  @override
  _MultiThemeState createState() => _MultiThemeState();
}

class _MultiThemeState extends State<MultiTheme> {
  @override
  Widget build(BuildContext context) {
    ThemeColorProvider().addThemes(widget.themes);

    return StreamBuilder<ThemeData>(
      stream: ThemeColorProvider().getTheme(),
      builder: (context, snapshot) {
        return widget.themedWidgetBuilder(context, snapshot.data);
      },
    );
  }
}
