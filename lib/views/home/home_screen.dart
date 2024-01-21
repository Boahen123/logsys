import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/models/user_model.dart';
import 'package:logsys/services/database/database_controller.dart';
import 'package:logsys/utils/constants/image_strings.dart';
import 'package:logsys/views/common_widgets/appbar.dart';
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
  late UserModel? userDetails;

  @override
  void initState() async {
    String phone = arguments?['phone'] ?? 'Default Phone';
    super.initState();
    userDetails = await DatabaseController.instance.retrieveUserData(phone);
    log('${userDetails?.fullname}');
    log('${userDetails?.phone}');
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: customAppBar(),
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
                      fullname: userDetails?.fullname ?? 'Default Name',
                      phone: userDetails?.phone ?? 'Default Phone',
                    )
                  ]))),
    );
  }
}
