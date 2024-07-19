import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _lightTheme = FlexThemeData.light(scheme: FlexScheme.deepPurple);
  ThemeData _darkTheme = FlexThemeData.dark(scheme: FlexScheme.green);

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;

  void setTheme(FlexScheme lightScheme, FlexScheme darkScheme) {
    _lightTheme = FlexThemeData.light(scheme: lightScheme);
    _darkTheme = FlexThemeData.dark(scheme: darkScheme);
    notifyListeners();
  }
}
