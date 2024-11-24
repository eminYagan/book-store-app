import 'package:book_store_app/core/model/product/book.dart';
import 'package:book_store_app/core/model/product/category.dart';
import 'package:book_store_app/core/services/api/product_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isInitializedProvider = StateProvider<bool>((ref) => false);

// Book listesi için bir StateNotifierProvider
final bookListProvider = StateNotifierProvider<BookListNotifier, List<Book>>(
      (ref) => BookListNotifier(),
);

// Category listesi için bir StateNotifierProvider
final categoryListProvider = StateNotifierProvider<CategoryListNotifier, List<Category>>(
      (ref) => CategoryListNotifier(),
);

// Book List Notifier
class BookListNotifier extends StateNotifier<List<Book>> {
  BookListNotifier() : super([]);

  void addBooks(List<Book> books) {
    state = [...state, ...books];
  }
}

// Category List Notifier
class CategoryListNotifier extends StateNotifier<List<Category>> {
  CategoryListNotifier() : super([]);

  void setCategories(List<Category> categories) {
    state = categories;
  }
}

// API çağrılarını yönetmek için bir FutureProvider
final initializeDataProvider = FutureProvider<void>((ref) async {
  final isInitialized = ref.read(isInitializedProvider);

  if (!isInitialized) {
    ProductService productService = ProductService();
    // 1. Kategorileri çek
    final categoriesResponse = await productService.fetchCategories();
    final categories = categoriesResponse.map((json) => Category.fromJson(json)).toList();

    // Kategorileri güncelle
    ref.read(categoryListProvider.notifier).setCategories(categories);

    // 2. Her kategori için kitapları çek
    for (final category in categories) {
      final booksResponse = await productService.fetchProductsByCategoryId(category.id);

      // Kitapları Book nesnelerine dönüştür ve categoryId'yi ata
      final books = booksResponse.map((json) {
        final book = Book.fromJson(json);
        return book.copyWith(categoryId: category.id); // categoryId'yi ata
      }).toList();

      // Kitapları güncelle
      ref.read(bookListProvider.notifier).addBooks(books);
    }

    // isInitialized değerini true yap
    ref.read(isInitializedProvider.notifier).state = true;
  }
});