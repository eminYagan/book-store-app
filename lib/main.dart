import 'package:book_store_app/core/providers/language_provider.dart';
import 'package:book_store_app/language/language_maps.dart';
import 'package:book_store_app/ui/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      locale: currentLanguage == trMap ? const Locale('tr') : const Locale('en'),
    );
  }
}

