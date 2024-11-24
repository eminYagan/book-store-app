import 'package:book_store_app/core/providers/language_provider.dart';
import 'package:book_store_app/imports/imports.dart';
import 'package:book_store_app/ui/widgets/button.dart';
import 'package:book_store_app/ui/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {

  Imports imports = Imports();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);
    return Scaffold(
      backgroundColor: Color(imports.constant.colors.splashBackgroundColor),
      body: Stack(
        children: [
          //LOGO
          Align(
            alignment: const Alignment(0, -0.1),
            child: Logo(
                width: imports.constant.size.screenWidth*0.55,
                height: imports.constant.size.screenHeight*0.15,
            ),
          ),

          Align(
            alignment: const Alignment(0, 0.7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //LOGIN
                Button(text: currentLanguage["login"]!, textColor: 0XFFFFFFFF, backgroundColor: 0XFFEF6B4A),

                //SKIP
                Button(text: currentLanguage["skip"]!, textColor: 0XFF6251DD, backgroundColor: imports.constant.colors.splashBackgroundColor)
              ],
            ),
          )
        ],
      ),
    );
  }
}
