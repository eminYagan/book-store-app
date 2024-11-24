import 'package:book_store_app/core/services/api/product_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final booksProvider = FutureProvider.family<List<dynamic>, int>((ref, categoryId) async {
  ProductService productService = ProductService();
  return await productService.fetchProductsByCategoryId(categoryId);
});