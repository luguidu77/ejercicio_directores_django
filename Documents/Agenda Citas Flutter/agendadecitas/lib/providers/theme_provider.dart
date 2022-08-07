import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isLightMode => themeMode == ThemeMode.light;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
    textTheme: const TextTheme(
      // headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.pink), // const ColorScheme.light(),
    fontFamily: 'Hind',
    listTileTheme: const ListTileThemeData(textColor: Colors.pinkAccent),

    textTheme: const TextTheme(
      // headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(
          fontSize: 14.0, fontStyle: FontStyle.italic, color: Colors.red),
    ),
  );
}
