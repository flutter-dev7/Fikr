import 'package:fikr/config/routes/app_routes.dart';
import 'package:fikr/features/auth/presentation/providers/auth_controller.dart';
import 'package:fikr/features/auth/presentation/widgets/my_button.dart';
import 'package:fikr/features/auth/presentation/widgets/my_text.dart';
import 'package:fikr/features/auth/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() async {
    await ref
        .read(authControllerProvider.notifier)
        .login(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

    var state = ref.watch(authControllerProvider);

    state.when(
      data: (data) {
        emailController.clear();
        passwordController.clear();
      },
      error: (error, stackTrace) => _showSnackbar(error.toString(), Colors.red),
      loading: () {},
    );
  }

  void _showSnackbar(String content, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content, style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final authState = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: theme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Image.asset("assets/icon/logo.png", height: 70),

                const SizedBox(height: 20),

                // welcome back message
                MyText(
                  title: "Добро пожаловать обратно!",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.primary,
                ),

                const SizedBox(height: 20),

                // email textfield
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  hintText: "Пароль",
                  obscureText: true,
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                ),

                const SizedBox(height: 10),

                // reset password
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.resetPassword);
                  },
                  child: Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: MyText(
                      title: "Забыли Пароль?",
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // login button
                MyButton(
                  onPressed: _login,
                  title: authState.isLoading ? "Загрузка..." : "Войти",
                ),

                const SizedBox(height: 20),

                // register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      title: "Нет аккаунта? ",
                      color: theme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.signUp);
                      },
                      child: MyText(
                        title: "Зарегистрироваться",
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
