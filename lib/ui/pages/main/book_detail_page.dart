import 'package:book_store_app/core/providers/language_provider.dart';
import 'package:book_store_app/core/services/api/product_service.dart';
import 'package:book_store_app/imports/imports.dart';
import 'package:book_store_app/ui/widgets/button.dart';
import 'package:book_store_app/ui/widgets/custom_app_bar.dart';
import 'package:book_store_app/ui/widgets/photo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDetailPage extends ConsumerWidget {
  var book;

  BookDetailPage({
    Key? key,
    required this.book,
  }) : super(key: key);

  Imports imports = Imports();
  ProductService productService = ProductService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(text: currentLanguage["bookdetails"]!, logo: false),
          Expanded(
            child: Column(
              children: [
                //BOOK PHOTO
                PhotoContainer(cover: book["cover"], width: 0.37, height: 0.21),

                //BOOK NAME
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    book["name"],
                    style: TextStyle(
                        color: Color(imports.constant.colors.mainTextColor),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                //AUTHOR
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    book["author"],
                    style: TextStyle(
                        color: Color(imports.constant.colors.mainTextColor),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                ),

                //SUMMARY
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    width: imports.constant.size.screenWidth * 0.91,
                    height: imports.constant.size.screenHeight * 0.33,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              currentLanguage["summary"]!,
                              style: TextStyle(
                                  color: Color(
                                      imports.constant.colors.mainTextColor),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              book["description"],
                              style: TextStyle(
                                color: Color(
                                    imports.constant.colors.mainTextColor),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Button(
                    text: "${double.parse(book["price"].toString())} \$",
                    secondtext: currentLanguage["byNow"]!,
                    textColor: imports.constant.colors.white,
                    backgroundColor: imports.constant.colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
