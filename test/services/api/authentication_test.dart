import 'package:book_store_app/core/services/api/authentication_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationService', () {
    late AuthenticationService authenticationService;

    setUp(() {
      authenticationService = AuthenticationService();
    });

    const email = 'user@hotmail.com';
    const name = 'User';
    const password = '123456';

    test('Login success', () async {
      final result = await authenticationService.login(email, password);

      expect(result, isA<Map<String, dynamic>>());
      expect(result.containsKey('token'), true);
      expect(result['token'], isNotEmpty);
    });

    test('Register success', () async {
      final result = await authenticationService.register(email, name, password);

      expect(result.containsKey('action_register'), true);
      expect(result['action_register']['token'], isNotNull);
    });
  });

}
