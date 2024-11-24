import 'package:book_store_app/core/providers/authentication_provider.dart';
import 'package:book_store_app/core/providers/language_provider.dart';
import 'package:book_store_app/core/services/api/authentication_service.dart';
import 'package:book_store_app/imports/imports.dart';
import 'package:book_store_app/ui/pages/authentication/register_page.dart';
import 'package:book_store_app/ui/pages/main/home_page.dart';
import 'package:book_store_app/ui/widgets/blur.dart';
import 'package:book_store_app/ui/widgets/button.dart';
import 'package:book_store_app/ui/widgets/login_register_TFF.dart';
import 'package:book_store_app/ui/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  Imports imports = Imports();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  final checkboxProvider = StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);
    final isChecked = ref.watch(checkboxProvider);
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
                      currentLanguage["welcomeBack"]!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      currentLanguage["loginToAccount"]!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //E-MAIL
            Align(
              alignment: const Alignment(0, 0.05),
              child: LoginRegisterTFF(
                controller: emailTEC,
                text: "E-mail",
                hintText: 'jhon@mail.com',
                kind: "email",
              ),
            ),

            //PASSWORD
            Align(
              alignment: const Alignment(0, 0.3),
              child: LoginRegisterTFF(
                controller: passwordTEC,
                text: currentLanguage["password"]!,
                hintText: currentLanguage["password"]!,
                kind: "password",
              ),
            ),

            //REMEMBER ME - REGISTER
            Align(
              alignment: const Alignment(0, 0.43),
              child: SizedBox(
                width: imports.constant.size.screenWidth * 0.94,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: imports.constant.size.screenWidth * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              ref.read(checkboxProvider.notifier).state =
                                  value ?? false;
                            },
                            side: BorderSide(
                              color: Color(imports.constant.colors.purple),
                              width: 1.5,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          Text(
                            currentLanguage["rememberMe"]!,
                            style: TextStyle(
                              color: Color(imports.constant.colors.purple),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      ),
                      child: Text(
                        currentLanguage["register"]!,
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

            //LOGIN
            Align(
              alignment: const Alignment(0, 0.9),
              child: InkWell(
                onTap: () => login(ref, context),
                child: Button(
                  text: currentLanguage["login"]!,
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

  void login(WidgetRef ref, BuildContext context) async {
    ref.read(visibilityProvider.notifier).state = true;
    if (formKey.currentState!.validate()) {
      AuthenticationService authenticationService = AuthenticationService();
      await authenticationService.login(
        emailTEC.text.trim(),
        passwordTEC.text.trim(),
      );
      ref.read(visibilityProvider.notifier).state = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      ref.read(visibilityProvider.notifier).state = false;
    }
  }
}
