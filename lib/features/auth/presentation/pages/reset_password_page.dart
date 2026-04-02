import 'package:fikr/features/auth/presentation/providers/auth_controller.dart';
import 'package:fikr/features/auth/presentation/widgets/my_button.dart';
import 'package:fikr/features/auth/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  TextEditingController emailController = TextEditingController();

  void resetPassword() async {
    await ref
        .read(authControllerProvider.notifier)
        .resetPassword(emailController.text.trim());

    var state = ref.watch(authControllerProvider);

    state.when(
      data: (data) {
        emailController.clear();
        showSnackbar(
          "Проверьте ваш email и следуйте инструкциям",
          Colors.green,
        );
      },
      error: (error, stackTrace) => showSnackbar(error.toString(), Colors.red),
      loading: () {},
    );
  }

  void showSnackbar(String content, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content, style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showInstructions() {
    final theme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // small indicator
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 20),

              // icon
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: theme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.lock_reset, color: theme.primary, size: 28),
              ),

              const SizedBox(height: 16),

              // heading
              Text(
                "Восстановление пароля",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.onSurface,
                ),
              ),

              const SizedBox(height: 10),

              // description
              Text(
                "Мы поможем вам вернуть доступ к аккаунту всего за пару шагов.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.onSurface.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 20),

              // steps
              _buildStep(Icons.email_outlined, "Введите ваш email"),
              _buildStep(Icons.send, "Нажмите «Отправить ссылку»"),
              _buildStep(
                Icons.mark_email_read_outlined,
                "Перейдите по ссылке из письма",
              ),

              const SizedBox(height: 16),

              // clue
              Row(
                children: [
                  Icon(Icons.info_outline, size: 18, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "Не забудьте проверить папку «Спам»",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Понятно",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStep(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 22, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final authState = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: showInstructions,
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // reset password message
              Text(
                "Сброс Пароля",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Text(
                "Введите email, чтобы получить ссылку для восстановления",
                style: TextStyle(fontSize: 16, color: theme.primary),
              ),

              const SizedBox(height: 20),

              // email textfield
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              Spacer(),

              // button
              MyButton(
                onPressed: resetPassword,
                title: authState.isLoading ? "Загрузка..." : "Отправить ссылку",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
