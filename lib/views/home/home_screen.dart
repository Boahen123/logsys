import 'package:flutter/material.dart';
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
                    const UserDetails()
                  ]))),
    );
  }
}
