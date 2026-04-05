import 'package:fikr/features/auth/presentation/providers/auth_provider.dart';
import 'package:fikr/features/home/data/datasources/home_remote_data_source.dart';
import 'package:fikr/features/home/data/repository/home_repository_impl.dart';
import 'package:fikr/features/home/domain/repository/home_repository.dart';
import 'package:fikr/features/home/domain/usecases/get_user_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRemoteProvider = Provider<HomeRemoteDataSource>((ref) {
  return HomeRemoteDataSource(ref.read(firestoreProvider));
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(ref.read(homeRemoteProvider));
});

final getUserUseCaseProvider = Provider<GetUserUseCase>((ref) {
  return GetUserUseCase(ref.read(homeRepositoryProvider));
});

final getUsersProvider = StreamProvider((ref) {
  return ref.read(getUserUseCaseProvider).call();
});
