import 'package:get/get.dart';
import 'package:logsys/utils/constants/colors.dart';

SnackbarController customSnackbar(String title, String message) =>
    Get.snackbar(title, message, backgroundColor: appcolor2);
