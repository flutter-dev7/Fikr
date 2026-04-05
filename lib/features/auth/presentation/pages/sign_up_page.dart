import 'package:fikr/config/routes/app_routes.dart';
import 'package:fikr/features/auth/presentation/providers/auth_controller.dart';
import 'package:fikr/features/auth/presentation/widgets/my_button.dart';
import 'package:fikr/features/auth/presentation/widgets/my_text.dart';
import 'package:fikr/features/auth/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _signUp() async {
    await ref
        .read(authControllerProvider.notifier)
        .signUp(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          confirmPassword: confirmPasswordController.text.trim(),
        );

    if (!mounted) return;
    var state = ref.read(authControllerProvider);

    state.when(
      data: (data) {
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        );
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
                  title: "Общайтесь, делитесь, открывайте новое",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.primary,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // fullname textfield
                MyTextField(
                  hintText: "Полное Имя",
                  obscureText: false,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                ),

                const SizedBox(height: 10),

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

                // confirm textfield
                MyTextField(
                  hintText: "Подвердите Пароль",
                  obscureText: true,
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                ),

                const SizedBox(height: 20),

                // button
                MyButton(
                  onPressed: _signUp,
                  title: authState.isLoading
                      ? "Загрузка..."
                      : "Зарегистрироваться",
                ),

                const SizedBox(height: 20),

                // login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      title: "Уже есть аккаунт? ",
                      color: theme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: MyText(
                        title: "Войти",
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
