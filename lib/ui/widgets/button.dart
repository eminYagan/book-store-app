import 'package:book_store_app/imports/imports.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final String text;
  final String? secondtext;
  final int textColor;
  final int backgroundColor;

  Button({
    Key? key,
    required this.text,
    this.secondtext,
    required this.textColor,
    required this.backgroundColor,
  }) : super(key: key);


  Imports imports =Imports();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imports.constant.size.screenWidth*0.85,
      height: imports.constant.size.screenHeight*0.063,
      decoration: BoxDecoration(
        color: Color(backgroundColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: secondtext == null ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
        children: [
          textWidget(text),

          secondtext != null
              ? textWidget(text)
              : Container(),
        ],
      ),
    );
  }

  Text textWidget(String textValue){
    return Text(
      textValue,
      style: TextStyle(
        color: Color(textColor),
        fontSize: 16,
        fontWeight: FontWeight.w600
      ),
    );
  }
}
