import 'package:fikr/features/auth/domain/entities/user_entity.dart';

abstract class HomeRepository {
  Stream<List<UserEntity>> getUsers();
}
