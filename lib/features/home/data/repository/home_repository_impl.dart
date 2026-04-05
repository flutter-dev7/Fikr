import 'package:fikr/features/auth/domain/entities/user_entity.dart';
import 'package:fikr/features/home/data/datasources/home_remote_data_source.dart';
import 'package:fikr/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Stream<List<UserEntity>> getUsers() {
    return remote.getUsers().map(
      (list) => list.map((e) => e.toEntity()).toList(),
    );
  }
}
