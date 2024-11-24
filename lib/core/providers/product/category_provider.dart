import 'package:book_store_app/core/services/api/product_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = FutureProvider<List<dynamic>>((ref) async {
  ProductService productService = ProductService();
  return await productService.fetchCategories();
});
