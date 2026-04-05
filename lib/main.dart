import 'package:fikr/config/routes/app_routes.dart';
import 'package:fikr/config/themes/light_mode.dart';
import 'package:fikr/features/auth/presentation/pages/auth_gade.dart';
import 'package:fikr/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGade(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: lightMode,
      // darkTheme: darkMode,
    );
  }
}
