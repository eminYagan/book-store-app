import 'package:flutter_test/flutter_test.dart';
import 'package:book_store_app/core/services/api/product_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() {
  group("ProductService", () {

    //In service tests that require tokens, such as Like and Unlike,
    //it is necessary to give the token manually in order to perform these tests without connecting to the login tests.
    // Therefore, this token should be updated within the period.
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo0NDMsImVtYWlsIjoibWVobWV0QGhvdG1haWwuY29tIiwiaHR0cHM6Ly9oYXN1cmEuaW8vand0L2NsYWltcyI6eyJ4LWhhc3VyYS11c2VyLWlkIjoiNDQzIiwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoicHVibGljIiwieC1oYXN1cmEtYWxsb3dlZC1yb2xlcyI6WyJwdWJsaWMiLCJ1c2VyIl19LCJpYXQiOjE3MzIzOTg5OTgsImV4cCI6MTc1ODMxODk5OH0.Qn6CctY8p7q8q5EuY5gr18cUqVrLh0j88fNeS8h95sU";

    late ProductService productService;

    setUp(() {
      productService = ProductService();
    });


    test("Fetch categories successfully", () async {
      final categories = await productService.fetchCategories();
      expect(categories, isNotEmpty);
    });


    test("Fetch products by category ID successfully", () async {
      const int categoryId = 1;

      final products = await productService.fetchProductsByCategoryId(categoryId);

      expect(products.isNotEmpty, true, reason: "Products list should not be empty");
    });


    test("Fetch single product successfully", () async {
      const int categoryId = 1;
      const int productId = 3;

      final product = await productService.fetchProduct(categoryId, productId);

      expect(product, isNotNull);
    });


    test("should upload product cover image successfully", () async {

      String imageStr = "dune.png";

      final result = await productService.fetchProductCoverImage(imageStr);

      expect(result, true);
    });


    test("should like or unlike a product successfully", () async {

      //In order to extract the user_id from the token, it needs to be decoded.
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      var userId = decodedToken["user_id"];
      int productId = 3;

      // true means like, false means unlike!
      final result = await productService.likeorUnlikeProduct(true, userId, productId, token);

      expect(result, true);
    });
  });
}