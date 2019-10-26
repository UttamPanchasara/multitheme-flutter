import 'package:flutter/material.dart';
import 'package:multitheme_flutter/theme/multitheme.dart';
import 'package:multitheme_flutter/theme/theme_colors.dart';
import 'package:multitheme_flutter/theme/theme_color_provider.dart';
import 'package:multitheme_flutter/theme/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, ThemeColors> map = new Map();
    map[Themes.dark] = Themes.darkThemeColors();
    map[Themes.light] = Themes.lightThemeColors();

    return MultiTheme(
      themes: map,
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          theme: theme,
          home: MyHomePage(title: 'MultiTheme'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ThemeColorProvider().getThemeColors().asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> colors = snapshot.data;

          return Scaffold(
            backgroundColor: Color(colors[Themes.backgroundColor]),
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Center(
              child: Text(
                'Center Text',
                style: TextStyle(
                  color: Color(colors[Themes.titleColor]),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (isDark) {
                  ThemeColorProvider().changeTheme(Themes.light);
                } else {
                  ThemeColorProvider().changeTheme(Themes.dark);
                }
                isDark = !isDark;
              },
              child: Icon(Icons.change_history),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
        return Container();
      },
    );
  }
}
