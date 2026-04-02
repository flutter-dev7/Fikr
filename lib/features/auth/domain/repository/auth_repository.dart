import 'package:fikr/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserEntity> login({required String email, required String password});

  Future<void> resetPassword(String email);

  Future<void> signOut();

  Stream<UserEntity> getAuthState();
}
