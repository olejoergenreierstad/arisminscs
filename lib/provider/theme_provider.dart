import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  //ThemeMode themeMode = ThemeMode.system;
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.light;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static final lightTheme = ThemeData(
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 24),
        headline5: TextStyle(
            fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 12, color: Colors.black54),
      ),
      colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 0, 213, 252),
          onBackground: Colors.black54));
}
