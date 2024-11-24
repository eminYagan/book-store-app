import 'dart:convert';
import 'package:book_store_app/core/config/app_config.dart';
import 'package:http/http.dart' as http;

class AuthenticationService{
  final String baseUrl = AppConfig.baseUrl;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data.containsKey('action_login') && data['action_login'].containsKey('token')) {
        return {
          'token': data['action_login']['token'],
        };
      } else {
        throw Exception('Token not found in response');
      }
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }


  Future<Map<String, dynamic>> register(String email, String name, String password) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'name': name, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data.containsKey('action_register') && data['action_register'] != null) {
        final token = data['action_register']['token'];
        if (token != null) {
          return data;
        } else {
          throw Exception('Token not found in response');
        }
      } else {
        throw Exception('action_register not found in response');
      }
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

}