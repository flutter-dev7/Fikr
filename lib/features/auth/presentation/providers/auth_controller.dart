import 'package:fikr/config/errors/firebase_error.dart';
import 'package:fikr/features/auth/domain/usecases/login_use_case.dart';
import 'package:fikr/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:fikr/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:fikr/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:fikr/features/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthController extends StateNotifier<AsyncValue> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final SignOutUseCase signOutUseCase;
  final FirebaseError firebaseError;
  AuthController(
    this.signUpUseCase,
    this.loginUseCase,
    this.resetPasswordUseCase,
    this.signOutUseCase,
    this.firebaseError,
  ) : super(AsyncData(null));

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (name.trim().isEmpty) {
      state = AsyncError("Имя не может быть пустым", StackTrace.current);
      return;
    }

    if (name.length <= 1) {
      state = AsyncError(
        "Имя должно быть больше одного строка",
        StackTrace.current,
      );
      return;
    }

    if (email.trim().isEmpty) {
      state = AsyncError("Email не может быть пустым", StackTrace.current);
      return;
    }

    if (password.trim().isEmpty) {
      state = AsyncError("Пароль не может быть пустым", StackTrace.current);
      return;
    }

    if (confirmPassword.trim().isEmpty) {
      state = AsyncError("Подтвердите пароль", StackTrace.current);
      return;
    }

    if (password != confirmPassword) {
      state = AsyncError("Пароли не совпадают", StackTrace.current);
      return;
    }
    state = AsyncLoading();

    try {
      await signUpUseCase.call(name, email, password);
      state = AsyncData(null);
    } on FirebaseAuthException catch (e) {
      String exception = firebaseError.mapFirebaseError(e.code);
      state = AsyncError(exception, StackTrace.current);
    }
  }

  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty) {
      state = AsyncError("Email не может быть пустым", StackTrace.current);
      return;
    }
    if (password.trim().isEmpty) {
      state = AsyncError("Пароль не может быть пустым", StackTrace.current);
      return;
    }
    state = AsyncLoading();

    try {
      await loginUseCase.call(email, password);
      state = AsyncData(null);
    } on FirebaseAuthException catch (e) {
      String exception = firebaseError.mapFirebaseError(e.code);
      state = AsyncError(exception, StackTrace.current);
    }
  }

  Future<void> resetPassword(String email) async {
    if (email.trim().isEmpty) {
      state = AsyncError("Email не может быть пустым", StackTrace.current);
      return;
    }
    state = AsyncLoading();

    try {
      await resetPasswordUseCase.call(email);
      state = AsyncData(null);
    } on FirebaseAuthException catch (e) {
      String exception = firebaseError.mapFirebaseError(e.code);
      state = AsyncError(exception, StackTrace.current);
    }
  }

  Future<void> signOut() async {
    await signOutUseCase.call();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
      return AuthController(
        ref.read(signUpProvider),
        ref.read(loginProvider),
        ref.read(resetPasswordProvider),
        ref.read(signOutProvider),
        ref.read(firebaseErrorProvider),
      );
    });
