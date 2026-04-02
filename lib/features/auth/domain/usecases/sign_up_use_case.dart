import 'package:fikr/features/auth/domain/entities/user_entity.dart';
import 'package:fikr/features/auth/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<UserEntity> call(String name, String email, String password) {
    return repository.signUp(name: name, email: email, password: password);
  }
}
