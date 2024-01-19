import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logsys/utils/constants/colors.dart';

/// The `customAppBar`  returns a customized AppBar widget
AppBar customAppBar() => AppBar(
    foregroundColor: Colors.white,
    backgroundColor: appcolor1,
    elevation: 1.0,
    title: Center(
        child: Text(
      'LogSys',
      style: TextStyle(color: appcolor3),
    )),
    actions: Get.routing.current == '/home'
        ? [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout),
              tooltip: 'Log out',
            )
          ]
        : null);
