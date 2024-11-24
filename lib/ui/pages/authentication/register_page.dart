import 'package:book_store_app/core/providers/authentication_provider.dart';
import 'package:book_store_app/core/providers/language_provider.dart';
import 'package:book_store_app/core/services/api/authentication_service.dart';
import 'package:book_store_app/imports/imports.dart';
import 'package:book_store_app/ui/pages/authentication/login_page.dart';
import 'package:book_store_app/ui/widgets/blur.dart';
import 'package:book_store_app/ui/widgets/button.dart';
import 'package:book_store_app/ui/widgets/login_register_TFF.dart';
import 'package:book_store_app/ui/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerWidget {
  Imports imports = Imports();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController namelTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);
    final visibility = ref.watch(visibilityProvider);
    return Scaffold(
      backgroundColor: Color(imports.constant.colors.pageBackgroundColor),
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            //LOGO
            Align(
              alignment: const Alignment(0, -0.75),
              child: Logo(
                width: imports.constant.size.screenWidth * 0.26,
                height: imports.constant.size.screenHeight * 0.084,
              ),
            ),

            //TEXTS
            Align(
              alignment: const Alignment(0, -0.3),
              child: SizedBox(
                width: imports.constant.size.screenWidth * 0.9,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentLanguage["welcome"]!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      currentLanguage["registerAccount"]!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //NAME
            Align(
              alignment: const Alignment(0, 0.05),
              child: LoginRegisterTFF(
                controller: namelTEC,
                text: currentLanguage["name"]!,
                hintText: 'Jhon Doe',
                kind: "normal",
              ),
            ),

            //E-MAIL
            Align(
              alignment: const Alignment(0, 0.30),
              child: LoginRegisterTFF(
                controller: emailTEC,
                text: "E-mail",
                hintText: 'jhon@mail.com',
                kind: "email",
              ),
            ),

            //PASSWORD
            Align(
              alignment: const Alignment(0, 0.55),
              child: LoginRegisterTFF(
                controller: passwordTEC,
                text: currentLanguage["password"]!,
                hintText: currentLanguage["password"]!,
                kind: "password",
              ),
            ),

            //LOGIN
            Align(
              alignment: const Alignment(0, 0.68),
              child: SizedBox(
                width: imports.constant.size.screenWidth * 0.94,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      ),
                      child: Text(
                        currentLanguage["login"]!,
                        style: TextStyle(
                            color: Color(imports.constant.colors.purple),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //REGISTER
            Align(
              alignment: const Alignment(0, 0.9),
              child: InkWell(
                onTap: () => register(ref, context),
                child: Button(
                  text: currentLanguage["register"]!,
                  textColor: imports.constant.colors.white,
                  backgroundColor: imports.constant.colors.orange,
                ),
              ),
            ),

            Visibility(
              visible: visibility,
              child: Blur(),
            ),
          ],
        ),
      ),
    );
  }

  void register(WidgetRef ref, BuildContext context) async {
    ref.read(visibilityProvider.notifier).state = true;
    if (formKey.currentState!.validate()) {
      AuthenticationService authenticationService = AuthenticationService();
      await authenticationService.register(
        emailTEC.text.trim(),
        namelTEC.text.trim(),
        passwordTEC.text.trim(),
      );
      ref.read(visibilityProvider.notifier).state = false;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ref.read(visibilityProvider.notifier).state = false;
    }
  }
}
