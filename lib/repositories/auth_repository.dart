import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/providers/general_providers.dart';

abstract class BaseAuthRepository {
  Stream<User?> get getAuthStateChanges;
  Future<void> signIn();
  User? get getCurrentUser;
  Future<void> signOut();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(ref.read));

class AuthRepository implements BaseAuthRepository {
  final Reader _read;
  const AuthRepository(this._read);

  @override
  Stream<User?> get getAuthStateChanges => _read(firebaseAuthProvider).authStateChanges();

  @override
  User? get getCurrentUser => _read(firebaseAuthProvider).currentUser;

  @override
  Future<void> signIn() async => await _read(firebaseAuthProvider).signInAnonymously();

  @override
  Future<void> signOut() async => await _read(firebaseAuthProvider).signOut();
}
