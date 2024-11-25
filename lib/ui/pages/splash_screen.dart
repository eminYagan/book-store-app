import 'package:book_store_app/core/providers/language_provider.dart';
import 'package:book_store_app/imports/imports.dart';
import 'package:book_store_app/ui/pages/authentication/login_page.dart';
import 'package:book_store_app/ui/pages/main/home_page.dart';
import 'package:book_store_app/ui/widgets/button.dart';
import 'package:book_store_app/ui/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  Imports imports = Imports();

  void navigate(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      //MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);

    Future.delayed(const Duration(seconds: 3), () {
      navigate(context);
    });

    return Scaffold(
      backgroundColor: Color(imports.constant.colors.splashBackgroundColor),
      body: Stack(
        children: [
          //LOGO
          Align(
            alignment: const Alignment(0, -0.1),
            child: Logo(
              width: imports.constant.size.screenWidth * 0.55,
              height: imports.constant.size.screenHeight * 0.15,
            ),
          ),

          Align(
            alignment: const Alignment(0, 0.7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //LOGIN
                InkWell(
                  onTap: () => navigate(context),
                  child: Button(
                      text: currentLanguage["login"]!,
                      textColor: imports.constant.colors.white,
                      backgroundColor: imports.constant.colors.orange),
                ),

                //SKIP
                InkWell(
                  onTap: () => navigate(context),
                  child: Button(
                    text: currentLanguage["skip"]!,
                    textColor: imports.constant.colors.purple,
                    backgroundColor:
                        imports.constant.colors.splashBackgroundColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
