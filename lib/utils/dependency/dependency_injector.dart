import 'package:get/get.dart';
import 'package:logsys/models/login_controller.dart';
import 'package:logsys/models/signup_controller.dart';
import 'package:logsys/services/database/database_controller.dart';

/// The `DependencyInjector` class sets up state and state controllers for the  and Login and Register Screens
class DependencyInjector {
  /// The function sets up dependencies for the SignUpController and LoginController.
  static setupDependencies() {
    Get.put<SignUpController>(SignUpController());
    Get.put(LoginController());
    Get.put(DatabaseController());
  }
}
