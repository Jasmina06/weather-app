import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
  
  void toggleTheme(){
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

}
