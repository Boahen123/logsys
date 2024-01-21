import 'package:get/get.dart';
import 'package:logsys/utils/constants/colors.dart';

/// The function creates a custom snackbar with a specified title and message.
SnackbarController customSnackbar(String title, String message) =>
    Get.snackbar(title, message, backgroundColor: appcolor2);
