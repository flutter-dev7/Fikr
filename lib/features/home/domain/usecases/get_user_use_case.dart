import 'package:fikr/features/auth/domain/entities/user_entity.dart';
import 'package:fikr/features/home/domain/repository/home_repository.dart';

class GetUserUseCase {
  final HomeRepository repository;

  GetUserUseCase(this.repository);

  Stream<List<UserEntity>> call() {
    return repository.getUsers();
  }
}