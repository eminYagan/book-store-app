import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:book_store_app/language/language_maps.dart';

final languageProvider = StateNotifierProvider<LanguageNotifier, Map<String, String>>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<Map<String, String>> {
  LanguageNotifier() : super(_getInitialLanguage());

  // Telefonun diline göre başlangıç dilini ayarlayın
  static Map<String, String> _getInitialLanguage() {
    final Locale deviceLocale = WidgetsBinding.instance.window.locale;
    if (deviceLocale.languageCode == 'tr') {
      return trMap;
    } else {
      return enMap;
    }
  }

  // Dili değiştir
  void setLanguage(Map<String, String> newLanguage) {
    state = newLanguage;
  }
}
