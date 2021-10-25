import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:places/repositories/auth_repositorie.dart';
import 'package:riverpod/riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, User?>(
  (ref) => AuthController(ref.read)..appStarted(),
);

class AuthController extends StateNotifier<User?> {
  final Reader read;

  StreamSubscription<User?>? authSubscription;

  AuthController(this.read) : super(null) {
    authSubscription?.cancel();
    authSubscription =
        read(authRepositoryProvider).getAuthStateChanges.listen((user) => state = user);
  }

  @override
  void dispose() {
    authSubscription!.cancel();
    super.dispose();
  }

  Future<void> appStarted() async {
    try {
      final user = read(authRepositoryProvider).getCurrentUser;

      user ?? read(authRepositoryProvider).signIn();
    } catch (e) {
      print(e);
    }
  }

  void signOut() {
    read(authRepositoryProvider).signOut();
  }
}
