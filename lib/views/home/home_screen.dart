import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/services/database/token_manager.dart';
import 'package:logsys/services/sessions/session_controller.dart';
import 'package:logsys/utils/constants/colors.dart';
import 'package:logsys/utils/constants/image_strings.dart';
import 'package:logsys/views/common_widgets/form_header.dart';
import 'package:logsys/views/home/widgets/user_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Use Get.arguments to access the arguments passed from the previous route
  Map<String, dynamic>? arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: homeAppBar(arguments?['user_id']),
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(size.width * 0.1),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FormHeaderWidget(
                      image: homeImage,
                      title: 'LogSys App',
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    UserDetails(
                        fullname: arguments?['fullname'],
                        phone: arguments?['phone'])
                  ]))),
    );
  }
}

AppBar homeAppBar(int? sessionId) => AppBar(
        foregroundColor: Colors.white,
        backgroundColor: appcolor1,
        elevation: 1.0,
        title: Center(
            child: Text(
          'LogSys',
          style: TextStyle(color: appcolor3),
        )),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text(
                    'Log out',
                    style: TextStyle(color: appcolor1),
                  ),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Cancel', style: TextStyle(color: appcolor1)),
                    ),
                    TextButton(
                      onPressed: () async {
                        log('SessionId: to remove: $sessionId');
                        await SessionController.instance
                            .removeSessionFromDb(sessionId);
                        TokenManager.removeToken();
                        Get.back();
                        Get.offAllNamed('/login');
                      },
                      child:
                          Text('Log out', style: TextStyle(color: appcolor1)),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
          )
        ]);
