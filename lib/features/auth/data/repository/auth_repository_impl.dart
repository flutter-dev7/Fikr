import 'package:fikr/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fikr/features/auth/domain/entities/user_entity.dart';
import 'package:fikr/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final userModel = await remote.signUp(name, email, password);
    return userModel!.toEntity();
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final userModel = await remote.login(email, password);
    return userModel!.toEntity();
  }

  @override
  Future<void> resetPassword(String email) {
    return remote.resetPassword(email);
  }

  @override
  Stream<UserEntity> getAuthState() {
    return remote.authState().map((model) => model!.toEntity());
  }

  @override
  Future<void> signOut() {
    return remote.signOut();
  }
}
