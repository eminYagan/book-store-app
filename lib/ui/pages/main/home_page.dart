import 'package:book_store_app/core/providers/language_provider.dart';
import 'package:book_store_app/core/providers/product/book_by_categoryId_provider.dart';
import 'package:book_store_app/core/providers/product/category_provider.dart';
import 'package:book_store_app/core/services/api/product_service.dart';
import 'package:book_store_app/imports/imports.dart';
import 'package:book_store_app/ui/pages/main/book_detail_page.dart';
import 'package:book_store_app/ui/pages/main/category_books_page.dart';
import 'package:book_store_app/ui/widgets/custom_app_bar.dart';
import 'package:book_store_app/ui/widgets/custom_search_bar.dart';
import 'package:book_store_app/ui/widgets/photo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  Imports imports = Imports();

  ProductService productService = ProductService();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsyncValue = ref.watch(categoriesProvider);
    final currentLanguage = ref.watch(languageProvider);
    return Scaffold(
      backgroundColor: Color(imports.constant.colors.pageBackgroundColor),
      body: Column(
        children: [
          CustomAppBar(
            text: currentLanguage["catalog"]!,
            logo: true,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: imports.constant.size.screenWidth * 0.955,
              height: imports.constant.size.screenHeight * 0.054,
              child: categoriesAsyncValue.when(
                data: (categories) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          height: imports.constant.size.screenHeight * 0.054,
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          decoration: BoxDecoration(
                              color: Color(index == 0
                                  ? imports.constant.colors.purple
                                  : imports.constant.colors
                                      .loginRegisterTFFFillColor),
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                              child: Text(
                            category["name"],
                            style: TextStyle(
                                color: Color(index == 0
                                    ? imports.constant.colors.white
                                    : imports.constant.colors.mainTextColor),
                                fontSize: 16,
                                fontWeight: index == 0
                                    ? FontWeight.normal
                                    : FontWeight.w200),
                          )),
                        ),
                      );
                    },
                  );
                },
                loading: () => Center(
                    child: CircularProgressIndicator(
                  color: Color(imports.constant.colors.purple),
                )),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CustomSearchBar(
              controller: controller,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categoriesAsyncValue.when(
                  data: (data) {
                    return data
                        .map(
                          (item) => item["id"] != 0
                              ? categoryBooks(ref, item, context)
                              : Container(),
                        )
                        .toList();
                  },
                  loading: () => [
                    Center(
                      child: CircularProgressIndicator(
                        color: Color(imports.constant.colors.purple),
                      ),
                    ),
                  ],
                  error: (err, stack) => [
                    Center(
                      child: Text('Error: $err'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget categoryBooks(WidgetRef ref, var item, BuildContext context) {
    final booksAsyncValue = ref.watch(booksProvider(item["id"]));
    final currentLanguage = ref.watch(languageProvider);
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SizedBox(
          width: imports.constant.size.screenWidth * 0.955,
          height: imports.constant.size.screenHeight * 0.215,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: imports.constant.size.screenWidth * 0.91,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item["name"],
                      style: TextStyle(
                          color: Color(imports.constant.colors.mainTextColor),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryBooksPage(
                                      name: item["name"], id: item["id"])),
                            ),
                        child: Text(
                          currentLanguage["viewAll"]!,
                          style: TextStyle(
                              color: Color(imports.constant.colors.orange),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              booksAsyncValue.when(
                data: (books) => SizedBox(
                  height: imports.constant.size.screenHeight * 0.16,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return bookWidget(book, context);
                    },
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text('Error: $error')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bookWidget(var book, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailPage(book: book)),
        ),
        child: Container(
          width: imports.constant.size.screenWidth * 0.52,
          height: imports.constant.size.screenHeight * 0.16,
          color: Color(imports.constant.colors.loginRegisterTFFFillColor),
          child: Row(
            children: [
              //BOOK PHOTO
              PhotoContainer(cover: book["cover"], width: 0.206, height: 0.14),

              //BOOK INFORMATION
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: imports.constant.size.screenWidth * 0.25,
                        child: Text(
                          book["name"],
                          style: TextStyle(
                              color:
                                  Color(imports.constant.colors.mainTextColor),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: imports.constant.size.screenWidth * 0.25,
                        child: Text(
                          book["author"],
                          style: TextStyle(
                              color:
                                  Color(imports.constant.colors.mainTextColor),
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: imports.constant.size.screenWidth * 0.25,
                    child: Text(
                      "${double.parse(book["price"].toString())} \$",
                      style: TextStyle(
                          color: Color(imports.constant.colors.purple),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
