import 'package:flutter_riverpod/flutter_riverpod.dart';

final visibilityProvider = StateNotifierProvider<AuthenticationNotifier, bool>((ref) => AuthenticationNotifier(),);

class AuthenticationNotifier extends StateNotifier<bool> {
  AuthenticationNotifier() : super(false);

  void toggleVisibility()=>state = !state;
}

