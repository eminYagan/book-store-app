import 'package:book_store_app/core/services/api/product_service.dart';
import 'package:book_store_app/imports/imports.dart';
import 'package:book_store_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {

  var book;

  BookDetailPage({
    Key? key,
    required this.book,
  }) : super(key: key);

  Imports imports = Imports();
  ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(text: "bookdetails", logo: false),
          Expanded(
            child: Column(
              children: [

                //BOOK PHOTO
                FutureBuilder(
                  future: productService.fetchProductCoverImage(book["cover"]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: SizedBox(
                          width: imports.constant.size.screenWidth*0.37,
                          height: imports.constant.size.screenHeight*0.21,
                          child: Center(
                            child: CircularProgressIndicator(color: Color(imports.constant.colors.purple),),
                          ),
                        ),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Container(
                          width: imports.constant.size.screenWidth*0.37,
                          height: imports.constant.size.screenHeight*0.21,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(snapshot.data!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: SizedBox(
                          width: imports.constant.size.screenWidth*0.37,
                          height: imports.constant.size.screenHeight*0.21,
                        ),
                      );
                    }
                  },
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
