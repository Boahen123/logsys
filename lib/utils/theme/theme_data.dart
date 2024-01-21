// Defining App Theme
import 'package:flutter/material.dart';
import 'package:logsys/utils/constants/colors.dart';

final ThemeData appTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: appcolor1,
      titleTextStyle:
          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(appcolor1),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ));
