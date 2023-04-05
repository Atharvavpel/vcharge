import 'package:flutter/material.dart';

class DarkThemeProvider with ChangeNotifier {

  var currentThemeMode = ThemeMode.light; 
  ThemeMode get themeMode => currentThemeMode;

  void setTheme(themeMode){
    currentThemeMode = themeMode;
    notifyListeners();
  }
}