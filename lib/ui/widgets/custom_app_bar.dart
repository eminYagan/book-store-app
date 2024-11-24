import 'package:book_store_app/imports/imports.dart';
import 'package:book_store_app/ui/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  final bool logo;

  CustomAppBar({
    Key? key,
    required this.text,
    required this.logo,
  }) : super(key: key);

  Imports imports = Imports();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imports.constant.size.screenWidth,
      height: imports.constant.size.screenHeight * 0.125,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(imports.constant.colors.loginRegisterTFFFillColor),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            logo
                ? Logo(
                    width: imports.constant.size.screenWidth * 0.125,
                    height: imports.constant.size.screenHeight * 0.036)
                : SvgPicture.asset("assets/images/arrow.svg"),
            Text(
              text,
              style: TextStyle(
                color: Color(imports.constant.colors.mainTextColor),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
