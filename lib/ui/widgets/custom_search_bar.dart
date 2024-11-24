import 'package:book_store_app/core/providers/language_provider.dart';
import 'package:book_store_app/imports/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends ConsumerWidget {
  final TextEditingController controller;

  CustomSearchBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  Imports imports = Imports();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);
    return SizedBox(
      width: imports.constant.size.screenWidth * 0.91,
      height: imports.constant.size.screenHeight * 0.06,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: currentLanguage["search"]!,
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
          prefixIcon: SvgPicture.asset("assets/images/search.svg", fit: BoxFit.scaleDown,),
          suffixIcon: SvgPicture.asset("assets/images/settings.svg", fit: BoxFit.scaleDown,),
        ),
      ),
    );
  }
}
