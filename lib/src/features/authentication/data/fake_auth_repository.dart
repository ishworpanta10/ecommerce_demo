import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/app_user.dart';

class FakeAuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);
  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  void _createNewUser(String email) {
    _authState.value = AppUser(uid: email.split('').reversed.join(), email: email);
  }

  Future<void> signOut() async {
    // await Future.delayed(const Duration(seconds: 3));
    // throw Exception('Connection Failed');

    _authState.value == null;
  }

  void dispose() => _authState.close();
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  final _auth = FakeAuthRepository();
  ref.onDispose(() => _auth.dispose());
  return _auth;
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
