import 'package:flutter/material.dart';

// Esta clase provee un mecanismo simple para manejar cambios de idioma en la aplicación.
// Permite alternar entre diferentes idiomas y notificar los cambios.
class LanguageProvider extends ChangeNotifier {
  // el código de idioma actual 
  String _currentLanguage = 'es';
  
  //Obtener el lenguaje actual
  String get currentLanguage => _currentLanguage;

  // Verificar si el idioma actual es español
  bool get isSpanish => _currentLanguage == 'es';

  // Alternar el idioma proporcionando un código de idioma
  // @param language El código de idioma para cambiar ('es' o 'fr')
  void toggleLanguage(String language) {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      notifyListeners();
    }
  }
}