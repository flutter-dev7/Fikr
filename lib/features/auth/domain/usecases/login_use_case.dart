import 'package:fikr/features/auth/domain/entities/user_entity.dart';
import 'package:fikr/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(String email, String password) {
    return repository.login(email: email, password: password);
  }
}
