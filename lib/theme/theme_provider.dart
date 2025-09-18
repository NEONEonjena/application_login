import 'package:flutter/material.dart';

// Esta clase maneja el estado del tema de la aplicación, permitiendo alternar entre modo claro y oscuro.
class ThemeProvider extends ChangeNotifier {
  // Indica si la aplicación está actualmente en modo oscuro
  bool _isDarkMode = false;
  
  // Obtiene el estado actual del modo oscuro
  bool get isDarkMode => _isDarkMode;

  // Obtiene el modo de tema actual basado en el estado del modo oscuro
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // Alternar el tema proporcionando un valor booleano
  // @param isDark Si se debe usar el modo oscuro (true) o el modo claro (false)
  void toggleTheme(bool isDark) {
    if (_isDarkMode != isDark) {
      _isDarkMode = isDark;
      notifyListeners();
    }
  }
}