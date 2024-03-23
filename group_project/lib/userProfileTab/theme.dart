import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    listTileTheme: const ListTileThemeData(iconColor: Colors.orange),
    colorScheme: ColorScheme.light(
        background: Colors.grey.shade100, secondary: Colors.red));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    listTileTheme:
        const ListTileThemeData(iconColor: Color.fromARGB(255, 188, 165, 231)),
    colorScheme: ColorScheme.dark(
        background: Colors.grey.shade900, secondary: Colors.green));
