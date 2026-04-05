import 'package:fikr/features/auth/presentation/pages/login_page.dart';
import 'package:fikr/features/auth/presentation/pages/reset_password_page.dart';
import 'package:fikr/features/auth/presentation/pages/sign_up_page.dart';
import 'package:fikr/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = "/login";
  static const String signUp = "/signUp";
  static const String resetPassword = "/resetPassword";
  static const String home = "/home";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: (context) => LoginPage());
      case "/signUp":
        return MaterialPageRoute(builder: (context) => SignUpPage());
      case "/resetPassword":
        return MaterialPageRoute(builder: (context) => ResetPasswordPage());
      case "/home":
        return MaterialPageRoute(builder: (context) => HomePage());
      default:
        return MaterialPageRoute(
          builder: (context) =>
              Scaffold(body: Center(child: Text('404 - Page not found'))),
        );
    }
  }
}
