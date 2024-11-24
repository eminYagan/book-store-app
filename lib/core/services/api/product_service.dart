import 'dart:convert';
import 'package:book_store_app/core/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductService {

  final String baseUrl = AppConfig.baseUrl;

  Future<List<dynamic>> fetchCategories() async {
    try{
      final response = await http.get(Uri.parse('$baseUrl/categories'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        if (decodedResponse is Map<String, dynamic> && decodedResponse.containsKey('category')) {
          return decodedResponse['category'] as List<dynamic>;
        } else {
          throw Exception('Unexpected response format: $decodedResponse');
        }
      } else {
        throw Exception('Failed to fetch categories');
      }
    }catch(e){
      debugPrint('Error in fetchCategories: $e');
      throw Exception('Failed to fetch categories.');
    }
  }


  Future<List<dynamic>> fetchProductsByCategoryId(int categoryId) async {
    try {
      final url = Uri.parse('$baseUrl/products/$categoryId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('product') && data['product'] is List) {
          return data['product'];
        } else {
          throw Exception('Unexpected response format: $data');
        }
      } else {
        throw Exception('Failed to fetch products for category $categoryId: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in fetchProductsByCategoryId: $e');
      throw Exception('Failed to fetch products by category id.');
    }
  }


  Future<Map<String, dynamic>> fetchProduct(int categoryId, int productId) async {
    try {
      final url = Uri.parse('$baseUrl/products/$categoryId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('product') && data['product'] is List) {
          final product = data['product'].firstWhere(
                (item) => item['id'] == productId,
            orElse: () => null,
          );
          return product;
        } else {
          throw Exception('Unexpected response format: $data');
        }
      } else {
        throw Exception('Failed to fetch products for category $productId: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in fetchProduct: $e');
      throw Exception('Failed to fetch product.');
    }
  }


  Future<bool> fetchProductCoverImage(String fileName) async {
    try {
      final url = Uri.parse('$baseUrl/cover_image');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({'fileName': fileName});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        debugPrint('Cover image uploaded successfully!');
        return true;
      } else {
        debugPrint('Failed to upload cover image. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Error in fetchProductCoverImage: $e');
      return false;
    }
  }


  Future<bool> likeorUnlikeProduct(bool like, int userId, int productId, String token) async {
    try{
      final url = Uri.parse('$baseUrl/${like ? "like" : "unlike"}');

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      final body = json.encode({
        'user_id': userId,
        'product_id': productId,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400 && response.body.contains('duplicate key value')) {
        print('This product is already liked.');
        return false;
      } else {
        return false;
      }
    }catch(e){
      debugPrint('Error in likeProduct: $e');
      return false;
    }
  }

}