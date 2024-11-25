import 'package:book_store_app/core/services/api/product_service.dart';
import 'package:book_store_app/imports/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoContainer extends ConsumerWidget {
  final String cover;
  final double width;
  final double height;

  PhotoContainer({
    Key? key,
    required this.cover,
    required this.width,
    required this.height,
  }) : super(key: key);

  Imports imports = Imports();
  ProductService productService = ProductService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: productService.fetchProductCoverImage(cover),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: imports.constant.size.screenWidth * width,
            height: imports.constant.size.screenHeight * height,
            child: Center(
              child: CircularProgressIndicator(
                color: Color(imports.constant.colors.purple),
              ),
            ),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          return Container(
            width: imports.constant.size.screenWidth * width,
            height: imports.constant.size.screenHeight * height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(snapshot.data!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        } else {
          return SizedBox(
            width: imports.constant.size.screenWidth * width,
            height: imports.constant.size.screenHeight * height,
          );
        }
      },
    );
  }
}
