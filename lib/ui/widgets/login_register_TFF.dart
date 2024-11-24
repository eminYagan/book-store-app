import 'package:book_store_app/core/providers/language_provider.dart';
import 'package:book_store_app/imports/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginRegisterTFF extends ConsumerWidget {
  final String text;
  final String hintText;
  final String kind;
  final TextEditingController controller;

  LoginRegisterTFF({
    Key? key,
    required this.controller,
    required this.text,
    required this.hintText,
    required this.kind,
  }) : super(key: key);

  Imports imports = Imports();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 7.5,
        ),
        SizedBox(
          width: imports.constant.size.screenWidth * 0.9,
          height: imports.constant.size.screenHeight * 0.06,
          child: TextFormField(
            controller: controller,
            obscureText: kind == "password" ? true : false,
            obscuringCharacter: "•",
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  color: Color(imports.constant.colors.mainTextColor),
                  fontSize: 16,
                  fontWeight: FontWeight.w200),
              filled: true,
              fillColor: Color(imports.constant.colors.loginRegisterTFFFillColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if(kind == "email"){
                if (value == null || value.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)){
                  return currentLanguage["validEmailError"];
                }
                return null;
              }else if(kind == "password"){
                if (value == null || value.isEmpty || value.length < 6 || value.length > 20) {
                  return currentLanguage["passwordLenghtError"];
                }
                if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+$')
                    .hasMatch(value)) {
                  return currentLanguage["passwordAlphanumericError"];
                }
                return null;
              }else{
                if (value == null || value.isEmpty) {
                  return currentLanguage["nameEmptyError"];
                }
                return null;
              }
              return null;
            },
          ),
        )
      ],
    );
  }
}
