import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/firebase_options.dart';
import 'package:logsys/utils/dependency/dependency_injector.dart';
import 'package:logsys/utils/routes.dart';
import 'package:logsys/utils/theme/theme_data.dart';
import 'package:logsys/views/register/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyInjector.setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: appRoutes,
      defaultTransition: Transition.fadeIn,
      title: 'LogSys',
      theme: appTheme,
      home: const RegisterScreen(),
    );
  }
}
