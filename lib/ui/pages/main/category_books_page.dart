import 'package:book_store_app/core/providers/product/book_by_categoryId_provider.dart';
import 'package:book_store_app/core/services/api/product_service.dart';
import 'package:book_store_app/imports/imports.dart';
import 'package:book_store_app/ui/pages/main/book_detail_page.dart';
import 'package:book_store_app/ui/widgets/custom_app_bar.dart';
import 'package:book_store_app/ui/widgets/custom_search_bar.dart';
import 'package:book_store_app/ui/widgets/photo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryBooksPage extends ConsumerWidget {
  final String name;
  final int id;

  CategoryBooksPage({
    Key? key,
    required this.name,
    required this.id,
  }) : super(key: key);

  Imports imports = Imports();
  ProductService productService = ProductService();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsyncValue = ref.watch(booksProvider(id));
    return Scaffold(
      backgroundColor: Color(imports.constant.colors.pageBackgroundColor),
      body: Column(
        children: [
          CustomAppBar(
            text: name,
            logo: false,
          ),

          //SEARCH BAR
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CustomSearchBar(
              controller: controller,
            ),
          ),

          //BOOKS
          Expanded(
            child: SingleChildScrollView(
              child: booksAsyncValue.when(
                data: (books) => SizedBox(
                  width: imports.constant.size.screenWidth * 0.91,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 17,
                          mainAxisSpacing: 15,
                          mainAxisExtent: 300,
                        ),
                        shrinkWrap: true,
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final book = books[index];
                          return InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BookDetailPage(book: book)),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(imports
                                      .constant.colors.loginRegisterTFFFillColor),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Column(
                                children: [

                                  //BOOK PHOTO
                                  PhotoContainer(cover: book["cover"], width: 0.4, height: 0.27),

                                  //BOOK INFORMATION
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: const Alignment(-1, -1),
                                            child: Text(
                                              book["name"],
                                              style: TextStyle(
                                                  color: Color(imports.constant
                                                      .colors.mainTextColor),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),

                                          Align(
                                            alignment: const Alignment(-1, 0.1),
                                            child: Text(
                                              book["author"],
                                              style: TextStyle(
                                                  color: Color(imports.constant
                                                      .colors.mainTextColor),
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),

                                          Align(
                                            alignment: const Alignment(1, 0.1),
                                            child: Text(
                                              "${double.parse(book["price"].toString())} \$",
                                              style: TextStyle(
                                                  color: Color(imports.constant
                                                      .colors.purple),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text('Error: $error')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
