import 'package:flutter/material.dart';
import 'package:group_project/config/app_theme.dart';
import 'package:group_project/ui/utils/local_storage_singleton.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = (KwunLocalStorage.getTheme("is_dark_theme"))
      ? AppTheme.darkTheme
      : AppTheme.lightTheme;

  ThemeData get themeData => _themeData;
  bool get isDarkTheme => _themeData == AppTheme.darkTheme;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (isDarkTheme) {
      _themeData = AppTheme.lightTheme;
    } else {
      _themeData = AppTheme.darkTheme;
    }

    notifyListeners();
  }
}
