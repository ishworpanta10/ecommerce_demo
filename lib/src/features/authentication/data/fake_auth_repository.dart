import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/app_user.dart';

class FakeAuthRepository {
  Stream<AppUser?> authStateChanges() => Stream.value(null); // TODO: Update
  AppUser? get currentUser => null; // TODO: Update

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    // TODO: Implement
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    // TODO: Implement
  }

  Future<void> signOut() async {
    // TODO: Implement
  }
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  return FakeAuthRepository();
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
