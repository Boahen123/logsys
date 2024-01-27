import 'package:get/get.dart';
import 'package:logsys/views/home/home_screen.dart';
import 'package:logsys/views/login/login_screen.dart';
import 'package:logsys/views/phone_verify/phone_verification.dart';
import 'package:logsys/views/register/register_screen.dart';

/// A list of routes for the application using the GetX package. Each
/// route is represented by a `GetPage` object, representing the app's main routes.
final List<GetPage<dynamic>> appRoutes = [
  GetPage(name: '/login', page: () => const LoginScreen()),
  GetPage(name: '/register', page: () => const RegisterScreen()),
  GetPage(name: '/home', page: () => const HomeScreen()),
  GetPage(name: '/phoneverify', page: () => const VerificationScreen1())
];
