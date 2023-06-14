import 'package:app_api_elancer/prefs/shared_pref_controller.dart';
import 'package:app_api_elancer/screens/auth/login_screen.dart';
import 'package:app_api_elancer/screens/auth/password/forget_password_screen.dart';
import 'package:app_api_elancer/screens/auth/password/reset_password_screen.dart';
import 'package:app_api_elancer/screens/auth/register_screen.dart';
import 'package:app_api_elancer/screens/categories_screen.dart';
import 'package:app_api_elancer/screens/launch_screen.dart';
import 'package:app_api_elancer/screens/users_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: '/launch_screen',

      routes: {
        '/users_screen' : (context) => const UsersScreen(),
        '/launch_screen' : (context) => const LaunchScreen(),
        '/login_screen' : (context) => const LoginScreen(),
        '/register_screen' : (context) => const RegisterScreen(),
        '/forget_password_screen' : (context) => const ForgetPasswordScreen(),
        // '/reset_password_screen' : (context) => const ResetPasswordScreen(),
        '/categories_screen' : (context) => const CategoriesScreen(),

      },
    );
  }
}