import 'dart:ui';
import 'package:book_store_app/imports/imports.dart';
import 'package:flutter/material.dart';

class Blur extends StatelessWidget {
  Blur({super.key});

  Imports imports = Imports();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: imports.constant.size.screenWidth,
            height: imports.constant.size.screenHeight,
            color: Colors.transparent,
          ),
        )),
        Center(
          child: CircularProgressIndicator(
            color: Color(
              imports.constant.colors.purple,
            ),
          ),
        ),
      ],
    );
  }
}
