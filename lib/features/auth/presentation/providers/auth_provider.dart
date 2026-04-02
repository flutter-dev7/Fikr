import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fikr/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fikr/features/auth/data/repository/auth_repository_impl.dart';
import 'package:fikr/features/auth/domain/entities/user_entity.dart';
import 'package:fikr/features/auth/domain/repository/auth_repository.dart';
import 'package:fikr/features/auth/domain/usecases/login_use_case.dart';
import 'package:fikr/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:fikr/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:fikr/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(
    ref.read(firebaseAuthProvider),
    ref.read(firestoreProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider));
});

final signUpProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(ref.read(authRepositoryProvider));
});

final loginProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.read(authRepositoryProvider));
});

final resetPasswordProvider = Provider<ResetPasswordUseCase>((ref) {
  return ResetPasswordUseCase(ref.read(authRepositoryProvider));
});

final signOutProvider = Provider<SignOutUseCase>((ref) {
  return SignOutUseCase(ref.read(authRepositoryProvider));
});

final authStateProvider = StreamProvider<UserEntity?>((ref) {
  return ref.read(authRepositoryProvider).getAuthState();
});
